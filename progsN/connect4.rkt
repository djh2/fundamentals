#lang racket
(require 2htdp/image 2htdp/universe racket/pretty lang/posn
         test-engine/racket-tests)

;; A Player is one of 'red or 'black
;; A Cell is one of Player or #f
;; A Column is (list Cell Cell Cell Cell Cell Cell)
;; columns are represented bottom = first
;; A Board is (list Column Column Column Column Column Column Column)
;; boards are represented leftmost = first
;; A Game is (game Player Board Posn)
(struct game (next board pos) #:transparent)

(define COLS 7)
(define ROWS 6)
(define WIN 4)

;; we ASSUME that there is only one column in which diagonals can win in *all* positions
;; this is true for 4x4 with WIN>=3, and 7x6 with WIN>=4
;; I don't have a general formula yet.

(define RADIUS 20)

(define SIZE 400)

(define left-margin (/ (- SIZE (* 2 RADIUS COLS)) 2))

(define empty-col (make-list ROWS #f))
(define empty-board (make-list COLS empty-col))
(define initial-game (game 'red empty-board (make-posn 0 0)))

;; render : Board -> Image
;; create a picture representing the board state
(define (render board)
  (define (render-cell cell)
    (cond [(not cell) (circle RADIUS "outline" "black")]
          [(symbol=? cell 'black) (circle RADIUS "solid" "black")]
          [(symbol=? cell 'red) (circle RADIUS "solid" "red")]))
  (define (render-col col)
    (apply above (reverse (map render-cell col))))
  (apply beside (map render-col board)))

;; list-set : Listof[X] Nat X -> Listof[X]
;; replaces the kth element of l with e
(define (list-set l k e)
  (cond [(= k 0) (cons e (rest l))]
        [else (cons (first l) (list-set (rest l) (sub1 k) e))]))

;; play : Board Nat Player -> Board or #f
;; player plays on `board' in the `col'th column
(define (play board col player)
  ;; play-col : Column Player -> Column or #f
  ;; add player's chip on top of `col', returns #f if `col' is full 
  (define (play-col col player)
    (cond [(empty? col)
           #f]
          [(not (first col))
           (cons player (rest col))]
          [else
           (let ([p (play-col (rest col) player)])
             (and p (cons (first col) p)))]))
  (define new-col (play-col (list-ref board col) player))
  (if new-col
      (list-set board col new-col)
      #f))

;; flip-player : Player -> Player
;; get the next player
(define (flip-player pl)
  (cond [(symbol=? 'red pl) 'black]
        [else 'red]))

;; play-turn : Game Nat -> Game
;; current player plays in `col', producing a new game state
;; if the move is illegal, game state doesn't change
(define (play-turn g col)
  (define new-board (play (game-board g) col (game-next g)))
  (if new-board
      (game (flip-player (game-next g)) new-board (game-pos g))
      g))

(define (winner-col? c)
  (let loop ([c c] [cnt 0] [color #f])
    (cond 
      [(= WIN cnt) #t]
      [(empty? c) #f]
      [(not (first c)) (loop (rest c) 0 #f)]
      [(and color (symbol=? color (first c))) (loop (rest c) (add1 cnt) color)]
      [else (loop (rest c) 1 (first c))])))

(define (transpose b)
  (apply map list b))

(define (snoc v l) (append l (list v)))

(define (adjust-column c i)  
  (cond 
    [(< i 0) (append (make-list (abs i) #f) (take c (+ ROWS i)))]
    [(= i 0) c]
    [else (append (drop c i) (make-list i #f))]))

;; Board -> Board
(define (diagonalize b)
  (define small (quotient COLS 2))
  (for/list ([c (in-list b)]
             [i (in-range (- small) (- COLS small))])
    (adjust-column c i)))

(define (win-cols? b) (ormap winner-col? b))
(define (win-rows? b) (win-cols? (transpose b)))
(define (win-riser? b) (win-rows? (diagonalize b)))
(define (win-sinker? b) (win-riser? (reverse b)))

;; winner? : Game -> Boolean
;; has someone won the game?
(define (winner? g)
  (define b (game-board g))
  (or (win-cols? b) (win-rows? b) (win-riser? b) (win-sinker? b)))
  
(check-expect (winner? (game
                        'black
                        '((#f #f #f #f #f #f)
                          (#f #f #f #f #f #f)
                          (#f #f #f #f #f #f)
                          (red black red red #f #f)
                          (black red red #f #f #f)
                          (black red #f #f #f #f)
                          (red black black black #f #f))
                        (make-posn 83 -7)))
              #t)

(define (full? col)
  (not (member #f col)))

(define (has-winning-move? g)
  (for/or ([i (in-range COLS)]
           #:when (winner? (play-turn g i)))
    i))

(define (random-index-of status sym)
  (choose (for/list ([(s i) (in-indexed status)] #:when (eq? s sym))
            i)))

(define (pick-move g)
  (define status (evaluate g))
  (or (random-index-of status 'win)
      (random-index-of status 'unknown)
      (random-index-of status 'lose)))
       
(define (choose l) (if (null? l) #f (list-ref l (random (length l)))))

(define (evaluate g)
  (for/list ([i (in-range COLS)])
    (cond [(full? (list-ref (game-board g) i)) 'full]
          [(winner? (play-turn g i)) 'win]
          [(has-winning-move? (play-turn g i)) 'lose]
          [else 'unknown])))

;; Game -> Scene
(define (render-game g)
  (define next (cond [(symbol=? (game-next g) 'black) (circle RADIUS "solid" "black")]
                     [(symbol=? (game-next g) 'red) (circle RADIUS "solid" "red")]))
  (define board-scene (place-image (render (game-board g))
                                   (/ SIZE 2) 150
                                   (empty-scene SIZE SIZE)))
  (if (winner? g)
      board-scene
      (place-image
       next
       (posn-x (game-pos g)) (posn-y (game-pos g))
       board-scene)))

;; Game KeyEvent -> Game
;; play in the column denoted by `k'
(define (handle-key g k)
  (when (equal? "p" k) (pretty-print g))
  (define n (string->number k))
  (if (and n (<= 1 n 7))
      (play-turn g (sub1 n))
      g))

(define (all-full? g) (andmap full? (game-board g)))

;; Game -> Scene
(define (render-winner g)
  (define w (flip-player (game-next g)))
  (define s (render-game g))
  (define str
    (cond 
      [(all-full? g) (text "The Game is a Tie." 36 "green")]
      [(symbol=? w 'black) (text "Black Player Wins!" 36 "green")]
      [(symbol=? w 'red) (text "Red Player Wins!" 36 "green")]))
  (overlay str s))

(define (handle-mouse g x y e)
  (cond [(mouse=? e "button-up")
         (define played (play-turn g (quotient (- x left-margin) (* 2 RADIUS))))
         (if (winner? played)
             played
             (play-turn played (pick-move played)))]
        [else (game (game-next g) (game-board g) (make-posn x y))]))

(define (go)
  (big-bang
   initial-game
   (to-draw render-game)
   #;(on-key handle-key)
   (on-mouse handle-mouse)
   (stop-when (λ (g) (or (winner? g) (all-full? g))) render-winner)))

(test)