//
//  Location.swift
//  Lecture-5-random-walks
//
//  Created by Juan Carlos Ospina Gonzalez on 12/03/2020.
//

import Foundation
import Python
/*
 class Location(object):
 def __init__(self, x, y):
     """x and y are numbers"""
     self.x = x
     self.y = y

 def move(self, deltaX, deltaY):
     """deltaX and deltaY are numbers"""
     return Location(self.x + deltaX, self.y + deltaY)

 def getX(self):
     return self.x

 def getY(self):
     return self.y

 def distFrom(self, other):
     xDist = self.x - other.getX()
     yDist = self.y - other.getY()
     return (xDist**2 + yDist**2)**0.5

 def __str__(self):
     return '<' + str(self.x) + ', ' + str(self.y) + '>'
 */

struct Location {
    var x: PythonObject
    var y: PythonObject
    func move(deltaX: PythonObject, deltaY: PythonObject) -> Location {
        return Location(x: x + deltaX, y: y + deltaY)
    }
    func distFrom(_ location: Location) -> PythonObject {
        let xDist = x - location.x
        let yDist = y - location.y
        return (xDist ** 2 + yDist ** 2) ** 0.5
    }
}
