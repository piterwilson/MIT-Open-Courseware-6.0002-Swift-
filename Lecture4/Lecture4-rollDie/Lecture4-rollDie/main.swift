//
//  main.swift
//  Lecture4-rollDie
//
//  Created by Juan Carlos Ospina Gonzalez on 02/03/2020.
//

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

func testRoll(n: Int) -> PythonObject {
    var result = PythonObject("")
    for _ in Python.range(n) {
        result += Python.str(rollDie())
    }
    return result
}

print(testRoll(n: 10))
