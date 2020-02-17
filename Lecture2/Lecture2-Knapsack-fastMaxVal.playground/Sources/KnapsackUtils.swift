import Foundation

public struct FastMaxValKey: Hashable {
    public var itemCount: Int
    public var available: Int
    public init(itemCount: Int, available: Int) {
        self.itemCount = itemCount
        self.available = available
    }
}

public struct KnapSackResult {
    public var totalValue: Double
    public var itemsTaken: [Food]
    public init(totalValue: Double, itemsTaken: [Food]) {
        self.totalValue = totalValue
        self.itemsTaken = itemsTaken
    }
    public mutating func addValue(_ val: Double) {
        self.totalValue += val
    }
}

/**
 def buildMenu(names, values, calories):
     menu = []
     for i in range(len(values)):
         menu.append(Food(names[i], values[i],
                           calories[i]))
     return menu
 */
public func buildMenu(names: [String], values: [Double], calories: [Int]) -> [Food] {
    guard names.count == values.count, values.count == calories.count else {
        fatalError("`names`, `values` and `calories` must have the same `count`")
    }
    return (0..<names.count).map {index in
        return Food(name: names[index], value: values[index], calories: calories[index])
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
public func buildLargeMenu(numItems: Int, maxVal: Double, maxCost: Int) -> [Food] {
    let items: [Food] = (0..<numItems).map { index in
        Food(name: "Food \(index)", value: Double.random(in: (1...maxVal)), calories: Int.random(in: 0..<maxCost))
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
public func testMaxValue(foods: [Food], maxUnits: Int, algorithm: ([Food], Int) -> KnapSackResult ) {
    print("Menu contains \(foods.count) items")
    print("Use search tree to allocate \(maxUnits) calories")
    let stopWatch = StopWatch()
    stopWatch.start()
    let result = algorithm(foods, maxUnits)
    let totalCalories = getTotalCalories(in: result.itemsTaken)
    print("result took \(stopWatch.mark()) sec.")
    print("total value of items taken $\(result.totalValue) (\(totalCalories) calories)")
    result.itemsTaken.forEach { print (" \($0)")}
}

public func testFastMaxValue(foods: [Food], maxUnits: Int, algorithm: (([Food], Int, inout [FastMaxValKey: KnapSackResult]) -> KnapSackResult), memo: inout [FastMaxValKey : KnapSackResult]) {
    print("Menu contains \(foods.count) items")
    print("Use search tree (with cache) to allocate \(maxUnits) calories")
    let stopWatch = StopWatch()
    stopWatch.start()
    let result = algorithm(foods, maxUnits, &memo)
    let totalCalories = getTotalCalories(in: result.itemsTaken)
    print("result took \(stopWatch.mark()) sec.")
    print("total value of items taken $\(result.totalValue) (\(totalCalories) calories)")
    result.itemsTaken.forEach { print (" \($0)")}
}

public func getTotalCalories(in foods: [Food]) -> Int {
    return foods.reduce(0) { (value: Int, food: Food) -> Int in
        value + food.calories
    }
}
