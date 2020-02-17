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
public struct Food: CustomStringConvertible {
    public var name: String
    public var value: Double
    public var calories: Int
    public init(name: String, value: Double, calories: Int) {
        self.name = name
        self.value = value
        self.calories = calories
    }
    public func getCost() -> Int {
        self.calories
    }
    public var density: Double {
        value / Double(calories)
    }
    public var description: String {
        "Food: \(name) : < value: \(value), calories: \(calories)>"
    }
}
