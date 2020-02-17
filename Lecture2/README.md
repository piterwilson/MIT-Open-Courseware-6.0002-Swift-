# Lecture 2: Optimization Problems

## Example Lecture2-Fibonacci 

Fibonacci sequence functions demonstrate how having a cache (memorization) can be a way to optimize a problem where there is **"optimal substructure"** and **"overlapping subproblems"**.

## Example Lecture2-Knapsack

This example pits a greedy vs a search tree algorithms to find the best solution to the "Knapsack" problem which in this case refers to finding set of `Food` items with the maximum sum value ($) possible with a constained value of sum calories (cost).

## Example Lecture2-Knapsack-fastMaxVal

This example pits the "dumb" version of the search tree algorithm, agains a version that makes use of a "cache" (refered to as "memo") to show an optimization technique on said piece of code.

## Python to Swift notes

When translating the `fastFib` function some thought had to go into the way Python's parameters are **mutable** while Swift's aren't. This required the use of the `inout` keyword which automatically means having a default value was not possible.

Additionally, it was necessary to declare the type of the output to be `Double` instead of `Int` because after `n > 91` an Integer overflow occurs!

**Lecture2-Knapsack-fastMaxVal** was specially interesting to work trough. In my initial attempts I saw little to no improvement of the "fast" (`fastMaxValue(toConsider:avail:memo:)`) version over the "dumb" version of the search tree algorithm (`maxValue(toConsider:avail:)`).

The cache itself was a bit hard to work out since in the original Python code, a tuple is used as the key in the `memo` dictionary. This is not possible in swift and I had to resort to creating a custom `struct` for this purpose. Also Swift is more strict so I found no good way to reuse the testing functions to deploy both versions.

In any case, my original version of the `Food` `struct` used `Double` for the calorie value. When I attempted to use this in the `fastMaxValue(toConsider:avail:memo:)` algorithm, it was slower than the original `maxValue(toConsider:avail:)`!!! somehow the `Double` values were never generating cache matches so the optimization didn't work at all. It was only when I turned the calories to be of type `Int` that I started to see improvements in the speed of calculation. 