//
//  main.swift
//  Lecture4-Birthdays
//
//  Created by Juan Carlos Ospina Gonzalez on 03/03/2020.
//

import Darwin
import Python
print(Python.version) //  Sanity check, prints 3.8.1 (v3.8.1:1b293b6006, Dec 18 2019, 14:08:53)
let random = Python.import("random")

/**
def sameDate(numPeople, numSame):
    possibleDates = range(366)
#    possibleDates = 4*list(range(0, 57)) + [58]\
#                    + 4*list(range(59, 366))\
#                    + 4*list(range(180, 270))
    birthdays = [0]*366
    for p in range(numPeople):
        birthDate = random.choice(possibleDates)
        birthdays[birthDate] += 1
    return max(birthdays) >= numSame
 */
func sameDate(numPeople: PythonObject, numSame: PythonObject) -> Bool {
    let possibleDates = Python.range(366)
    var birthdays = PythonObject([0] * 366)
    for _ in Python.range(numPeople) {
        let birthDate = random.choice(possibleDates)
        birthdays[birthDate] += 1
    }
    return Python.max(birthdays) >= numSame
}
/**
 def birthdayProb(numPeople, numSame, numTrials):
     numHits = 0
     for t in range(numTrials):
         if sameDate(numPeople, numSame):
             numHits += 1
     return numHits/numTrials

 import math
*/
func birthdayProb(numPeople: PythonObject, numSame: PythonObject, numTrials: PythonObject) -> PythonObject {
    var numHits = PythonObject(0)
    for _ in Python.range(numTrials) {
        if sameDate(numPeople: numPeople, numSame: numSame) {
            numHits += PythonObject(1)
        }
    }
    return numHits / numTrials
}

for numPeople in PythonObject([10, 20, 40, 100]) {
    print("For \(numPeople) est. prob. of a shared birthday is  \(birthdayProb(numPeople: numPeople, numSame: 2, numTrials: 10000))")
}

/**
 for numPeople in [10, 20, 40, 100]:
     print('For', numPeople,
           'est. prob. of a shared birthday is',
           birthdayProb(numPeople, 2, 10000))
     numerator = math.factorial(366)
     denom = (366**numPeople)*math.factorial(366-numPeople)
     print('Actual prob. for N = 100 =',
           1 - numerator/denom)
 */
