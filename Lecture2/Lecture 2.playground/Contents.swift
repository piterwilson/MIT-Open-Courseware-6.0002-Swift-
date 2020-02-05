import Foundation

/**
 class Food(object):
     def __init__(self, n, v, w):
         self.name = n
         self.value = v
         self.calories = w
     def getValue(self):
         return self.value
     def getCalories(self):
         return self.calories
     def density(self):
         return self.getValue()/self.getCalories()
     def __str__(self):
         return self.name + ': < value: ' + str(self.value)\
                  + ', calories: ' + str(self.calories) + '>'
 */
struct Food: CustomStringConvertible {
    var name: String
    var value: Double
    var calories: Double
    var density: Double {
        value / calories
    }
    var description: String {
        "\(name) : < value: \(value), calories: \(calories)"
    }
}

/**
 def buildLargeMenu(numItems, maxVal, maxCost):
     items = []
     for i in range(numItems):
         items.append(Food(str(i),
                           random.randint(1, maxVal),
                           random.randint(1, maxCost)))
     return items
 */
func buildLargeMenu(numItems: Int, maxVal: Double, maxCost: Double) -> [Food] {
    let items: [Food] = (0..<numItems).map { index in
        Food(name: "Food \(index)", value: Double.random(in: (1...maxVal)), calories: Double.random(in: 0...maxCost))
    }
    return items
}

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
 Very slow fib function ... gets slow around 20s
 */
/*
for i in (0...121) {
    print("fib of \(i) : \(fib(i))")
}
 */

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
for i in (0...121) {
    print("fib of \(i) : \(fastFib(i, memo: &memo))")
}
