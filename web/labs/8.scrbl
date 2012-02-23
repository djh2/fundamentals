#lang scribble/manual

@(require "../lab.rkt"
          "../unnumbered.rkt"
          "../utils.rkt")

@(define exercise (exercise-counter))

@title[#:tag "lab8"]{2/27: Java, Dictionaries, and the Internet}

@itemlist[
  @item{Download @tt{prima-1.2.3.jar} from
        @url{http://code.google.com/p/nutester}.}
]

@lab:section{Warmup: same data, different language}

Think back to lab 5, in which we built several implementations of the
Dictionary interface. In case you don't remember, here's the interface
again, but in Java:

@indented{@verbatim|{
  // A Key is a String
  //
  // A Dict<V> implements
  //
  // has-key : Key -> Boolean
  // Does the given key exist?
  //
  // lookup : Key -> V
  // The value mapped to by the given key
  //
  // set : Key V -> Dict<V>
  // Set the given key-value mapping
}|}

Note that we have removed the assumption for lookup that the key is
in the dictionary. It turns out that, unlike in @racket{class/0},
Java forces us to implement @tt{lookup} for all classes that implement
the @tt{Dict} interface.

Instead of leaving the method unimplemented, you can just define
the method to return an error when there is no key. In Java, you
can return an error with a statement like this:
@verbatim|{throw new RuntimeException("Error message");}|

@exercise{
  Implement a @tt{Dict} in Java using the SortedListDict design from lab 5.
  Make sure to translate the data definition to the Java syntax first.

  You may find the @tt{compareTo} method on Strings useful for this exercise.

  (NB: you could easily do any of the designs from lab 5, but we'll use
       SortedListDicts later)
}

There are several other operations that you might want in a
good library for dictionaries. For example, you may want to be able
to extract just the keys or values contained in a dictionary:

@indented{@verbatim|{
  // keys : -> ListOf<Key>
  // return the keys in the dictionary
  //
  // values : -> ListOf<V>
  // return the values in the dictionary
}|}

@exercise{
  Implement the @tt{keys} and @tt{values} methods above.
}

Another thing you might want to do is run a function to update the value mapped
by a particular key (instead of just providing the new value). Since Java
doesn’t have higher-order functions, we will simulate them with objects. Here’s
an interface defintion for a unary function from X to Y:

@indented{@verbatim|{
  // A Fun<X,Y> implements:
  //
  // call : X -> Y
  // Call this function on its X input and produce a Y
}|}

Let's use this to define a new method for dictionaries.

@indented{@verbatim|{
  // Dict<V> also implements:
  //
  // update : Key Fun<V, V> -> Dict<V>
  // run the given function to get a new value for key
}|}

One problem with the data definition above is that it only lets you
use keys that are @tt{Nat}s. Since the only operation that we need
for the key is that it lets us check if two keys are equal, let's
build that into our data definitions:

@indented{@verbatim|{
  // An Eq implements
  //
  // equals : Eq -> Boolean
}|}

We chose the name @tt{equals} because all of the built-in classes
like @tt{Integer} and @tt{String} in Java implements it.

@indented{@verbatim|{
  // A EqDict<V> implements
  //
  // has-key : Eq -> Boolean
  // Does the given key exist?
  //
  // lookup : Eq -> V
  // The value mapped to by the given key
  // Assumption: the key exists
  //
  // set : Eq V -> Dict<V>
  // Set the given key-value mapping
}|}

@exercise{
  Create a new dictionary that uses this new data definition.
}

@lab:section{Another kind of dictionary}

We've seen various implementations of dictionaries, but are they good for
representing real dictionaries like the Merriam-Webster Dictionary that store
words? You might think that since these dictionaries are specialized to
work with words, you could design a faster data structure for them.

Well, it turns out you can. We will design a data structure called a "trie"
(pronounced "tree" or "try") that is highly efficient for storing words.
Here is the data definition for a trie:

@indented{@verbatim|{
  // A Trie<V> is one of
  //  - new NoValue(SortedListDict<Trie<V>>)
  //  - new Node(V, SortedListDict<Trie<V>>)
  // and implements Dict<V>
  //
  // where the keys in the SortedListDict are all single-character strings
}|}

As you can see from the data definition, each trie node stores a dictionary of
its child nodes keyed by single characters.  Imagine each connection from a
node to its child as representing one character in a string. When you lookup a
string in a trie, you look at the first character in the string and continue to
lookup in the corresponding sub-trie. The path you take down the tree will
spell out the string you are looking up.

NB: the children can be stored in any Dict<V> unless you care about them
being sorted. It turns out we need that for a later exercise.

The advantage of this representation is that the time it takes to lookup
any string is proportional to the length of the string. This is faster than
a binary search tree in general.

@exercise{
  Implement Trie and all of its methods.
}

One of the operations that a trie makes very fast is searching for all key/value
pairs that matches a certain prefix of a key (a prefix is just a substring of
a string that includes the beginning). This kind of operation is useful if you
want to search through a dictionary.

Here is a contract for a function that search the dictionary based on a prefix:

@indented{@verbatim|{
  // matchPrefix : String -> ListOf<String>
  // Finds all keys that match the given prefix
}|}

@exercise{
  Implement @tt{matchPrefix}.
}

Another application of tries is a fast sorting algorithm on strings. Let's
say you have a data definition of a List of Strings that supports lexicographical
sorting:

@indented{@verbatim|{
  // An LoS is one of
  //  - new MTList()
  //  - new Cons(String, LoS)
  // and implements
  //
  // sort : -> LoS
  // returns a sorted list in lexicographic order
}|}

One way to implement @tt{sort} is to insert each of the list items into a trie
and then do a so-called "pre-order" fold over the trie ("pre-order" just means
that the fold visits the node first, then visits its children from left to
right). Since the children of a trie node are represented using a SortedListDict,
let's first write a method to fold over it.

@indented{@verbatim|{
  // A SortedListDict<V> also implements
  //
  // fold<X> : Fun2<V, X, X> X -> X
  // fold over this list
}|}

Remember the @tt{Fun} interface from earlier? We can do the
same thing for binary functions:

@indented{@verbatim|{
  // A Fun2<X,Y,Z> implements:
  //
  // call : X Y -> Z
  // Call this function on its X and Y inputs and produce a Z
}|}

@exercise{
  Implement the fold operation on sorted lists.
}

Now let's define a method for folding over the trie:

@indented{@verbatim|{
  // A Trie<V> also implements:
  //
  // preOrder<X> : Fun2<V, X, X> X -> X
  // do a pre-order fold over the trie
}|}

@exercise{
  Implement the @tt{preOrder} method. You'll need to use the @tt{fold}
  method you defined on lists earlier.
}

Now you can implement the @tt{sort} method on lists of strings by delegating
to a trie.

@exercise{
  Implement @tt{sort} via delegation to a trie.
}

At this point, you might be thinking this was a roundabout way of defining
sorting. After all, don't we already have a way to sort lists using the
SortedListDict? While that's true, sorting using a trie can be much faster.
The fastest known algorithm for sorting strings, called Burstsort, is based
on tries.

@lab:section{Tries and the Internet}

Changing gears, let's talk about the Internet. The Internet is run by a stack
of many protocols like IP, TCP, UDP, DNS, and so on. These protocols define
an interface for interacting with services and websites on the internet.

@indented{@verbatim|{
  // A Bit is an Integer that's either 0 or 1
  //
  // A BitList is one of
  //  - new BitMt()
  //  - new BitCons(Bit, BitList)
  // and implements
  //
  // toInteger : -> Integer
}|}

@indented{@verbatim|{
  // A Quad is an Integer
  //
  // A IPAddress is a
  //  - new IPAddress(Quad, Quad, Quad, Quad)
  // and implements
  //
  // getQuad : Integer -> Integer
  // where the argument is between 0 and 3
  //
  // toList : -> BitList
}|}

As you load this lab webpage on your computer, the web server at Northeastern
and your computer are sending packets back and forth using TCP & IP. How do
these packets get to your computer? The machines in between "route" incoming
packets to you and outgoing packets to the server.

To perform this task, servers store a @emph{routing table} that tells the
server how to route each packet. Since storing every possible address
(4,294,967,296 for IP version 4) is a bad idea, servers store routes by
"prefix". That is, addresses that share the same beginning are routed the
same way.

Tries can be used to represent these tables since a trie allows routes
that share prefixes to use the same space. This requires specializing
the trie data definition for IP prefixes.
