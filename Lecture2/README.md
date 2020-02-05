# Lecture 2: Optimization Problems

The initial examples with the fibonacci sequence functions demonstrate how having a cache (memorization) can be a way to optimize a problem where there is **"optimal substructure"** and **"overlapping subproblems"**.

## Python to Swift notes

When translating the `fastFib` function some thought had to go into the way Python's parameters are **mutable** while Swift's aren't. This required the use of the `inout` keyword which automatically means having a default value was not possible.

Additionally, it was necessary to declare the type of the output to be `Double` instead of `Int` because after `n > 91` an Integer overflow occurs!