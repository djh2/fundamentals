#lang class/0
(provide (all-defined-out))

;; Empty list of numbers
(define-class empty-lon%
  (define (length) 0)
  (define (map f) this))

;; Non-empty lists of numbers
(define-class cons-lon%  
  (fields first rest)
  (define (length) (add1 (send (send this rest) length)))
  (define (map f) (new cons-lon% (f (send this first)) (send (send this rest) map f))))
