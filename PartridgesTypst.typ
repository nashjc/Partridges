// Note the clarity of the error message when deleting this line
// Also note the flexibility of changing "(1)" to "1" or "1." or "a)"
#set math.equation(numbering: "(1)")

= Partridges in Pear Trees -- Typst

John Nash and Prashanth Velayudhan

2025-12-08

== Motivation

The preparation of scientific documents with mathematical content has always given
their authors and printers difficulty in rendering the material to paper or screen.
This article is part of an exercise to illustrate how different systems for preparing
such documents compare in capability and ease of use.

The text preparation systems to be compared are \LaTeX (@lamport_latex_1986), Typst (@madje2022programmable) and R Markdown (@rmarkdown).
We note that bibliographic support is also of interest to users.

== A useful example

The Christmas counting song "The Twelve Days of Christmas" suggest the singer 
receives one gift -- we shall unabashedly simply declare that the Partridge in 
a Pear Tree is a single gift -- on the first of twelve days, then that gift plus
two more on the second, and so forth. For our needs, we want to have a general
formula for the total number of gifts received after $n$ days. While the commonly
known song uses 12 days, there are variants with other values of $n$. The Faroe
Islands use the inflationary value $n = 15$. In our exposition, we will rely on
the Wikipedia reference @noauthor_twelve_2025 as our authority.

Thus we seek a formula for $T(n)$, the total number of presents received after
the $n$'th day.

== Single day number of presents

On a single day, the number of presents $S(n)$ is clearly the sum of an arithmetic progression (@eq:arithmetic).

// A single space surrounding the equation determines if it will be inline
// with text or a full-sized equation on its own line.

#set math.equation(
    numbering: (..) => "Arith-progrn",
    number-align: left
)

// Note that the common keyword sum does not need escaping.
$ S(k) = sum_(i=1)^k i $ <eq:arithmetic>

Once more, but with numbering:

#set math.equation(
    numbering: (..) => "Arith-progrn " + counter(math.equation).display("1"),
    number-align: left
)

$ S(k) = sum_(i=1)^k i $

Once more, but with the global equation counter reset:

#counter(math.equation).update(0)

$ S(k) = sum_(i=1)^k i $

One final time, but we are back to using standard numbering:

#set math.equation(
    numbering: "(1)",
    number-align: right
)

#counter(math.equation).update(0)

$ S(k) = sum_(i=1)^k i $

// Deleting this line will allow the remaining equations to be numbered
#set math.equation(numbering: none)

Clearly we now want to compute

$ T(n) = sum_{j = 1} ^n S(k) $

The formula for $S(k)$ is well known, and derived by noting that writing the sequence forwards and then backwards illustrates that twice the sum is $k * (k+1)$, so we have

// Note that fractions are handled automatically
$  S(k) = (k (k + 1))/2  $

We can use this so that we find

$ 2 T(n) =  sum_(k=1)^n ( k^2 + k ) $

We therefore need 

$ Q(n) = sum_(k = 1)^n k^2 $

To give our provisional expression as

$ T(n) = (Q(n) + S(n))/2 $

$Q(n)$ is a well-known summation, often proved by mathematical induction,

$ Q(n) = (n (2 n + 1) (n + 1))/6 $

Thus we want:

// Minimal syntax needed to support multiline equations
$ T(n) &= 1/2 ((n (2 n + 1 )(n+1))/6 + (n(n+1))/2) \
     &= (2 n^3 + 3 n^2 + n  + 3 n^2 + 3 n)/12  \
     &= (2 n^3 + 6 n^2 + 4 n)/12  \
     &= (n^3 + 3 n^2 + 2 n)/6
$


// This is a very impractical way to do serious calculations,
// but does demonstrate some of typst's capabilities as its
// own programming language. I'm not entirely sure when this
// would be helpful.
We can calculate the summation from within typst using its built-in scripting capabilities:

```typst
#let n = 12
#((calc.pow(n, 3) + 3*n*n + 2*n)/6)
```

to get the result:

#let n = 12
#((calc.pow(n, 3) + 3*n*n + 2*n)/6)

@tab_total shows the total number of gifts received as of each day.

#align(center)[
    #figure(
        table(
            columns: 2,
            [*Day*], [*Gifts*],
            [1], [1],
            [2], [4],
            [3], [10],
            [4], [20],
            [5], [35],
            [6], [56],
            [7], [84],
            [8], [120],
            [9], [165],
            [10], [220],
            [11], [286],
            [12], [364],
        ),
        caption: [Total gifts received as of each of the 12 days.]
    ) <tab_total>
]


//// Markdown-style tables also work with a separate package:
//#import "@preview/tablem:0.3.0": tablem, three-line-table
//#align(center)[
//    #tablem[
//        | *day* | *gifts* |
//        | ---:  | -----:  |
//        | 1     | 1       |
//        | 2     | 4       |
//        | 3     | 10      |
//        | 4     | 20      |
//        | 5     | 35      |
//        | 6     | 56      |
//        | 7     | 84      |
//        | 8     | 120     |
//        | 9     | 165     |
//        | 10    | 220     |
//        | 11    | 286     |
//        | 12    | 364     |
//    ]
//]

#bibliography("PartridgeRefs.bib", title: "References")
