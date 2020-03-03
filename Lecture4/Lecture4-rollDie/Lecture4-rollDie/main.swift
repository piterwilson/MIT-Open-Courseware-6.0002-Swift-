//
//  main.swift
//  Lecture4-rollDie
//
//  Created by Juan Carlos Ospina Gonzalez on 02/03/2020.
//
import Darwin
import Python
print(Python.version) //  Sanity check, prints 3.8.1 (v3.8.1:1b293b6006, Dec 18 2019, 14:08:53)
let random = Python.import("random")

/*
 def rollDie():
     """returns a random int between 1 and 6"""
     return random.choice([1,2,3,4,5,6])
*/
func rollDie() -> PythonObject {
    random.choice([1,2,3,4,5,6])
}

 /*
 def testRoll(n = 10):
     result = ''
     for i in range(n):
         result = result + str(rollDie())
     print(result)
 */


/// Simulates a test dice roll. This version takes a Swift `Int` as parameteer `n`.
/// - Parameter n: Number of times to roll the simulated dice.
/// - Returns: A `PythonObject` of type string with the result of the simulated dice rolls.
func testRoll(n: Int) -> PythonObject {
    var result = PythonObject("")
    for _ in Python.range(n) {
        result += Python.str(rollDie())
    }
    return result
}

/// Simulates a test dice roll. This version takes a `PythonObject` of type integer as parameteer `n`.
/// - Parameter n: Number of times to roll the simulated dice.
/// - Returns: A `PythonObject` of type string with the result of the simulated dice rolls.
func testRoll(n: PythonObject) -> PythonObject {
    var result = PythonObject("")
    for _ in Python.range(n) {
        result += Python.str(rollDie())
    }
    return result
}

/// Simulates a test dice roll. This version takes a `PythonObject` of type integer as parameteer `n`.
/// - Parameter n: Number of times to roll the simulated dice.
/// - Returns: A Swift `String` with the result of the simulated dice rolls.
func testRollSwiftString(n: PythonObject) -> String {
    var result = ""
    for _ in Python.range(n) {
        result += String(Python.str(rollDie())) ?? ""
    }
    return result
}

let possibleOutcomesDice = PythonObject(6)
/// Calculates the actual probability of an outcome of consecutive dice rolls
/// - Parameter goal: String representing and outcome of consecutive dice rolls. ie "123"
func calculateDieRollProbability(goal: PythonObject) ->PythonObject {
    return Python.round(1/(possibleOutcomesDice ** Python.len(goal)), 8)
}

/*
 def runSim(goal, numTrials, txt):
     total = 0
     for i in range(numTrials):
         result = ''
         for j in range(len(goal)):
             result += str(rollDie())
         if result == goal:
             total += 1
     print('Actual probability of', txt, '=',
           round(1/(6**len(goal)), 8))
     estProbability = round(total/numTrials, 8)
     print('Estimated Probability of', txt, '=',
           round(estProbability, 8))
 */
func runSim(goal: PythonObject, numTrials: Int) {
    var total = 0
    let numTrialsRange = Python.range(numTrials)
    let goalRange = Python.range(Python.len(goal))
    for _ in numTrialsRange {
        var result = PythonObject("")
        for _ in goalRange {
            result += Python.str(rollDie())
        }
        if result == goal {
            total += 1
        }
    }
    print("Actual probability of \(goal) = \(calculateDieRollProbability(goal: goal))")
    let estProbability = Python.round(PythonObject(total) / PythonObject(numTrials), 8)
    print("Es probability of \(goal) in \(numTrials) attempts = \(estProbability)")
}
random.seed(0)
let stopWatch = StopWatch()
stopWatch.start()
print(testRoll(n: 10))
print("rolling 10 times (Swift) took \(stopWatch.mark()) sec.")
stopWatch.start()
print(testRoll(n: PythonObject(10)))
print("rolling 10 times (Python) took \(stopWatch.mark()) sec.")
//print(testRollSwiftString(n: PythonObject(10)))
stopWatch.start()
print(runSim(goal: "1111", numTrials: 1000000))
print("rolling 1'000.000 times took \(stopWatch.mark()) sec.")
