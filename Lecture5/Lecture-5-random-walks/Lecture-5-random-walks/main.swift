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
        for _ in 0..<numSteps {
            try field.move(drunk: drunk)
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
