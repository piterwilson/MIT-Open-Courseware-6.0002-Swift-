import Foundation

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
func maxValue(toConsider: [Food], avail: Int) -> KnapSackResult {
    if toConsider.isEmpty || avail == 0 {
        return KnapSackResult(totalValue: 0, itemsTaken: [])
    } else if (toConsider[0].getCost() > avail) {
        // Explore right branch only
        return maxValue(toConsider: Array(toConsider.dropFirst()), avail: avail)
    } else {
        // Explore left branch (withVal, withToTake)
        // This branch explores taking the first `Food` item
        guard let nextItem = toConsider.first else { fatalError() }
        var leftBranchResult = maxValue(toConsider: Array(toConsider.dropFirst()), avail: avail - nextItem.getCost())
        leftBranchResult.addValue(nextItem.value)
        // Explore right branch (withoutVal, withoutToTake)
        // This branch explores NOT taking the first `Food` item
        let rightBranchResult = maxValue(toConsider: Array(toConsider.dropFirst()), avail: avail)
        // Choose better branch
        if leftBranchResult.totalValue > rightBranchResult.totalValue {
            return KnapSackResult(totalValue: leftBranchResult.totalValue, itemsTaken: leftBranchResult.itemsTaken + [nextItem])
        } else {
            return rightBranchResult
        }
    }
}

/**
 def fastMaxVal(toConsider, avail, memo = {}):
     """Assumes toConsider a list of subjects, avail a weight
          memo supplied by recursive calls
        Returns a tuple of the total value of a solution to the
          0/1 knapsack problem and the subjects of that solution"""
     if (len(toConsider), avail) in memo:
         result = memo[(len(toConsider), avail)]
     elif toConsider == [] or avail == 0:
         result = (0, ())
     elif toConsider[0].getCost() > avail:
         #Explore right branch only
         result = fastMaxVal(toConsider[1:], avail, memo)
     else:
         nextItem = toConsider[0]
         #Explore left branch
         withVal, withToTake =\
                  fastMaxVal(toConsider[1:],
                             avail - nextItem.getCost(), memo)
         withVal += nextItem.getValue()
         #Explore right branch
         withoutVal, withoutToTake = fastMaxVal(toConsider[1:],
                                                 avail, memo)
         #Choose better branch
         if withVal > withoutVal:
             result = (withVal, withToTake + (nextItem,))
         else:
             result = (withoutVal, withoutToTake)
     memo[(len(toConsider), avail)] = result
     return result
 */
func fastMaxValue(toConsider: [Food], avail: Int, memo: inout [FastMaxValKey: KnapSackResult]) -> KnapSackResult {
    var result: KnapSackResult!
    if let cached = memo[FastMaxValKey(itemCount: toConsider.count, available: avail)] {
        //print("---> used cached result!")
        result = cached
    } else if toConsider.isEmpty || avail == 0 {
        result = KnapSackResult(totalValue: 0, itemsTaken: [])
    } else if (toConsider[0].getCost() > avail) {
        // Explore right branch only
        result = fastMaxValue(toConsider: Array(toConsider.dropFirst()), avail: avail, memo: &memo)
    } else {
        // Explore left branch (withVal, withToTake)
        // This branch explores taking the first `Food` item
        guard let nextItem = toConsider.first else { fatalError() }
        var leftBranchResult = fastMaxValue(toConsider: Array(toConsider.dropFirst()), avail: avail - nextItem.getCost(), memo: &memo)
        leftBranchResult.addValue(nextItem.value)
        // Explore right branch (withoutVal, withoutToTake)
        // This branch explores NOT taking the first `Food` item
        let rightBranchResult = fastMaxValue(toConsider: Array(toConsider.dropFirst()), avail: avail, memo: &memo)
        // Choose better branch
        if leftBranchResult.totalValue > rightBranchResult.totalValue {
            result =  KnapSackResult(totalValue: leftBranchResult.totalValue, itemsTaken: leftBranchResult.itemsTaken + [nextItem])
        } else {
            result = rightBranchResult
        }
    }
    memo[FastMaxValKey(itemCount: toConsider.count, available: avail)] = result
    return result
}

for numItems in [30, 40, 50] {
    let foods = buildLargeMenu(numItems: numItems, maxVal: 1000, maxCost: 750)
    var memo: [FastMaxValKey : KnapSackResult] = [:]
    testFastMaxValue(foods: foods, maxUnits: 750, algorithm: fastMaxValue(toConsider:avail:memo:), memo: &memo)
    testMaxValue(foods: foods, maxUnits: 750, algorithm: maxValue(toConsider:avail:))
}

