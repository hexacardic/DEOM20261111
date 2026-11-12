#set document(title: [Daily Epsilon of Maths 11 Nov 2026], author: "hexacardic")
#set page(margin: 1cm, width: 41em + 2cm, height: auto)
#show raw: set text(font: "Fira Code")
#set raw(tab-size: 4)
#show raw.where(block: true): body => box(inset: 1em, stroke: gray, radius: 1em, body)

#title()

= Problem

Find the first two digits after the radix point in $pi$ in base 8.

= Solution

We will write a haskell type for approximating real numbers using rational numbers, providing access to the current lower bound and upper bound as rational numbers, and a method to make the bounds tighter. Then, we will define $pi$ by a value of that type, using some known approximation algorithm. Then, we will repeatedly try to determine $pi$ to 2 octal places, making the approximation more precise if we fail to determine the digits precisely.

In particular, I will use the Gregory-Leibniz series approximation

$ pi = sum_(i=0)^oo (-1)^i 4/(2i+1) $

as it is easy to code. Defining the partial sums

$ s_n = sum_(i=0)^n (-1)^i 4/(2i+1) $

with $s_(-1) = 0$, we know that for all odd $n$ we have $s_n < pi$ and for all even $n$ we have $pi < s_n$, and we can easily determine the next partial sum by the formula $s_n = s_(n-1) + (-1)^n 4/(2n+1)$. Thus, we will start with lower bound $s_(-1)=0$ and upper bound $s_0=4$, and whenever we need to tighten the bounds, we compute the next partial sum and update the corresponding bound to that.

== Code

#raw(read("algo.hs"), lang: "hs", block: true)

== Result

#raw(read("result"), block: true)