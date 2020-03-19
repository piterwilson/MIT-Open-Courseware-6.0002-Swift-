//
//  Drunks.swift
//  Lecture-5-random-walks
//
//  Created by Juan Carlos Ospina Gonzalez on 12/03/2020.
//

import Foundation
import Python

/**
 class Drunk(object):
     def __init__(self, name = None):
         """Assumes name is a str"""
         self.name = name

     def __str__(self):
         if self != None:
             return self.name
         return 'Anonymous'

 class UsualDrunk(Drunk):
     def takeStep(self):
         stepChoices = [(0,1), (0,-1), (1, 0), (-1, 0)]
         return random.choice(stepChoices)

 class MasochistDrunk(Drunk):
     def takeStep(self):
         stepChoices = [(0.0,1.1), (0.0,-0.9),
                        (1.0, 0.0), (-1.0, 0.0)]
         return random.choice(stepChoices)
 */

struct Steps: PythonConvertible {
    var x: Double
    var y: Double
    var pythonObject: PythonObject {
        return PythonObject(tupleOf: PythonObject(self.x), PythonObject(self.y))
    }
    init(_ x: Double, _ y: Double) {
        self.x = x
        self.y = y
    }
}

class Drunk: Hashable {
    let name: String
    let random: PythonObject
    var stepChoices: PythonObject
    init(name: String, stepChoices: PythonObject, random: PythonObject) {
        self.name = name
        self.stepChoices = stepChoices
        self.random = random
    }
    func takeStep() -> PythonObject {
        return random.choice(stepChoices)
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(stepChoices)
    }
    static func == (lhs: Drunk, rhs: Drunk) -> Bool {
        return lhs.name == rhs.name && lhs.stepChoices == rhs.stepChoices
    }
}

final class UsualDrunk: Drunk {
    init(name: String, random: PythonObject) {
        let stepChoices: PythonObject = PythonObject([
            PythonObject(Steps(0.0, 1.0)),
            PythonObject(Steps(0.0, -1.0)),
            PythonObject(Steps(1.0, 0.0)),
            PythonObject(Steps(-1.0, 0.0))])
        super.init(name: name, stepChoices: stepChoices, random: random)
    }
}

final class MasochistDrunk: Drunk {
    init(name: String, random: PythonObject) {
        let stepChoices: PythonObject = PythonObject([
            PythonObject(Steps(0.0, 1.1)),
            PythonObject(Steps(0.0, -0.9)),
            PythonObject(Steps(1.0, 0.0)),
            PythonObject(Steps(-1.0, 0.0))])
        super.init(name: name, stepChoices: stepChoices, random: random)
    }
}
