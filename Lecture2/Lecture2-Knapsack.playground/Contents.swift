import Foundation

import Foundation

/**

Knapsack 0/1 Problem

*/

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
func maxCalories(toConsider: [Food], avail: Double) -> (Double, [Food]) {
    if toConsider.isEmpty || avail == 0.0 {
        return (0.0, [])
    } else if (toConsider[0].calories > avail) {
        // Explore right branch only
        return maxCalories(toConsider: Array(toConsider.dropFirst()), avail: avail)
    } else {
        // Explore left branch (withVal, withToTake)
        // This branch explores taking the first `Food` item
        guard let nextItem = toConsider.first else { fatalError() }
        var leftBranchResult = maxCalories(toConsider: Array(toConsider.dropFirst()), avail: avail - nextItem.calories)
        leftBranchResult.0 += nextItem.calories
        // Explore right branch (withoutVal, withoutToTake)
        // This branch explores NOT taking the first `Food` item
        let rightBranchResult = maxCalories(toConsider: Array(toConsider.dropFirst()), avail: avail)
        // Choose better branch
        if leftBranchResult.0 > rightBranchResult.0 {
            return (leftBranchResult.0, leftBranchResult.1 + [nextItem])
        } else {
            return (rightBranchResult.0, rightBranchResult.1)
        }
    }
}

/**
 for numItems in (5, 10, 15, 20, 25, 30, 35, 40, 45, 50):
    items = buildLargeMenu(numItems, 90, 250)
    testMaxVal(items, 750, fastMaxVal, True)
 */
let stopWatch = StopWatch()
[5, 10, 15, 20].forEach { numItems in
    let items = buildLargeMenu(numItems: numItems, maxVal: 90.0, maxCost: 250.0)
    stopWatch.start()
    testMaxCalories(foods: items, maxUnits: 750, algorithm: maxCalories(toConsider:avail:))
    print("testMaxVal took \(stopWatch.mark()) sec.")
}
