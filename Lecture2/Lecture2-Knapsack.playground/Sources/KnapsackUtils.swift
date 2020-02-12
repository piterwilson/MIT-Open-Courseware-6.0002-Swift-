import Foundation

/**
 def buildLargeMenu(numItems, maxVal, maxCost):
     items = []
     for i in range(numItems):
         items.append(Food(str(i),
                           random.randint(1, maxVal),
                           random.randint(1, maxCost)))
     return items
 */
public func buildLargeMenu(numItems: Int, maxVal: Double, maxCost: Double) -> [Food] {
    let items: [Food] = (0..<numItems).map { index in
        Food(name: "Food \(index)", value: Double.random(in: (1...maxVal)), calories: Double.random(in: 0...maxCost))
    }
    return items
}

/**
 def testMaxVal(foods, maxUnits, algorithm, printItems = True):
     print('Menu contains', len(foods), 'items')
     print('Use search tree to allocate', maxUnits,
           'calories')
     val, taken = algorithm(foods, maxUnits)
     if printItems:
         print('Total value of items taken =', val)
         for item in taken:
             print('   ', item)
 */
public func testMaxValue(foods: [Food], maxUnits: Double, algorithm: ([Food], Double) -> (Double, [Food]) ) {
    print("Menu contains \(foods.count) items")
    print("Use search tree to allocate \(maxUnits) calories")
    let stopWatch = StopWatch()
    stopWatch.start()
    let result = algorithm(foods, maxUnits)
    let totalCalories = result.1.reduce(0.0) { (value: Double, food: Food) -> Double in
        value + food.calories
    }
    print("result took \(stopWatch.mark()) sec.")
    print("total value of items taken $\(result.0) (\(totalCalories) calories)")
    result.1.forEach { print (" \($0)")}
}
