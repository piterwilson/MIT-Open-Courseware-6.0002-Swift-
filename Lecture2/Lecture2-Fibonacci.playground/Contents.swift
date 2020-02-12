import Foundation

let stopWatch = StopWatch()
/**
 
 Fibonacci Examples
 
 */

/**
 "Slow" Fibonacci implementation
 
 The Fibonacci Sequence is the series of numbers:

 0, 1, 1, 2, 3, 5, 8, 13, 21, 34, ...

 The next number is found by adding up the two numbers before it.
 
 def fib(n):
     if n == 0 or n == 1:
         return 1
     else:
         return fib(n - 1) + fib(n - 2)
 
 Note: Needs to output `Double` rather than `Int` because this causes an overflow when `n > 91`
 
 */
func fib(_ n: Int) -> Double {
    if n == 0 || n == 1 {
        return 1.0
    }
    return fib(n - 1) + fib(n - 2)
}

/**
 Slow fib function.
 */
stopWatch.start()
for i in (0...20) { // I only go to 20, don't have patience to go all the way to 121
    print("fib of \(i) : \(fib(i))")
}
print("time elapsed: \(stopWatch.mark()) sec.") // time elapsed: 1.025583028793335 sec.

/**
 "Fast" Fibonacci implementation
 
 def fastFib(n, memo = {}):
 """Assumes n is an int >= 0, memo used only by recursive calls
    Returns Fibonacci of n"""
     if n == 0 or n == 1:
         return 1
     try:
         return memo[n]
     except KeyError:
         result = fastFib(n-1, memo) + fastFib(n-2, memo)
         memo[n] = result
         return result
 
 Note: Needs to output `Double` rather than `Int` because this causes an overflow when `n > 91`
 
 */

func fastFib(_ n: Int, memo: inout [Int: Double]) -> Double {
    if n == 0 || n == 1 {
        return 1.0
    }
    guard let out: Double = memo[n] else {
        let result = fastFib(n - 1, memo: &memo) + fastFib(n - 2, memo: &memo)
        memo[n] = result
        return result
    }
    return out
}

// fast fib is fast but requires a "cache" defined outside the function. Can get to value 121 quite fast.
var memo: [Int: Double] = [:] // start a cache "memo" to look up values
stopWatch.start()
for i in (0...121) {
    print("fib of \(i) : \(fastFib(i, memo: &memo))")
}
print("time elapsed: \(stopWatch.mark()) sec.") // time elapsed: 0.01671004295349121 sec.
