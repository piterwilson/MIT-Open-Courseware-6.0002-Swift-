import Foundation

import Foundation

/**

Knapsack 0/1 Problem

*/

/**
 def testGreedy(items, constraint, keyFunction):
     taken, val = greedy(items, constraint, keyFunction)
     print('Total value of items taken =', val)
     for item in taken:
         print('   ', item)
 */
func testGreedy(items: [Food], constraint: Double, keyFunction: ((Food, Food) -> Bool)) {
    let result: ([Food], Double) = greedy(items: items, maxCost: constraint, keyFunction: keyFunction)
    let totalCalories = getTotalCalories(in: result.0)
    print("Total value of items taken $\(result.1) (\(totalCalories) calories)")
    result.0.forEach { print(" \($0)") }
}

/**
 def testGreedys(foods, maxUnits):
     print('Use greedy by value to allocate', maxUnits,
           'calories')
     testGreedy(foods, maxUnits, Food.getValue)
     print('\nUse greedy by cost to allocate', maxUnits,
           'calories')
     testGreedy(foods, maxUnits,
                lambda x: 1/Food.getCost(x))
     print('\nUse greedy by density to allocate', maxUnits,
           'calories')
     testGreedy(foods, maxUnits, Food.density)
 */
func testGreedys(foods: [Food], maxUnits: Double) {
    print("Use greedy by value to allocate \(maxUnits) calories")
    testGreedy(items: foods, constraint: maxUnits, keyFunction: { (lhs: Food, rhs: Food) -> Bool in
        lhs.value > rhs.value
    })
    print("Use greedy by calories to allocate \(maxUnits) calories")
    testGreedy(items: foods, constraint: maxUnits, keyFunction: { (lhs: Food, rhs: Food) -> Bool in
        lhs.getCost() < rhs.getCost()
    })
    print("Use greedy by density to allocate \(maxUnits) calories")
    testGreedy(items: foods, constraint: maxUnits, keyFunction: { (lhs: Food, rhs: Food) -> Bool in
        lhs.density > rhs.density
    })
}

/**
 def greedy(items, maxCost, keyFunction):
     """Assumes items a list, maxCost >= 0,
          keyFunction maps elements of Items to numbers"""
     itemsCopy = sorted(items, key = keyFunction,
                        reverse = True)
     result = []
     totalValue, totalCost = 0.0, 0.0
     for i in range(len(itemsCopy)):
         if (totalCost+itemsCopy[i].getCost()) <= maxCost:
             result.append(itemsCopy[i])
             totalCost += itemsCopy[i].getCost()
             totalValue += itemsCopy[i].getValue()
     return (result, totalValue)
 */
public func greedy(items: [Food], maxCost: Double, keyFunction: ((Food, Food) -> Bool)) -> ([Food], Double) {
    let itemsCopy = items.sorted(by: keyFunction)
    var result: [Food] = []
    var totalValue: Double = 0.0
    var totalCost: Double = 0.0
    for item in itemsCopy {
        if totalCost + item.getCost() <= maxCost {
            result.append(item)
            totalCost += item.getCost()
            totalValue += item.value
        }
    }
    return (result, totalValue)
}
/**
 def maxVal(toConsider, avail):
 """Assumes toConsider a list of items, avail a weight
    Returns a tuple of the total value of a solution to the
      0/1 knapsack problem and the items of that solution"""
     if toConsider == [] or avail == 0:
         result = (0, ())
     elif toConsider[0].getCost() > avail:
         #Explore right branch only
         result = maxVal(toConsider[1:], avail)
     else:
         nextItem = toConsider[0]
         #Explore left branch
         withVal, withToTake = maxVal(toConsider[1:],
                                      avail - nextItem.getCost())
         withVal += nextItem.getValue()
         #Explore right branch
         withoutVal, withoutToTake = maxVal(toConsider[1:], avail)
         #Choose better branch
         if withVal > withoutVal:
             result = (withVal, withToTake + (nextItem,))
         else:
             result = (withoutVal, withoutToTake)
     return result
 */
func maxValue(toConsider: [Food], avail: Double) -> (Double, [Food]) {
    if toConsider.isEmpty || avail == 0.0 {
        return (0.0, [])
    } else if (toConsider[0].getCost() > avail) {
        // Explore right branch only
        return maxValue(toConsider: Array(toConsider.dropFirst()), avail: avail)
    } else {
        // Explore left branch (withVal, withToTake)
        // This branch explores taking the first `Food` item
        guard let nextItem = toConsider.first else { fatalError() }
        var leftBranchResult = maxValue(toConsider: Array(toConsider.dropFirst()), avail: avail - nextItem.getCost())
        leftBranchResult.0 += nextItem.value
        // Explore right branch (withoutVal, withoutToTake)
        // This branch explores NOT taking the first `Food` item
        let rightBranchResult = maxValue(toConsider: Array(toConsider.dropFirst()), avail: avail)
        // Choose better branch
        if leftBranchResult.0 > rightBranchResult.0 {
            return (leftBranchResult.0, leftBranchResult.1 + [nextItem])
        } else {
            return (rightBranchResult.0, rightBranchResult.1)
        }
    }
}

let stopWatch = StopWatch()
let names = ["wine", "beer", "pizza", "burger", "fries", "cola", "apple", "donut"]
let values = [89.0, 90.0, 95.0, 100.0, 90.0, 79.0, 50.0, 10.0]
let calories = [123.0, 154.0, 258.0, 354.0, 365.0, 150.0, 95.0, 195.0]
let foods = buildMenu(names: names, values: values, calories: calories)
stopWatch.start()
testGreedys(foods: foods, maxUnits: 750.0)
print("testGreedys took \(stopWatch.mark()) over \(foods.count) items")
stopWatch.start()
testMaxValue(foods: foods, maxUnits: 750.0, algorithm: maxValue(toConsider:avail:))
print("testMaxValue took \(stopWatch.mark()) over \(foods.count) items")
/**
 for numItems in (5, 10, 15, 20, 25, 30, 35, 40, 45, 50):
    items = buildLargeMenu(numItems, 90, 250)
    testMaxVal(items, 750, fastMaxVal, True)
 */

//[5, 10, 15, 20].forEach { numItems in
//    let items = buildLargeMenu(numItems: numItems, maxVal: 90.0, maxCost: 250.0)
//    testMaxValue(foods: items, maxUnits: 750, algorithm: maxValue(toConsider:avail:))
//}
