//
//  main.swift
//  Lecture-5-random-walks
//
//  Created by Juan Carlos Ospina Gonzalez on 12/03/2020.
//

import Foundation
import Python
print(Python.version) //  Sanity check, prints 3.8.1 (v3.8.1:1b293b6006, Dec 18 2019, 14:08:53)
let pylab = Python.import("pylab")
let random = Python.import("random")
setupPylabGraphStyles(pylab: pylab)
/**
 def walk(f, d, numSteps):
     """Assumes: f a Field, d a Drunk in f, and numSteps an int >= 0.
        Moves d numSteps times, and returns the distance between
        the final location and the location at the start of the
        walk."""
     start = f.getLoc(d)
     for s in range(numSteps):
         f.moveDrunk(d)
     return start.distFrom(f.getLoc(d))
 */
func walk(field: Field, drunk: Drunk, numSteps: Int) -> PythonObject {
    do {
        let start = try field.getLocation(for: drunk)
        //print("start \(start)")
        for _ in 0..<numSteps {
            try field.move(drunk: drunk)
            //print(try field.getLocation(for: drunk))
        }
        return start.distFrom(try field.getLocation(for: drunk))
    } catch {
        fatalError("\(error)")
    }
}
/**
 def simWalks(numSteps, numTrials, dClass):
 """Assumes numSteps an int >= 0, numTrials an int > 0,
      dClass a subclass of Drunk
    Simulates numTrials walks of numSteps steps each.
    Returns a list of the final distances for each trial"""
     Homer = dClass('Homer')
     origin = Location(0, 0)
     distances = []
     for t in range(numTrials):
         f = Field()
         f.addDrunk(Homer, origin)
         distances.append(round(walk(f, Homer,
                                     numTrials), 1))
     return distances
 */
func simWalks(numSteps: Int, numTrials: Int, drunkClass: Drunk.Type) -> [PythonObject]{
    do {
        let homer = drunkClass.init(name: "homer", random: random)
        let origin = Location(x: PythonObject(0), y: PythonObject(0))
        var distances: [PythonObject] = []
        for _ in 0..<numTrials {
            let field = Field()
            try field.add(drunk: homer, at: origin)
            distances.append(walk(field: field, drunk: homer, numSteps: numSteps))
        }
        return distances
    } catch {
        fatalError("\(error)")
    }
}
// print(simWalks(numSteps: 10, numTrials: 100, drunkClass: UsualDrunk.self))
/**
 def drunkTest(walkLengths, numTrials, dClass):
     """Assumes walkLengths a sequence of ints >= 0
          numTrials an int > 0, dClass a subclass of Drunk
        For each number of steps in walkLengths, runs simWalks with
          numTrials walks and prints results"""
     for numSteps in walkLengths:
         distances = simWalks(numSteps, numTrials, dClass)
         print(dClass.__name__, 'random walk of', numSteps, 'steps')
         print(' Mean =', round(sum(distances)/len(distances), 4))
         print(' Max =', max(distances), 'Min =', min(distances))
 
 random.seed(0)
 drunkTest((10, 100, 1000, 10000), 100, UsualDrunk)
 */
func drunkTest(walkLengths: [Int], numTrials: Int, drunkClass: Drunk.Type) {
    for numSteps in walkLengths {
        let distances = simWalks(numSteps: numSteps, numTrials: numTrials, drunkClass: drunkClass)
        print("\(drunkClass) random walk of \(numSteps)")
        print("Mean = \(Double(Python.sum(distances))!/Double((distances.count)))")
        print("Max = \(Python.max(distances)), Min \(Python.min(distances))")
    }
}
random.seed(0)
// drunkTest(walkLengths: [0, 1, 2], numTrials: 100, drunkClass: UsualDrunk.self)

/**
 def simAll(drunkKinds, walkLengths, numTrials):
 for dClass in drunkKinds:
     drunkTest(walkLengths, numTrials, dClass
 */
func simAll(drunkKinds: [Drunk.Type], walkLengths: [Int], numTrials: Int) {
    for dClass in drunkKinds {
        drunkTest(walkLengths: walkLengths, numTrials: numTrials, drunkClass: dClass)
    }
}

//random.seed(0)
//simAll(drunkKinds: [UsualDrunk.self, MasochistDrunk.self], walkLengths: [1000, 10000], numTrials: 100)

let xVals = [PythonObject(1), PythonObject(2), PythonObject(3), PythonObject(4)]
let yVals1 = [PythonObject(1), PythonObject(2), PythonObject(3), PythonObject(4)]
pylab.plot(xVals, yVals1, "b--", label: "first")
let yVals2 = [1, 7, 3, 5]
pylab.plot(xVals, yVals2, "r--",  label: "second")
pylab.legend()
pylab.show()
