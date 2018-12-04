#lang scribble/manual
@(require scribble/core racket/list)

@title[#:style 'unnumbered]{Schedule}

@(define (d s) (nonbreaking (bold s)))

@(define (htdp part name)
   (link (string-append "https://htdp.org/2018-01-06/Book/part_" part) name))

@tabular[
  #:style 'boxed 
  #:sep @hspace[1]
  #:row-properties '(bottom-border)
  (list (list @bold{Date} @bold{Topic} @bold{Reading})
        (list @d{July 8} 
              @itemlist[
                @item{Introduction; course overview}
                @item{Arithmetic of numbers and images}
                @item{Functions and programs}]
              @itemlist[
                @item{@htdp["preface.html"]{Preface}, through "Skills that Transfer"}
                @item{@htdp["one.html#%28part._ch~3abasic-arithmetic%29"]{Arithmetic}}
                @item{@htdp["one.html#%28part._ch~3afuncs-progs%29"]{Functions and Programs}}])

        (list @d{July 9} 'cont 'cont)
        (list @d{July 10} 'cont 'cont)
        (list @d{July 11} 'cont 'cont)
        (list @d{July 12} 'cont 'cont)

        (list @d{July 15} 'cont 'cont)
        (list @d{July 16} 'cont 'cont)
        (list @d{July 17} 'cont 'cont)
        (list @d{July 18} 'cont 'cont)
        (list @d{July 19} 'cont 'cont)

        (list @d{July 22} 'cont 'cont)
        (list @d{July 23} 'cont 'cont)
        (list @d{July 24} 'cont 'cont)
        (list @d{July 25} 'cont 'cont)
        (list @d{July 26} 'cont 'cont)
  )]


@;{tabular[#:style 'boxed
	 #:sep @hspace[1] 
	 #:row-properties '(bottom-border)
	 (list (list @bold{Date} @bold{Topic} @bold{Reading})
               (list @d{Aug 27} @elem{@emph{No class!}} @elem{@link["https://htdp.org/2018-01-06/Book/part_preface.html"]{Preface}, through "Skills that Transfer"})
	       (list @d{Aug 29} @elem{Introduction; course overview} @elem{@link["https://htdp.org/2018-01-06/Book/part_prologue.html"]{Prologue}})
	       (list @d{Aug 31} @elem{Arithmetic} @elem{@link["https://htdp.org/2018-01-06/Book/part_one.html#%28part._ch~3abasic-arithmetic%29"]{Arithmetic}})
	       (list @d{Sep 3} @elem{@emph{Labor Day, no class}} 'cont)
	       (list @d{Sep 5} @elem{Functions and Programs} )
	       (list @d{Sep 7} @elem{The Recipe} @elem{@link["https://htdp.org/2018-01-06/Book/part_one.html#%28part._ch~3ahtdp%29"]{How to Design Programs}})
	       (list @d{Sep 10} @elem{Designing Worlds} 'cont)
	       (list @d{Sep 12} @elem{Intervals, Enumerations, Itemizations} @elem{@link["https://htdp.org/2018-01-06/Book/part_one.html#%28part._ch~3aintervals-enums%29"]{Intervals, Enumerations, and Itemizations}})
	       (list @d{Sep 14} @elem{Structures} @elem{@link["https://htdp.org/2018-01-06/Book/part_one.html#%28part._ch~3astructure%29"]{Adding Structure}})
	       (list @d{Sep 17} @elem{Itemizations and Structures} @elem{@link["https://htdp.org/2018-01-06/Book/part_one.html#%28part._ch~3amix%29"]{Itemizations and Structures} and @link["https://htdp.org/2018-01-06/Book/part_one.html#%28part._ch~3asummary1%29"]{Summary}})
	       (list @d{Sep 19} @elem{Lists} @elem{@link["https://htdp.org/2018-01-06/Book/i1-2.html"]{Intermezzo 1: BSL} and @link["https://htdp.org/2018-01-06/Book/part_two.html#%28part._ch~3alists1%29"]{Lists}})
	       (list @d{Sep 21} @elem{Self-referential Data Definitions} @elem{@link["https://htdp.org/2018-01-06/Book/part_two.html#%28part._ch~3adesign-lists%29"]{Designing with Self-Referential Data Definitions}})
	       (list @d{Sep 24} @elem{More Lists} @elem{@link["https://htdp.org/2018-01-06/Book/part_two.html#%28part._ch~3alists2%29"]{More on Lists}})
	       (list @d{Sep 26} @elem{Design by Composition} @elem{@link["https://htdp.org/2018-01-06/Book/part_two.html#%28part._ch~3alist-sort%29"]{Design by Composition}})
	       (list @d{Sep 28} @elem{Midterm review} 'cont)
	       (list @d{Oct 1} @elem{@bold{Midterm 1}} 'cont)
	       (list @d{Oct 3} @elem{Design by Composition} @elem{@link["https://htdp.org/2018-01-06/Book/part_two.html#%28part._ch~3aproj-lists%29"]{Project: Lists} and @link["https://htdp.org/2018-01-06/Book/part_two.html#%28part._ch~3asummary2%29"]{Summary}})
	       (list @d{Oct 5} @elem{The Snake Game, Part I} @elem{@link["https://htdp.org/2018-01-06/Book/part_three.html"]{Abstraction} and @link["https://htdp.org/2018-01-06/Book/part_three.html#%28part._ch~3add-similarities%29"]{Similarities Everywhere}})
	       (list @d{Oct 8} @elem{The Snake Game, Part II} @elem{@link["https://htdp.org/2018-01-06/Book/part_three.html#%28part._ch~3aabstract%29"]{Designing Abstractions}})
	       (list @d{Oct 10} @elem{Highlights} @elem{@link["https://htdp.org/2018-01-06/Book/part_three.html#%28part._ch~3a3use%29"]{Using Abstractions}})
	       (list @d{Oct 12} @elem{Designing Abstractions, Part I} @elem{@link["https://htdp.org/2018-01-06/Book/part_three.html#%28part._ch~3a3lambda%29"]{Nameless Functions} and @link["https://htdp.org/2018-01-06/Book/part_three.html#%28part._ch~3asummary3%29"]{Summary}})
	       (list @d{Oct 15} @elem{Designing Abstractions, Part II} @elem{@link["https://htdp.org/2018-01-06/Book/i3-4.html"]{Intermezzo 3: Scope and Abstraction}})
	       (list @d{Oct 17} @elem{Using Abstractions} 'cont)
	       (list @d{Oct 19} @elem{Though Shall Not Be Named} 'cont)
	       (list @d{Oct 22} @elem{Trees} @elem{@link["https://htdp.org/2018-01-06/Book/part_four.html#%28part._ch~3apoetry-sexp%29"]{The Poetry of S-Expressions}})
	       (list @d{Oct 24} @elem{Forests, S-Expressions} 'cont)
	       (list @d{Oct 26} @elem{Designing with Intertwined Data} @elem{@link["https://htdp.org/2018-01-06/Book/part_four.html#%28part._ch~3amoney-sexp%29"]{Project: The Commerce of XML}})
	       (list @d{Oct 29} @elem{Incremental Refinement} @elem{@link["https://htdp.org/2018-01-06/Book/part_four.html#%28part._ch~3afiles%29"]{Iterative Refinement}})
	       (list @d{Oct 31} @elem{Simultaneous Processing} @elem{@link["https://htdp.org/2018-01-06/Book/part_four.html#%28part._ch~3asimu%29"]{Simultaneous Processing}})
	       (list @d{Nov 2} @elem{Non-standard Recursion} @elem{@link["https://htdp.org/2018-01-06/Book/part_five.html#%28part._ch~3astrange-recursions%29"]{Non-standard Recursion}})
	       (list @d{Nov 5} @elem{@bold{Midterm 2}} 'cont)
	       (list @d{Nov 7} @elem{Midterm Retrospective} 'cont)
	       (list @d{Nov 9} @elem{@emph{No class}} 'cont)
	       (list @d{Nov 12} @elem{Designing Algorithms} @elem{@link["https://htdp.org/2018-01-06/Book/part_five.html#%28part._ch~3adesign-algo%29"]{Designing Algorithms}})
	       (list @d{Nov 14} @elem{Variations} @elem{@link["https://htdp.org/2018-01-06/Book/part_five.html#%28part._ch~3agen-rec-samples%29"]{Variations on the Theme}})
	       (list @d{Nov 16} @elem{Backtracking} @elem{@link["https://htdp.org/2018-01-06/Book/part_five.html#%28part._ch~3abacktrack%29"]{Algorithms that Backtrack}})
	       (list @d{Nov 19} @elem{Designing Accumulator-style Functions} @elem{@link["https://htdp.org/2018-01-06/Book/part_six.html"]{Accumulators and the Loss of Knowledge}})
	       (list @d{Nov 21} @elem{@emph{Thanksgiving break, no class}} 'cont)
	       (list @d{Nov 23} @elem{@emph{Thanksgiving break, no class}} 'cont)
	       (list @d{Nov 26} @elem{Accumulating More} @elem{@link["https://htdp.org/2018-01-06/Book/part_six.html#%28part._sec~3adesign-accu%29"]{Designing Accumulator-Style Functions} and @elem{@link["https://htdp.org/2018-01-06/Book/part_six.html#%28part._ch~3amore-accu%29"]{More Uses of Accumulation}}})
	       (list @d{Nov 28} @elem{Types, Part I} 'cont)
	       (list @d{Nov 30} @elem{Types, Part II} 'cont) 
	       (list @d{Dec 3} @elem{Objects, Part I} 'cont)
	       (list @d{Dec 5} @elem{Objects, Part II} 'cont)
	       (list @d{Dec 7} @elem{Conclusions and Perspective} 'cont)
	       (list @d{Dec 10} @elem{Final Review} 'cont))]



}