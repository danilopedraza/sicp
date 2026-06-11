#set page(
  paper: "a6",
  margin: (x: 1cm, y: 1.5cm),
  header: align(right, text(8pt, style: "italic")[Structure and Interpretation of Computer Programs]),
  footer: align(center, context(counter(page).display())),
)

#set text(
  // font: ("Linux Libertine", "DejaVu Serif", "serif"),
  size: 8pt,
)

#set heading(numbering: "1.")

// Title Page
#align(center + horizon)[
  #text(16pt, weight: "bold")[Structure and Interpretation \ of Computer Programs]
  
  #v(1em)
  #text(12pt)[Second Edition]
  
  #v(1em)
  #text(10pt)[Unofficial Typst Format]
  
  #v(2em)
  #text(11pt)[
    Harold Abelson and Gerald Jay Sussman \
    with Julie Sussman \
    foreword by Alan J. Perlis
  ]
]

#pagebreak()

// Copyright Page
#set page(numbering: none)
#align(bottom)[
  #set text(size: 8pt)
  Copyright © 1996 by The Massachusetts Institute of Technology

  This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License (CC BY-SA 4.0). Based on a work at mitpress.mit.edu.

  The MIT Press \
  Cambridge, Massachusetts \
  London, England

  McGraw-Hill Book Company \
  New York, St. Louis, San Francisco, \
  Montreal, Toronto

  Unofficial Typst Format, based on Unofficial Texinfo Format.
]

#pagebreak()
#set page(numbering: "i")
#counter(page).update(1)

// Outline
#outline(indent: auto)

#pagebreak()

// Unofficial Format Intro
#heading(level: 1, numbering: none)[Unofficial Typst Format]

This is the second edition SICP book, from Unofficial Typst Format.

The freely-distributed official HTML-and-GIF format was first converted personally to Unofficial Texinfo Format (UTF) version 1 by Lytha Ayth during a long Emacs lovefest weekend in April, 2001.

The UTF is easier to search than the HTML format. It is also much more accessible to people running on modest computers, such as donated '386-based PCs. A 386 can, in theory, run Linux, Emacs, and a Scheme interpreter simultaneously, but most 386s probably can't also run both Netscape and the necessary X Window System without prematurely introducing budding young underfunded hackers to the concept of *thrashing*.

#pagebreak()

#heading(level: 1, numbering: none)[Dedication]

This book is dedicated, in respect and admiration, to the spirit that lives in the computer.

#quote(block: true, attribution: [Alan J. Perlis (April 1, 1922 -- February 7, 1990)])[
  "I think that it's extraordinarily important that we in computer science keep
  fun in computing. When it started out, it was an awful lot of fun. Of course,
  the paying customers got shafted every now and then, and after a while we began
  to take their complaints seriously. We began to feel as if we really were
  responsible for the successful, error-free perfect use of these machines. I
  don't think we are. I think we're responsible for stretching them, setting
  them off in new directions, and keeping fun in the house. I hope the field of
  computer science never loses its sense of fun. Above all, I hope we don't
  become missionaries. Don't feel as if you're Bible salesmen. The world has
  too many of those already. What you know about computing other people will
  learn. Don't feel as if the key to successful computing is only in your hands.
  What's in your hands, I think and hope, is intelligence: the ability to see the
  machine as more than when you were first led up to it, that you can make it
  more."
]

#pagebreak()

#heading(level: 1, numbering: none)[Foreword]

Educators, generals, dieticians, psychologists, and parents program. Armies, students, and some societies are programmed. An assault on large problems employs a succession of programs, most of which spring into existence en route. These programs are rife with issues that appear to be particular to the problem at hand. To appreciate programming as an intellectual activity in its own right you must turn to computer programming; you must read and write computer programs---many of them. It doesn't matter much what the programs are about or what applications they serve. What does matter is how well they perform and how smoothly they fit with other programs in the creation of still greater programs.

#pagebreak()
#set page(numbering: "1")
#counter(page).update(1)

#heading(level: 1)[Building Abstractions with Procedures]

#quote(block: true, attribution: [John Locke, _An Essay Concerning Human Understanding_ (1690)])[
  The acts of the mind, wherein it exerts its power over simple ideas, are chiefly these three: 1. Combining several simple ideas into one compound one, and thus all complex ideas are made. 2. The second is bringing two ideas, whether simple or complex, together, and setting them by one another so as to take a view of them at once, without uniting them into one, by which it gets all its ideas of relations. 3. The third is separating them from all other ideas that accompany them in their real existence: this is called abstraction, and thus all its general ideas are made.
]

We are about to study the idea of a *computational process*. Computational processes are abstract beings that inhabit computers. As they evolve, processes manipulate other abstract things called *data*. The evolution of a process is directed by a pattern of rules called a *program*. People create programs to direct processes. In effect, we conjure the spirits of the computer with our spells.

== The Elements of Programming

A powerful programming language is more than just a means for instructing a computer to perform tasks. The language also serves as a framework within which we organize our ideas about processes. Thus, when we describe a language, we should pay particular attention to the means that the language provides for combining simple ideas to form more complex ideas. Every powerful language has three mechanisms for accomplishing this:

- *primitive expressions*, which represent the simplest entities the language is concerned with,
- *means of combination*, by which compound elements are built from simpler ones, and
- *means of abstraction*, by which compound elements can be named and manipulated as units.

In programming, we deal with two kinds of elements: procedures and data. (Later we will discover that they are really not so distinct.) Informally, data is "stuff" that we want to manipulate, and procedures are descriptions of the rules for manipulating the data. Thus, any powerful programming language should be able to describe primitive data and primitive procedures and should have methods for combining and abstracting procedures and data.

In this chapter we will deal only with simple numerical data so that we can focus on the rules for building procedures. In later chapters we will see that these same rules allow us to build procedures to manipulate compound data as well.

=== Expressions

One easy way to get started at programming is to examine some typical interactions with an interpreter for the Scheme dialect of Lisp. Imagine that you are sitting at a computer terminal. You type an *expression*, and the interpreter responds by displaying the result of its *evaluating* that expression.

One kind of primitive expression you might type is a number. (More precisely, the expression that you type consists of the numerals that represent the number in base 10.) If you present Lisp with a number

```scm
486
```

the interpreter will respond by printing

```scm
486
```

Expressions representing numbers may be combined with an expression representing a primitive procedure (such as `+` or `*`) to form a compound expression that represents the application of the procedure to those numbers. For example:

```scm
(+ 137 349)
486

(- 1000 334)
666

(* 5 99)
495

(/ 10 5)
2

(+ 2.7 10)
12.7
```

Expressions such as these, formed by delimiting a list of expressions within parentheses in order to denote procedure application, are called *combinations*. The leftmost element in the list is called the *operator*, and the other elements are called *operands*. The value of a combination is obtained by applying the procedure specified by the operator to the *arguments* that are the values of the operands.

The convention of placing the operator to the left of the operands is known as *prefix notation*, and it may be somewhat confusing at first because it departs significantly from the customary mathematical convention. Prefix notation has several advantages, however. One of them is that it can accommodate procedures that may take an arbitrary number of arguments, as in the following examples:

```scm
(+ 21 35 12 7)
75

(* 25 4 12)
1200
```

No ambiguity can arise, because the operator is always the leftmost element and the entire combination is delimited by the parentheses.

A second advantage of prefix notation is that it extends in a straightforward way to allow combinations to be *nested*, that is, to have combinations whose elements are themselves combinations:

```scm
(+ (* 3 5) (- 10 6))
19
```

There is no limit (in principle) to the depth of such nesting and to the overall complexity of the expressions that the Lisp interpreter can evaluate. It is we humans who get confused by still relatively simple expressions such as

```scm
(+ (* 3 (+ (* 2 4) (+ 3 5))) (+ (- 10 7) 6))
```

which the interpreter would readily evaluate to be 57. We can help ourselves by writing such an expression in the form

```scm
(+ (* 3
      (+ (* 2 4)
         (+ 3 5)))
   (+ (- 10 7)
      6))
```

following a formatting convention known as *pretty-printing*, in which each long combination is written so that the operands are aligned vertically. The resulting indentations display clearly the structure of the expression.

Even with complex expressions, the interpreter always operates in the same basic cycle: It reads an expression from the terminal, evaluates the expression, and prints the result. This mode of operation is often expressed by saying that the interpreter runs in a *read-eval-print loop*. Observe in particular that it is not necessary to explicitly instruct the interpreter to print the value of the expression.

=== Naming and the Environment

A critical aspect of a programming language is the means it provides for using names to refer to computational objects. We say that the name identifies a *variable* whose *value* is the object.

In the Scheme dialect of Lisp, we name things with `define`. Typing

```scm
(define size 2)
```

causes the interpreter to associate the value 2 with the name `size`. Once the name `size` has been associated with the number 2, we can refer to the value 2 by name:

```scm
size
2

(* 5 size)
10
```

Here are further examples of the use of `define`:

```scm
(define pi 3.14159)
(define radius 10)

(* pi (* radius radius))
314.159

(define circumference (* 2 pi radius))

circumference
62.8318
```

`Define` is our language's simplest means of abstraction, for it allows us to use simple names to refer to the results of compound operations, such as the `circumference` computed above. In general, computational objects may have very complex structures, and it would be extremely inconvenient to have to remember and repeat their details each time we want to use them. Indeed, complex programs are constructed by building, step by step, computational objects of increasing complexity. The interpreter makes this step-by-step program construction particularly convenient because name-object associations can be created incrementally in successive interactions. This feature encourages the incremental development and testing of programs and is largely responsible for the fact that a Lisp program usually consists of a large number of relatively simple procedures.

It should be clear that the possibility of associating values with symbols and later retrieving them means that the interpreter must maintain some sort of memory that keeps track of the name-object pairs. This memory is called the *environment* (more precisely the *global environment*, since we will see later that a computation may involve a number of different environments).

=== Evaluating Combinations

One of our goals in this chapter is to isolate issues about thinking procedurally. As a case in point, let us consider that, in evaluating combinations, the interpreter is itself following a procedure.

#quote(block: true)[
  To evaluate a combination, do the following:

  1. Evaluate the subexpressions of the combination.

  2. Apply the procedure that is the value of the leftmost subexpression (the operator) to the arguments that are the values of the other subexpressions (the operands).
]

Even this simple rule illustrates some important points about processes in general. First, observe that the first step dictates that in order to accomplish the evaluation process for a combination we must first perform the evaluation process on each element of the combination. Thus, the evaluation rule is *recursive* in nature; that is, it includes, as one of its steps, the need to invoke the rule itself.

Notice how succinctly the idea of recursion can be used to express what, in the case of a deeply nested combination, would otherwise be viewed as a rather complicated process. For example, evaluating

```scm
(* (+ 2 (* 4 6)) (+ 3 5 7))
```

requires that the evaluation rule be applied to four different combinations. We can obtain a picture of this process by representing the combination in the form of a tree. Each combination is represented by a node with branches corresponding to the operator and the operands of the combination stemming from it. The terminal nodes (that is, nodes with no branches stemming from them) represent either operators or numbers. Viewing evaluation in terms of the tree, we can imagine that the values of the operands percolate upward, starting from the terminal nodes and then combining at higher and higher levels. In general, we shall see that recursion is a very powerful technique for dealing with hierarchical, treelike objects. In fact, the "percolate values upward" form of the evaluation rule is an example of a general kind of process known as *tree accumulation*.

#figure(
  ```
     390
     /|\____________
    / |             \
   *  26            15
      /|\           /|\
     / | \         // \\
    +  2  24      / | | \
          /|\    +  3 5  7
         / | \
        *  4  6
  ```,
  caption: [Tree representation, showing the value of each subcombination.],
)

Next, observe that the repeated application of the first step brings us to the point where we need to evaluate, not combinations, but primitive expressions such as numerals, built-in operators, or other names. We take care of the primitive cases by stipulating that

- the values of numerals are the numbers that they name,
- the values of built-in operators are the machine instruction sequences that carry out the corresponding operations, and
- the values of other names are the objects associated with those names in the environment.

We may regard the second rule as a special case of the third one by stipulating that symbols such as `+` and `*` are also included in the global environment, and are associated with the sequences of machine instructions that are their "values." The key point to notice is the role of the environment in determining the meaning of the symbols in expressions. In an interactive language such as Lisp, it is meaningless to speak of the value of an expression such as `(+ x 1)` without specifying any information about the environment that would provide a meaning for the symbol `x` (or even for the symbol `+`).

Notice that the evaluation rule given above does not handle definitions. For instance, evaluating `(define x 3)` does not apply `define` to two arguments, one of which is the value of the symbol `x` and the other of which is 3, since the purpose of the `define` is precisely to associate `x` with a value. (That is, `(define x 3)` is not a combination.)

Such exceptions to the general evaluation rule are called *special forms*. `Define` is the only example of a special form that we have seen so far, but we will meet others shortly. Each special form has its own evaluation rule. The various kinds of expressions (each with its associated evaluation rule) constitute the syntax of the programming language. In comparison with most other programming languages, Lisp has a very simple syntax.

=== Compound Procedures

We have identified in Lisp some of the elements that must appear in any powerful programming language:

- Numbers and arithmetic operations are primitive data and procedures.
- Nesting of combinations provides a means of combining operations.
- Definitions that associate names with values provide a limited means of abstraction.

Now we will learn about *procedure definitions*, a much more powerful abstraction technique by which a compound operation can be given a name and then referred to as a unit.

We begin by examining how to express the idea of "squaring." We might say, "To square something, multiply it by itself." This is expressed in our language as

```scm
(define (square x) (* x x))
```

We can understand this in the following way:

```scm
(define (square x)    (*       x       x))
  |      |      |      |       |       |
 To square something, multiply it by itself.
```

We have here a *compound procedure*, which has been given the name `square`. The procedure represents the operation of multiplying something by itself. The thing to be multiplied is given a local name, `x`, which plays the same role that a pronoun plays in natural language. Evaluating the definition creates this compound procedure and associates it with the name `square`.

The general form of a procedure definition is

```scm
(define (<name> <formal parameters>) <body>)
```

The `<name>` is a symbol to be associated with the procedure definition in the environment. The `<formal parameters>` are the names used within the body of the procedure to refer to the corresponding arguments of the procedure. The `<body>` is an expression that will yield the value of the procedure application when the formal parameters are replaced by the actual arguments to which the procedure is applied. The `<name>` and the `<formal parameters>` are grouped within parentheses, just as they would be in an actual call to the procedure being defined.

Having defined `square`, we can now use it:

```scm
(square 21)
441

(square (+ 2 5))
49

(square (square 3))
81
```

We can also use `square` as a building block in defining other procedures. For example, $x^2 + y^2$ can be expressed as

```scm
(+ (square x) (square y))
```

We can easily define a procedure `sum-of-squares` that, given any two numbers as arguments, produces the sum of their squares:

```scm
(define (sum-of-squares x y)
  (+ (square x) (square y)))

(sum-of-squares 3 4)
25
```

Now we can use `sum-of-squares` as a building block in constructing further procedures:

```scm
(define (f a)
  (sum-of-squares (+ a 1) (* a 2)))

(f 5)
136
```

Compound procedures are used in exactly the same way as primitive procedures. Indeed, one could not tell by looking at the definition of `sum-of-squares` given above whether `square` was built into the interpreter, like `+` and `*`, or defined as a compound procedure.

=== The Substitution Model for Procedure Application

To evaluate a combination whose operator names a compound procedure, the interpreter follows much the same process as for combinations whose operators name primitive procedures, which we described in Section 1.1.3. That is, the interpreter evaluates the elements of the combination and applies the procedure (which is the value of the operator of the combination) to the arguments (which are the values of the operands of the combination).

We can assume that the mechanism for applying primitive procedures to arguments is built into the interpreter. For compound procedures, the application process is as follows:

#quote(block: true)[
  To apply a compound procedure to arguments, evaluate the body of the procedure with each formal parameter replaced by the corresponding argument.
]

To illustrate this process, let's evaluate the combination

```scm
(f 5)
```

where `f` is the procedure defined in Section 1.1.4. We begin by retrieving the body of `f`:

```scm
(sum-of-squares (+ a 1) (* a 2))
```

Then we replace the formal parameter `a` by the argument 5:

```scm
(sum-of-squares (+ 5 1) (* 5 2))
```

Thus the problem reduces to the evaluation of a combination with two operands and an operator `sum-of-squares`. Evaluating this combination involves three subproblems. We must evaluate the operator to get the procedure to be applied, and we must evaluate the operands to get the arguments. Now `(+ 5 1)` produces 6 and `(* 5 2)` produces 10, so we must apply the `sum-of-squares` procedure to 6 and 10. These values are substituted for the formal parameters `x` and `y` in the body of `sum-of-squares`, reducing the expression to

```scm
(+ (square 6) (square 10))
```

If we use the definition of `square`, this reduces to

```scm
(+ (* 6 6) (* 10 10))
```

which reduces by multiplication to

```scm
(+ 36 100)
```

and finally to

```scm
136
```

The process we have just described is called the *substitution model* for procedure application. It can be taken as a model that determines the "meaning" of procedure application, insofar as the procedures in this chapter are concerned. However, there are two points that should be stressed:

- The purpose of the substitution is to help us think about procedure application, not to provide a description of how the interpreter really works. Typical interpreters do not evaluate procedure applications by manipulating the text of a procedure to substitute values for the formal parameters. In practice, the "substitution" is accomplished by using a local environment for the formal parameters.

- Over the course of this book, we will present a sequence of increasingly elaborate models of how interpreters work, culminating with a complete implementation of an interpreter and compiler in Chapter 5. The substitution model is only the first of these models---a way to get started thinking formally about the evaluation process.

==== Applicative order versus normal order

According to the description of evaluation given in Section 1.1.3, the interpreter first evaluates the operator and operands and then applies the resulting procedure to the resulting arguments. This is not the only way to perform evaluation. An alternative evaluation model would not evaluate the operands until their values were needed. Instead it would first substitute operand expressions for parameters until it obtained an expression involving only primitive operators, and would then perform the evaluation. If we used this method, the evaluation of `(f 5)` would proceed according to the sequence of expansions

```scm
(sum-of-squares (+ 5 1) (* 5 2))

(+ (square (+ 5 1)) 
   (square (* 5 2)))

(+ (* (+ 5 1) (+ 5 1)) 
   (* (* 5 2) (* 5 2)))
```

followed by the reductions

```scm
(+ (* 6 6) 
   (* 10 10))

(+ 36 100)

136
```

This gives the same answer as our previous evaluation model, but the process is different. In particular, the evaluations of `(+ 5 1)` and `(* 5 2)` are each performed twice here, corresponding to the reduction of the expression `(* x x)` with `x` replaced respectively by `(+ 5 1)` and `(* 5 2)`.

This alternative "fully expand and then reduce" evaluation method is known as *normal-order evaluation*, in contrast to the "evaluate the arguments and then apply" method that the interpreter actually uses, which is called *applicative-order evaluation*. It can be shown that, for procedure applications that can be modeled using substitution (including all the procedures in the first two chapters of this book) and that yield legitimate values, normal-order and applicative-order evaluation produce the same value.

Lisp uses applicative-order evaluation, partly because of the additional efficiency obtained from avoiding multiple evaluations of expressions such as those illustrated with `(+ 5 1)` and `(* 5 2)` above and, more significantly, because normal-order evaluation becomes much more complicated to deal with when we leave the realm of procedures that can be modeled by substitution. On the other hand, normal-order evaluation can be an extremely valuable tool, and we will investigate some of its implications in Chapter 3 and Chapter 4.

=== Conditional Expressions and Predicates

The expressive power of the class of procedures that we can define at this point is very limited, because we have no way to make tests and to perform different operations depending on the result of a test. For instance, we cannot define a procedure that computes the absolute value of a number by testing whether the number is positive, negative, or zero and taking different actions in the different cases according to the rule

$ |x| = cases(
  x & "if" x > 0,
  0 & "if" x = 0,
  -x & "if" x < 0
) $

This construct is called a *case analysis*, and there is a special form in Lisp for notating such a case analysis. It is called `cond` (which stands for "conditional"), and it is used as follows:

```scm
(define (abs x)
  (cond ((> x 0) x)
        ((= x 0) 0)
        ((< x 0) (- x))))
```

The general form of a conditional expression is

```scm
(cond (<p1> <e1>)
      (<p2> <e2>)
      ...
      (<pn> <en>))
```

consisting of the symbol `cond` followed by parenthesized pairs of expressions

```scm
(<p> <e>)
```

called *clauses*. The first expression in each pair is a *predicate*---that is, an expression whose value is interpreted as either true or false.

Conditional expressions are evaluated as follows. The predicate $p_1$ is evaluated first. If its value is false, then $p_2$ is evaluated. If $p_2$'s value is also false, then $p_3$ is evaluated. This process continues until a predicate is found whose value is true, in which case the interpreter returns the value of the corresponding *consequent expression* $e$ of the clause as the value of the conditional expression. If none of the $p$'s is found to be true, the value of the `cond` is undefined.

The word *predicate* is used for procedures that return true or false, as well as for expressions that evaluate to true or false. The absolute-value procedure `abs` makes use of the primitive predicates `>`, `<`, and `=`. These take two numbers as arguments and test whether the first number is, respectively, greater than, less than, or equal to the second number, returning true or false accordingly.

Another way to write the absolute-value procedure is

```scm
(define (abs x)
  (cond ((< x 0) (- x))
        (else x)))
```

which could be expressed in English as "If $x$ is less than zero return $-x$; otherwise return $x$." `Else` is a special symbol that can be used in place of the $p$ in the final clause of a `cond`. This causes the `cond` to return as its value the value of the corresponding $e$ whenever all previous clauses have been bypassed.

Here is yet another way to write the absolute-value procedure:

```scm
(define (abs x)
  (if (< x 0)
      (- x)
      x))
```

This uses the special form `if`, a restricted type of conditional that can be used when there are precisely two cases in the case analysis. The general form of an `if` expression is

```scm
(if <predicate> <consequent> <alternative>)
```

To evaluate an `if` expression, the interpreter starts by evaluating the `<predicate>` part of the expression. If the `<predicate>` evaluates to a true value, the interpreter then evaluates the `<consequent>` and returns its value. Otherwise it evaluates the `<alternative>` and returns its value.

In addition to primitive predicates such as `<`, `=`, and `>`, there are logical composition operations, which enable us to construct compound predicates. The three most frequently used are these:

- `(and <e1> ... <en>)`
  The interpreter evaluates the expressions `<e>` one at a time, in left-to-right order. If any `<e>` evaluates to false, the value of the `and` expression is false, and the rest of the `<e>`'s are not evaluated. If all `<e>`'s evaluate to true values, the value of the `and` expression is the value of the last one.

- `(or <e1> ... <en>)`
  The interpreter evaluates the expressions `<e>` one at a time, in left-to-right order. If any `<e>` evaluates to a true value, that value is returned as the value of the `or` expression, and the rest of the `<e>`'s are not evaluated. If all `<e>`'s evaluate to false, the value of the `or` expression is false.

- `(not <e>)`
  The value of a `not` expression is true when the expression `<e>` evaluates to false, and false otherwise.

Notice that `and` and `or` are special forms, not procedures, because the subexpressions are not necessarily all evaluated. `Not` is an ordinary procedure.

As an example of how these are used, the condition that a number $x$ be in the range $5 < x < 10$ may be expressed as

```scm
(and (> x 5) (< x 10))
```

As another example, we can define a predicate to test whether one number is greater than or equal to another as

```scm
(define (>= x y) 
  (or (> x y) (= x y)))
```

or alternatively as

```scm
(define (>= x y) 
  (not (< x y)))
```

#block(fill: luma(240), inset: 10pt, radius: 4pt)[
  *Exercise 1.1:* Below is a sequence of expressions. What is the result printed by the interpreter in response to each expression? Assume that the sequence is to be evaluated in the order in which it is presented.

  ```scm
  10
  (+ 5 3 4)
  (- 9 1)
  (/ 6 2)
  (+ (* 2 4) (- 4 6))
  (define a 3)
  (define b (+ a 1))
  (+ a b (* a b))
  (= a b)
  (if (and (> b a) (< b (* a b)))
      b
      a)
  (cond ((= a 4) 6)
        ((= b 4) (+ 6 7 a))
        (else 25))
  (+ 2 (if (> b a) b a))
  (* (cond ((> a b) a)
           ((< a b) b)
           (else -1))
     (+ a 1))
  ```
]

#block(fill: luma(240), inset: 10pt, radius: 4pt)[
  *Exercise 1.2:* Translate the following expression into prefix form:

  $ (5 + 4 + (2 - (3 - (6 + 4/5)))) / (3(6 - 2)(2 - 7)) $
]

#block(fill: luma(240), inset: 10pt, radius: 4pt)[
  *Exercise 1.3:* Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers.
]

#block(fill: luma(240), inset: 10pt, radius: 4pt)[
  *Exercise 1.4:* Observe that our model of evaluation allows for combinations whose operators are compound expressions. Use this observation to describe the behavior of the following procedure:

  ```scm
  (define (a-plus-abs-b a b)
    ((if (> b 0) + -) a b))
  ```
]

#block(fill: luma(240), inset: 10pt, radius: 4pt)[
  *Exercise 1.5:* Ben Bitdiddle has invented a test to determine whether the interpreter he is faced with is using applicative-order evaluation or normal-order evaluation. He defines the following two procedures:

  ```scm
  (define (p) (p))

  (define (test x y) 
    (if (= x 0) 
        0 
        y))
  ```

  Then he evaluates the expression

  ```scm
  (test 0 (p))
  ```

  What behavior will Ben observe with an interpreter that uses applicative-order evaluation? What behavior will he observe with an interpreter that uses normal-order evaluation? Explain your answer.
]

=== Example: Square Roots by Newton's Method

Procedures, as introduced above, are much like ordinary mathematical functions. They specify a value that is determined by one or more parameters. But there is an important difference between mathematical functions and computer procedures. Procedures must be effective.

As a case in point, consider the problem of computing square roots. We can define the square-root function as

$ sqrt(x) = "the" y "such that" y >= 0 "and" y^2 = x $

This describes a perfectly legitimate mathematical function. We could use it to recognize whether one number is the square root of another, or to derive facts about square roots in general. On the other hand, the definition does not describe a procedure. Indeed, it tells us almost nothing about how to actually find the square root of a given number. It will not help matters to rephrase this definition in pseudo-Lisp:

```scm
(define (sqrt x)
  (the y (and (>= y 0) 
              (= (square y) x))))
```

This only begs the question.

The contrast between function and procedure is a reflection of the general distinction between describing properties of things and describing how to do things, or, as it is sometimes referred to, the distinction between declarative knowledge and imperative knowledge. In mathematics we are usually concerned with declarative (what is) descriptions, whereas in computer science we are usually concerned with imperative (how to) descriptions.

How does one compute square roots? The most common way is to use Newton's method of successive approximations, which says that whenever we have a guess $y$ for the value of the square root of a number $x$, we can perform a simple manipulation to get a better guess (one closer to the actual square root) by averaging $y$ with $x/y$. For example, we can compute the square root of 2 as follows. Suppose our initial guess is 1:

#table(
  columns: (1fr, 1fr, 2fr),
  stroke: none,
  [*Guess*], [*Quotient*], [*Average*],
  [1], [(2/1) = 2], [((2 + 1)/2) = 1.5],
  [1.5], [(2/1.5) = 1.3333], [((1.3333 + 1.5)/2) = 1.4167],
  [1.4167], [(2/1.4167) = 1.4118], [((1.4167 + 1.4118)/2) = 1.4142],
  [1.4142], [...], [...]
)

Continuing this process, we obtain better and better approximations to the square root.

Now let's formalize the process in terms of procedures. We start with a value for the radicand (the number whose square root we are trying to compute) and a value for the guess. If the guess is good enough for our purposes, we are done; if not, we must repeat the process with an improved guess. We write this basic strategy as a procedure:

```scm
(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x) x)))
```

A guess is improved by averaging it with the quotient of the radicand and the old guess:

```scm
(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y) 
  (/ (+ x y) 2))
```

We also have to say what we mean by "good enough." The following will do for illustration, but it is not really a very good test. The idea is to improve the answer until it is close enough so that its square differs from the radicand by less than a predetermined tolerance (here 0.001):

```scm
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))
```

Finally, we need a way to get started. For instance, we can always guess that the square root of any number is 1:

```scm
(define (sqrt x)
  (sqrt-iter 1.0 x))
```

If we type these definitions to the interpreter, we can use `sqrt` just as we can use any procedure:

```scm
(sqrt 9)
3.00009155413138

(sqrt (+ 100 37))
11.704699917758145
```

The `sqrt` program also illustrates that the simple procedural language we have introduced so far is sufficient for writing any purely numerical program that one could write in, say, C or Pascal. This might seem surprising, since we have not included in our language any iterative (looping) constructs that direct the computer to do something over and over again. `Sqrt-iter`, on the other hand, demonstrates how iteration can be accomplished using no special construct other than the ordinary ability to call a procedure.

=== Procedures as Black-Box Abstractions

`Sqrt` is our first example of a process defined by a set of mutually defined procedures. Notice that the definition of `sqrt-iter` is *recursive*; that is, the procedure is defined in terms of itself. The idea of being able to define a procedure in terms of itself may be disturbing; it may seem unclear how such a "circular" definition could have meaning at all, let alone be an effective way to get a computer to compute something. We will address this more carefully in Section 1.2. But first let's consider some other important points illustrated by the `sqrt` example.

Observe that the problem of computing square roots breaks up naturally into a number of subproblems: how to tell whether a guess is "good enough," how to improve a guess, and so on. Each of these tasks is accomplished by a separate procedure. The entire `sqrt` program can be viewed as a cluster of procedures (as shown in Figure 1.2) that mirrors the decomposition of the problem into subproblems.

#figure(
  grid(
    columns: 1,
    gutter: 1em,
    [`sqrt`],
    [#sym.arrow.b],
    [`sqrt-iter`],
    [#grid(columns: 2, gutter: 2em, [`good-enough?`], [`improve`])],
    [#grid(columns: 3, gutter: 1em, [`abs`], [`square`], [`average`])]
  ),
  caption: [Procedural decomposition of the `sqrt` program.],
)

The importance of this decomposition strategy is not simply that one is dividing the program into parts. After all, we could take any large program and divide it into parts---the first ten lines, the next ten lines, and so on. Rather, it is crucial that each procedure accomplishes an identifiable task that can be used as a module in defining other procedures. For example, when we define the `good-enough?` procedure in terms of `square`, we are able to regard the `square` procedure as a "black box." We are not at that moment concerned with *how* the procedure computes its result, only with the fact that it computes the square. The details of how the square is computed can be suppressed, to be considered at a later time. Indeed, as far as the `good-enough?` procedure is concerned, `square` is not quite a procedure but rather an abstraction of a procedure, a so-called *procedural abstraction*. At this level of abstraction, any procedure that computes the square is equally good.

Thus, a procedure definition should be able to suppress details. The users of the procedure may not have written the procedure themselves, but may have obtained it from another programmer as a black box. A programmer should not need to know how the procedure is implemented in order to use it.

==== Local names

One detail of a procedure's implementation that should not affect the user of the procedure is the implementer's choice of names for the procedure's formal parameters. Thus, the following procedures should not be distinguishable:

```scm
(define (square x) (* x x))
(define (square y) (* y y))
```

This principle---that the meaning of a procedure should be independent of the parameter names used by its author---may seem self-evident, but its consequences are profound. The simplest consequence is that the parameter names of a procedure must be local to the body of the procedure.

A formal parameter of a procedure has a very special role in the procedure definition, in that it doesn't matter what name the formal parameter has. Such a name is called a *bound variable*, and we say that the procedure definition *binds* its formal parameters. The meaning of a procedure definition is unchanged if a bound variable is renamed uniformly throughout the definition. If a variable is not bound, we say that it is *free*. The set of expressions for which a binding defines a name is called the *scope* of that name. In a procedure definition, the bound variables declared as the formal parameters of the procedure have the body of the procedure as their scope.

==== Internal definitions and block structure

We have one kind of name isolation available to us: The formal parameters of a procedure are local to the body of the procedure. The `sqrt` program illustrates another kind of name isolation that we would like to have. The problem is that the only procedure that is important to users of `sqrt` is `sqrt`. The other procedures (`sqrt-iter`, `good-enough?`, and `improve`) only clutter up their minds. They may not define any other procedure with the name `good-enough?` as part of another program to be used together with the square-root program, because `sqrt` needs it. The problem is especially serious in the construction of large systems by many separate programmers. For example, in the construction of a large numerical library, many auxiliary procedures would be defined, so many names would be exported to the user. We would like to localize the subprocedures, hiding them inside `sqrt` so that `sqrt` could coexist with other successive approximations, each having its own `good-enough?` procedure. To make this possible, we allow a procedure to have internal definitions that are local to that procedure. For example, we can write the `sqrt` procedure as follows:

```scm
(define (sqrt x)
  (define (good-enough? guess x)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess x)
    (average guess (/ x guess)))
  (define (sqrt-iter guess x)
    (if (good-enough? guess x)
        guess
        (sqrt-iter (improve guess x) x)))
  (sqrt-iter 1.0 x))
```

Such nesting of definitions, called *block structure*, is basically the right solution to the simplest name-packaging problem. But there is a better idea lurking here. In addition to internalizing the definitions of the auxiliary procedures, we can simplify them. Since `x` is bound in the definition of `sqrt`, the procedures `good-enough?`, `improve`, and `sqrt-iter`, which are defined internally to `sqrt`, are in the scope of `x`. Thus, it is not necessary to pass `x` explicitly to each of these procedures. Instead, we can allow `x` to be a free variable in the internal definitions, as shown below. Then `x` gets its value from the argument with which the enclosing procedure `sqrt` is called. This discipline is called *lexical scoping*.

```scm
(define (sqrt x)
  (define (good-enough? guess)
    (< (abs (- (square guess) x)) 0.001))
  (define (improve guess)
    (average guess (/ x guess)))
  (define (sqrt-iter guess)
    (if (good-enough? guess)
        guess
        (sqrt-iter (improve guess))))
  (sqrt-iter 1.0))
```

We will use block structure extensively to help us break up large programs into tractable pieces. The idea of block structure originated with the programming language Algol 60. It appears in most modern programming languages and is a crucial tool for helping to organize the construction of large programs.

#block(fill: luma(240), inset: 10pt, radius: 4pt)[
  *Exercise 1.6:* Alyssa P. Hacker doesn't see why `if` needs to be a special form. "Why can't I just define it as an ordinary procedure in terms of `cond`?" she asks. Alyssa's friend Eva Lu Ator claims this can indeed be done, and she defines a new version of `if`:

  ```scm
  (define (new-if predicate consequent alternative)
    (cond (predicate consequent)
          (else alternative)))
  ```

  Eva demonstrates the program for Alyssa:

  ```scm
  (new-if (= 2 3) 0 5)
  5

  (new-if (= 1 1) 0 5)
  0
  ```

  Delighted, Alyssa uses `new-if` to rewrite the square-root program:

  ```scm
  (define (sqrt-iter guess x)
    (new-if (good-enough? guess x)
            guess
            (sqrt-iter (improve guess x) x)))
  ```

  What happens when Alyssa attempts to use this to compute square roots? Explain.
]

#block(fill: luma(240), inset: 10pt, radius: 4pt)[
  *Exercise 1.7:* The `good-enough?` test used in computing square roots will not be very effective for finding the square roots of very small numbers. Also, in real computers, arithmetic operations are almost always performed with limited precision. This makes our test inadequate for very large numbers. Explain these statements, with examples showing how the test fails for small and large numbers. An alternative strategy for implementing `good-enough?` is to watch how `guess` changes from one iteration to the next and to stop when the change is a very small fraction of the guess. Design a square-root procedure that uses this kind of end test. Does this work better for small and large numbers?
]

#block(fill: luma(240), inset: 10pt, radius: 4pt)[
  *Exercise 1.8:* Newton's method for cube roots is based on the fact that if $y$ is an approximation to the cube root of $x$, then a better approximation is given by the value

  $ (x/y^2 + 2y) / 3 $

  Use this formula to implement a cube-root procedure analogous to the square-root procedure. (In Section 1.3.4 we will see how to implement Newton's method as an abstraction of these square-root and cube-root procedures.)
]

== Procedures and the Processes They Generate

We have now considered the elements of programming: We have used primitive arithmetic operations, we have combined these operations, and we have abstracted these composite operations by defining them as compound procedures. But that is not enough to enable us to say that we know how to program. Our situation is analogous to that of someone who has learned the rules for how the pieces move in chess but knows nothing of typical openings, tactics, or strategy. Like the novice chess player, we don't yet know the common patterns of usage in the domain. We lack the knowledge of which moves are worth making (which procedures are worth defining). We lack the experience to predict the consequences of making a move (executing a procedure).

The ability to visualize the consequences of the actions under consideration is crucial to becoming an expert programmer, just as it is in any synthetic, creative activity. In becoming an expert photographer, for example, one must learn how to look at a scene and know how dark each region will appear on a print for each possible choice of exposure and development conditions. Only then can one reason backward, planning framing, lighting, exposure, and development to obtain the desired effects. So it is with programming, where we are planning the course of action to be taken by a process and where we control the process by means of a program. To become experts, we must learn to visualize the processes generated by various types of procedures. Only after we have developed such a skill can we learn to reliably construct programs that exhibit the desired behavior.

A procedure is a pattern for the *local evolution* of a computational process. It specifies how each stage of the process is built upon the previous stage. We would like to be able to make statements about the overall, or *global*, behavior of a process whose local evolution has been specified by a procedure. This is very difficult to do in general, but we can at least try to describe some typical patterns of process evolution.

In this section we will examine some common "shapes" for processes generated by simple procedures. We will also investigate the rates at which these processes consume the important computational resources of time and space. The procedures we will consider are very simple. Their role is like that played by test patterns in photography: as oversimplified prototypical patterns, rather than practical examples in their own right.

=== Linear Recursion and Iteration

We begin by considering the factorial function, defined by

$ n! = n dot (n - 1) dot (n - 2) dots 3 dot 2 dot 1 $

There are many ways to compute factorials. One way is to make use of the observation that $n!$ is equal to $n$ times $(n - 1)!$ for any positive integer $n$:

$ n! = n dot [(n - 1) dot (n - 2) dots 3 dot 2 dot 1] = n dot (n - 1)! $

Thus, we can compute $n!$ by computing $(n - 1)!$ and multiplying the result by $n$. If we add the stipulation that $1!$ is equal to $1$, this observation translates directly into a procedure:

```scm
(define (factorial n)
  (if (= n 1) 
      1 
      (* n (factorial (- n 1)))))
```

We can use the substitution model to watch this procedure in action computing 6!, as shown in Figure 1.3.

#figure(
  ```
  (factorial 6)
  (* 6 (factorial 5))
  (* 6 (* 5 (factorial 4)))
  (* 6 (* 5 (* 4 (factorial 3))))
  (* 6 (* 5 (* 4 (* 3 (factorial 2)))))
  (* 6 (* 5 (* 4 (* 3 (* 2 (factorial 1))))))
  (* 6 (* 5 (* 4 (* 3 (* 2 1)))))
  (* 6 (* 5 (* 4 (* 3 2))))
  (* 6 (* 5 (* 4 6)))
  (* 6 (* 5 24))
  (* 6 120)
  720
  ```,
  caption: [A linear recursive process for computing 6!.],
)

Now let's take a different perspective on computing factorials. We could describe a rule for computing $n!$ by specifying that we first multiply 1 by 2, then multiply the result by 3, then by 4, and so on until we reach $n$. More formally, we maintain a running product, together with a counter that counts from 1 up to $n$. We can describe the computation by saying that the counter and the product simultaneously change from one step to the next according to the rule

$ "product" arrow.l "counter" dot "product" \
"counter" arrow.l "counter" + 1 $

and stipulating that $n!$ is the value of the product when the counter exceeds $n$.

Once again, we can recast our description as a procedure for computing factorials:

```scm
(define (factorial n) 
  (fact-iter 1 1 n))

(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))
```

As before, we can use the substitution model to visualize the process of computing 6!, as shown in Figure 1.4.

#figure(
  ```
  (factorial 6)
  (fact-iter   1 1 6)
  (fact-iter   1 2 6)
  (fact-iter   2 3 6)
  (fact-iter   6 4 6)
  (fact-iter  24 5 6)
  (fact-iter 120 6 6)
  (fact-iter 720 7 6)
  720
  ```,
  caption: [A linear iterative process for computing 6!.],
)

Compare the two processes. From one point of view, they seem hardly different at all. Both compute the same mathematical function on the same domain, and each requires a number of steps proportional to $n$ to compute $n!$. Indeed, both processes even carry out the same sequence of multiplications, obtaining the same sequence of partial products. On the other hand, when we consider the "shapes" of the two processes, we find that they evolve quite differently.

Consider the first process. The substitution model reveals a shape of expansion followed by contraction, indicated by the arrow in Figure 1.3. The expansion occurs as the process builds up a chain of *deferred operations* (in this case, a chain of multiplications). The contraction occurs as the operations are actually performed. This type of process, characterized by a chain of deferred operations, is called a *recursive process*. Carrying out this process requires that the interpreter keep track of the operations to be performed later on. In the computation of $n!$, the length of the chain of deferred multiplications, and hence the amount of information needed to keep track of it, grows linearly with $n$ (is proportional to $n$), just like the number of steps. Such a process is called a *linear recursive process*.

By contrast, the second process does not grow and shrink. At each step, all we need to keep track of, for any $n$, are the current values of the variables `product`, `counter`, and `max-count`. We call this an *iterative process*. In general, an iterative process is one whose state can be summarized by a fixed number of *state variables*, together with a fixed rule that describes how the state variables should be updated as the process moves from state to state and an (optional) end test that specifies conditions under which the process should terminate. In computing $n!$, the number of steps required grows linearly with $n$. Such a process is called a *linear iterative process*.

The contrast between the two processes can be seen in another way. In the iterative case, the program variables provide a complete description of the state of the process at any point. If we stopped the computation between steps, all we would need to do to resume the computation is to supply the interpreter with the values of the three program variables. Not so with the recursive process. In this case there is some additional "hidden" information, maintained by the interpreter and not contained in the program variables, which indicates "where the process is" in negotiating the chain of deferred operations. The longer the chain, the more information must be maintained.

In contrasting iteration and recursion, we must be careful not to confuse the notion of a recursive *process* with the notion of a recursive *procedure*. When we describe a procedure as recursive, we are referring to the syntactic fact that the procedure definition refers (either directly or indirectly) to the procedure itself. But when we describe a process as following a pattern that is, say, linearly recursive, we are speaking about how the process evolves, not about the syntax of how a procedure is written. It may seem disturbing that we refer to a recursive procedure such as `fact-iter` as generating an iterative process. However, the process really is iterative: Its state is captured completely by its three state variables, and an interpreter need keep track of only three variables in order to execute the process.

One reason that the distinction between process and procedure may be confusing is that most implementations of common languages (including Ada, Pascal, and C) are designed in such a way that the interpretation of any recursive procedure consumes an amount of memory that grows with the number of procedure calls, even when the process described is, in principle, iterative. As a consequence, these languages can describe iterative processes only by resorting to special-purpose "looping constructs" such as `do`, `repeat`, `until`, `for`, and `while`. The implementation of Scheme we shall consider in Chapter 5 does not share this defect. It will execute an iterative process in constant space, even if the iterative process is described by a recursive procedure. An implementation with this property is called *tail-recursive*. With a tail-recursive implementation, iteration can be expressed using the ordinary procedure call mechanism, so that special iteration constructs are useful only as syntactic sugar.

#block(fill: luma(240), inset: 10pt, radius: 4pt)[
  *Exercise 1.9:* Each of the following two procedures defines a method for adding two positive integers in terms of the procedures `inc`, which increments its argument by 1, and `dec`, which decrements its argument by 1.

  ```scm
  (define (+ a b)
    (if (= a 0) 
        b 
        (inc (+ (dec a) b))))

  (define (+ a b)
    (if (= a 0) 
        b 
        (+ (dec a) (inc b))))
  ```

  Using the substitution model, illustrate the process generated by each procedure in evaluating `(+ 4 5)`. Are these processes iterative or recursive?
]

#block(fill: luma(240), inset: 10pt, radius: 4pt)[
  *Exercise 1.10:* The following procedure computes a mathematical function called Ackermann's function.

  ```scm
  (define (A x y)
    (cond ((= y 0) 0)
          ((= x 0) (* 2 y))
          ((= y 1) 2)
          (else (A (- x 1)
                   (A x (- y 1))))))
  ```

  What are the values of the following expressions?

  ```scm
  (A 1 10)
  (A 2 4)
  (A 3 3)
  ```

  Consider the following procedures, where `A` is the procedure defined above:

  ```scm
  (define (f n) (A 0 n))
  (define (g n) (A 1 n))
  (define (h n) (A 2 n))
  (define (k n) (* 5 n n))
  ```

  Give concise mathematical definitions for the functions computed by the procedures `f`, `g`, and `h` for positive integer values of $n$. For example, `(k n)` computes $5 n^2$.
]

=== Tree Recursion

Another common pattern of computation is called *tree recursion*. As an example, consider computing the sequence of Fibonacci numbers, in which each number is the sum of the preceding two:

#align(center)[0, 1, 1, 2, 3, 5, 8, 13, 21, ...]

In general, the Fibonacci numbers can be defined by the rule

$ "Fib"(n) = cases(
  0 & "if" n = 0,
  1 & "if" n = 1,
  "Fib"(n-1) + "Fib"(n-2) & "otherwise"
) $

We can immediately translate this definition into a recursive procedure for computing Fibonacci numbers:

```scm
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))
```

Consider the pattern of this computation. To compute `(fib 5)`, we compute `(fib 4)` and `(fib 3)`. To compute `(fib 4)`, we compute `(fib 3)` and `(fib 2)`. In general, the evolved process looks like a tree, as shown in Figure 1.5. Notice that the branches split into two at each level (except at the bottom); this reflects the fact that the `fib` procedure calls itself twice each time it is invoked.

#figure(
  ```
                     ..<............ fib5   <.......... 
                  ...     ___________/  \___________   .  
               ...       /       . .....            \    . 
             ..       fib4     .        . . . .     fib3  .  
           ..     ____/. \____  ..             .  __/  \__  .  
         ..      /  . .  ..   \    .        ..   /  . .   \   . 
       ..     fib3 .       .  fib2 .        . fib2 .   .  fib1 .
     ..      / . \  .     .   /  \  .      .  /  \ ...  .  |  .
   ..       / . . \   .  .   /  . \   .  .   / .  \   .  . 1 .
  .      fib2 . . fib1.  .fib1 .  fib0 . .fib1. . fib0 .  .  .
  .      /  \  . . |  .  . |  .  . |   . . |   . . |   .   .>
  V     /  . \   . 1  .  . 1  .  . 0  .  . 1  .  . 0  ..
  .  fib1 .. fib0..  .   .   .   .   .   V   .   ..  . 
  .   |  .  . |  . .>     .>.     . .    ..>.      .>
  .   1 .   . 0  .      
   .   .     .  .       
    .>.       ..        
  ```,
  caption: [The tree-recursive process generated in computing `(fib 5)`.],
)

This procedure is instructive as a prototypical tree recursion, but it is a terrible way to compute Fibonacci numbers because it does so much redundant computation. Notice in Figure 1.5 that the entire computation of `(fib 3)`---almost half the work---is duplicated. In fact, it is not hard to show that the number of times the procedure will compute `(fib 1)` or `(fib 0)` (the number of leaves in the above tree, in general) is precisely $"Fib"(n+1)$. To get an idea of how bad this is, one can show that the value of $"Fib"(n)$ grows exponentially with $n$. More precisely (see Exercise 1.13), $"Fib"(n)$ is the closest integer to $phi^n / sqrt(5)$, where

$ phi = (1 + sqrt(5))/2 approx 1.6180 $

is the *golden ratio*, which satisfies the equation

$ phi^2 = phi + 1 $

Thus, the process uses a number of steps that grows exponentially with the input. On the other hand, the space required grows only linearly with the input, because we need keep track only of which nodes are above us in the tree at any point in the computation. In general, the number of steps required by a tree-recursive process will be proportional to the number of nodes in the tree, while the space required will be proportional to the maximum depth of the tree.

We can also formulate an iterative process for computing the Fibonacci numbers. The idea is to use a pair of integers $a$ and $b$, initialized to $"Fib"(1) = 1$ and $"Fib"(0) = 0$, and to repeatedly apply the simultaneous transformations

$ a arrow.l a + b \
b arrow.l a $

It is not hard to show that, after applying this transformation $n$ times, $a$ and $b$ will be equal, respectively, to $"Fib"(n+1)$ and $"Fib"(n)$. Thus, we can compute Fibonacci numbers iteratively using the procedure

```scm
(define (fib n) 
  (fib-iter 1 0 n))

(define (fib-iter a b count)
  (if (= count 0)
      b
      (fib-iter (+ a b) a (- count 1))))
```

This second method for computing $"Fib"(n)$ is a linear iteration. The difference in number of steps required by the two methods---one linear in $n$, one growing as fast as $"Fib"(n)$ itself---is enormous, even for small inputs.

One should not conclude from this that tree-recursive processes are useless. When we consider processes that operate on hierarchically structured data rather than numbers, we will find that tree recursion is a natural and powerful tool. But even in numerical operations, tree-recursive processes can be useful in helping us to understand and design programs. For instance, although the first `fib` procedure is much less efficient than the second one, it is more straightforward, being little more than a translation into Lisp of the definition of the Fibonacci sequence. To formulate the iterative algorithm required noticing that the computation could be recast as an iteration with three state variables.

==== Example: Counting change

It takes only a bit of cleverness to come up with the iterative Fibonacci algorithm. In contrast, consider the following problem: How many different ways can we make change of $1.00$, given half-dollars, quarters, dimes, nickels, and pennies? More generally, can we write a procedure to compute the number of ways to change any given amount of money?

This problem has a simple solution as a recursive procedure. Suppose we think of the types of coins available as arranged in some order. Then the following relation holds:

The number of ways to change amount $a$ using $n$ kinds of coins equals

- the number of ways to change amount $a$ using all but the first kind of coin, plus
- the number of ways to change amount $a - d$ using all $n$ kinds of coins, where $d$ is the denomination of the first kind of coin.

To see why this is true, observe that the ways to make change can be divided into two groups: those that do not use any of the first kind of coin, and those that do. Therefore, the total number of ways to make change for some amount is equal to the number of ways to make change for the amount without using any of the first kind of coin, plus the number of ways to make change assuming that we do use the first kind of coin. But the latter number is equal to the number of ways to make change for the amount that remains after using a coin of the first kind.

Thus, we can recursively reduce the problem of changing a given amount to the problem of changing smaller amounts using fewer kinds of coins. Consider this reduction rule carefully, and convince yourself that we can use it to describe an algorithm if we specify the following degenerate cases:

- If $a$ is exactly 0, we should count that as 1 way to make change.
- If $a$ is less than 0, we should count that as 0 ways to make change.
- If $n$ is 0, we should count that as 0 ways to make change.

We can easily translate this description into a recursive procedure:

```scm
(define (count-change amount)
  (cc amount 5))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) 
             (= kinds-of-coins 0)) 
          0)
        (else 
         (+ (cc amount (- kinds-of-coins 1))
            (cc (- amount (first-denomination 
                           kinds-of-coins))
                kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))
```

(The `first-denomination` procedure takes as input the number of kinds of coins available and returns the denomination of the first kind. Here we are thinking of the coins as arranged in order from largest to smallest, but any order would do as well.) We can now answer our original question about changing a dollar:

```scm
(count-change 100)
292
```

`Count-change` generates a tree-recursive process with redundancies similar to those in our first implementation of `fib`. (It will take quite a while for that 292 to be computed.) On the other hand, it is not obvious how to design a better algorithm for computing the result, and we leave this problem as a challenge. The observation that a tree-recursive process may be highly inefficient but often easy to specify and understand has led people to propose that one could get the best of both worlds by designing a "smart compiler" that could transform tree-recursive procedures into more efficient procedures that compute the same result.

#block(fill: luma(240), inset: 10pt, radius: 4pt)[
  *Exercise 1.11:* A function $f$ is defined by the rule that $f(n) = n$ if $n < 3$ and $f(n) = f(n-1) + 2 f(n-2) + 3 f(n-3)$ if $n >= 3$. Write a procedure that computes $f$ by means of a recursive process. Write a procedure that computes $f$ by means of an iterative process.
]

#block(fill: luma(240), inset: 10pt, radius: 4pt)[
  *Exercise 1.12:* The following pattern of numbers is called *Pascal's triangle*.

  ```
           1
         1   1
       1   2   1
     1   3   3   1
   1   4   6   4   1
         . . .
  ```

  The numbers at the edge of the triangle are all 1, and each number inside the triangle is the sum of the two numbers above it. Write a procedure that computes elements of Pascal's triangle by means of a recursive process.
]

#block(fill: luma(240), inset: 10pt, radius: 4pt)[
  *Exercise 1.13:* Prove that $"Fib"(n)$ is the closest integer to $phi^n / sqrt(5)$, where $phi = (1 + sqrt(5)) / 2$. Hint: Let $psi = (1 - sqrt(5)) / 2$. Use induction and the definition of the Fibonacci numbers to prove that $"Fib"(n) = (phi^n - psi^n) / sqrt(5)$.
]


#block(fill: luma(240), inset: 10pt, radius: 4pt)[
  *Exercise 1.10:* The following procedure computes a mathematical function called Ackermann's function.

  ```scm
  (define (A x y)
    (cond ((= y 0) 0)
          ((= x 0) (* 2 y))
          ((= y 1) 2)
          (else (A (- x 1)
                   (A x (- y 1))))))
  ```

  What are the values of the following expressions?

  ```scm
  (A 1 10)
  (A 2 4)
  (A 3 3)
  ```

  Consider the following procedures, where `A` is the procedure defined above:

  ```scm
  (define (f n) (A 0 n))
  (define (g n) (A 1 n))
  (define (h n) (A 2 n))
  (define (k n) (* 5 n n))
  ```

  Give concise mathematical definitions for the functions computed by the procedures `f`, `g`, and `h` for positive integer values of $n$. For example, `(k n)` computes $5 n^2$.
]
