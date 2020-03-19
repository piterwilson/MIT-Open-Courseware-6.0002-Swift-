//
//  Field.swift
//  Lecture-5-random-walks
//
//  Created by Juan Carlos Ospina Gonzalez on 12/03/2020.
//

import Foundation
import Python

/**
 
 class Field(object):
 def __init__(self):
     self.drunks = {}
     
 def addDrunk(self, drunk, loc):
     if drunk in self.drunks:
         raise ValueError('Duplicate drunk')
     else:
         self.drunks[drunk] = loc
         
 def moveDrunk(self, drunk):
     if drunk not in self.drunks:
         raise ValueError('Drunk not in field')
     xDist, yDist = drunk.takeStep()
     #use move method of Location to get new location
     self.drunks[drunk] =\
         self.drunks[drunk].move(xDist, yDist)
     
 def getLoc(self, drunk):
     if drunk not in self.drunks:
         raise ValueError('Drunk not in field')
     return self.drunks[drunk]
 
 */

enum FieldError: Error {
    case duplicateDrunk
    case drunkNotInField
}

class Field {
    var drunks: [Drunk: Location] = [:]
    func add(drunk: Drunk, at location: Location) throws {
        if drunks[drunk] != nil {
            throw FieldError.duplicateDrunk
        } else {
            drunks[drunk] = location
        }
    }
    func move(drunk: Drunk) throws {
        guard let location = drunks[drunk] else {
            throw FieldError.drunkNotInField
        }
        let steps = drunk.takeStep().tuple2
        drunks[drunk] = location.move(deltaX: steps.0, deltaY: steps.1)
    }
    func getLocation(for drunk: Drunk) throws -> Location {
        guard let location = drunks[drunk] else {
            throw FieldError.drunkNotInField
        }
        return location
    }
}
