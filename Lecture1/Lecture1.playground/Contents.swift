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
 def buildMenu(names, values, calories):
     """names, values, calories lists of same length.
        name a list of strings
        values and calories lists of numbers
        returns list of Foods"""
     menu = []
     for i in range(len(values)):
         menu.append(Food(names[i], values[i],
                           calories[i]))
     return menu
 */

/// returns list of Foods
/// - Parameters:
///   - names: a list of strings
///   - values: lists of numbers
///   - calories: lists of numbers
func buildMenu(names: [String], values: [Double], calories: [Double]) -> [Food] {
    guard names.count == values.count, names.count == calories.count else {
        fatalError("assumes names, values, calories lists of same length")
    }
    var menu: [Food] = []
    for (index, name) in names.enumerated() {
        menu.append(Food(name: name, value: values[index], calories: calories[index]))
    }
    return menu
}

/**
 def greedy(items, maxCalories, keyFunction):
     """Assumes items a list, maxCalories >= 0,
          keyFunction maps elements of items to numbers"""
     itemsCopy = sorted(items, key = keyFunction,
                        reverse = True)
     result = []
     totalValue, totalCalories = 0.0, 0.0
     for i in range(len(itemsCopy)):
         if (totalCalories+itemsCopy[i].getCalories()) <= maxCalories:
             result.append(itemsCopy[i])
             totalCalories += itemsCopy[i].getCalories()
             totalValue += itemsCopy[i].getValue()
     return (result, totalValue)
 */
func greedy(items: [Food], maxCalories: Double, keyFunction: (Food, Food) -> Bool) -> ([Food], Double) {
    var totalValue: Double = 0
    var totalCalories: Double = 0
    var result: [Food] = []
    let itemsCopy = items.sorted(by: keyFunction)
    itemsCopy.forEach { food in
        if totalCalories + food.calories <= maxCalories {
            result.append(food)
            totalCalories += food.calories
            totalValue += food.value
        }
    }
    return (result, totalValue)
}

/**
 def testGreedy(items, constraint, keyFunction):
     taken, val = greedy(items, constraint, keyFunction)
     print('Total value of items taken = ', val)
     for item in taken:
         print('   ', item)
 */
func testGreedy(items: [Food], constraint: Double, keyFunction: (Food, Food) -> Bool) {
    let result: ([Food], Double) = greedy(items: items, maxCalories: constraint, keyFunction: keyFunction)
    print("Total value of items taken = \(result.1)")
    result.0.forEach {food in
        print(food)
    }
}

/**
 def testGreedys(foods, maxUnits):
     print('Use greedy by value ($) to allocate', maxUnits,
           'calories')
     testGreedy(foods, maxUnits, Food.getValue)
     print('\nUse greedy by cost in calories to allocate', maxUnits,
           'calories')
     testGreedy(foods, maxUnits,
                lambda x: 1/Food.getCalories(x))
     print('\nUse greedy by density (bang for buck) to allocate', maxUnits,
           'calories')
     testGreedy(foods, maxUnits, Food.density)
 */

func testGreedys(foods: [Food], maxUnits: Double) {
    print("Use greedy by value ($) to allocate \(maxUnits) calories")
    testGreedy(items: foods, constraint: maxUnits, keyFunction: {(lhs: Food, rhs: Food) in
        return lhs.value > rhs.value
        })
    print("Use greedy by cost in callories to allocate \(maxUnits) calories")
    testGreedy(items: foods, constraint: maxUnits, keyFunction: {(lhs: Food, rhs: Food) in
        return (1/lhs.calories > 1/rhs.calories)
    })
    print("Use greedy greedy by density to allocate \(maxUnits) calories")
    testGreedy(items: foods, constraint: maxUnits, keyFunction: {(lhs: Food, rhs: Food) in
        return lhs.density > rhs.density
    })
}

let names: [String] = ["wine", "beer", "pizza", "burger", "fries", "cola", "apple", "donut"] // downloadable content contained 9 strings, but only 8 values for `values` and `calories`
let values: [Double] = [89.0, 90.0, 95.0, 100.0, 90.0, 79.0, 50.0, 10.0]
let calories: [Double] = [123.0, 154.0, 258.0, 354.0, 365.0, 150.0, 95.0, 195.0]
let foods = buildMenu(names: names, values: values, calories: calories)
testGreedys(foods: foods, maxUnits: 1000.0)
