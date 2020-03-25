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
func simWalks(numSteps: Int, numTrials: Int, drunkClass: Drunk.Type) -> [PythonObject] {
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
/*
let xVals = [PythonObject(1), PythonObject(2), PythonObject(3), PythonObject(4)]
let yVals1 = [PythonObject(1), PythonObject(2), PythonObject(3), PythonObject(4)]
pylab.plot(xVals, yVals1, "b--", label: "first")
let yVals2 = [1, 7, 3, 5]
pylab.plot(xVals, yVals2, "r--",  label: "second")
pylab.legend()
pylab.show()
*/

/**
 def simDrunk(numTrials, dClass, walkLengths):
     meanDistances = []
     for numSteps in walkLengths:
         print('Starting simulation of',
               numSteps, 'steps')
         trials = simWalks(numSteps, numTrials, dClass)
         mean = sum(trials)/len(trials)
         meanDistances.append(mean)
     return meanDistances
 */
func simDrunk(numTrials: Int, drunkClass: Drunk.Type, walkLengths: [Int]) -> [PythonObject]  {
    var meanDistances: [PythonObject] = []
    for numSteps in walkLengths {
        print("starting simulation of \(numSteps) steps")
        let trials = simWalks(numSteps: numSteps, numTrials: numTrials, drunkClass: drunkClass)
        print("Mean = \(Double(Python.sum(trials))!/Double((trials.count)))")
        let mean = Double(Python.sum(trials))!/Double(trials.count)
        meanDistances.append(PythonObject(mean))
    }
    return meanDistances
}
/**
 def simAll(drunkKinds, walkLengths, numTrials):
     styleChoice = styleIterator(('m-', 'b--', 'g-.'))
     for dClass in drunkKinds:
         curStyle = styleChoice.nextStyle()
         print('Starting simulation of', dClass.__name__)
         means = simDrunk(numTrials, dClass, walkLengths)
         pylab.plot(walkLengths, means, curStyle,
                    label = dClass.__name__)
     pylab.title('Mean Distance from Origin ('
                 + str(numTrials) + ' trials)')
     pylab.xlabel('Number of Steps')
     pylab.ylabel('Distance from Origin')
     pylab.legend(loc = 'best')

 */
func simAllPlot(drunkKinds: [Drunk.Type], walkLengths: [Int], numTrials: Int) {
    var styleChoice = StyleIterator(styles: ["m--", "b--", "g-."])
    for dClass in drunkKinds {
        let curStyle = styleChoice.next()
        print("Starting simulation of \(dClass)")
        let means = simDrunk(numTrials: numTrials, drunkClass: dClass, walkLengths: walkLengths)
        print("walkLengths.count \(walkLengths.count)")
        print("means.count \(means.count)")
        pylab.plot(walkLengths, means, curStyle, label: "\(dClass)")
    }
    pylab.title("Mean Distance from Origin \(numTrials) trials")
    pylab.xlabel("Number of Steps")
    pylab.ylabel("Distance from Origin")
    pylab.legend(loc: "best")
    pylab.show()
}
// simAllPlot(drunkKinds: [UsualDrunk.self, MasochistDrunk.self], walkLengths: [10, 100, 1000, 10000], numTrials: 100)

/**
 def getFinalLocs(numSteps, numTrials, dClass):
     locs = []
     d = dClass()
     for t in range(numTrials):
         f = OddField()
         f.addDrunk(d, Location(0, 0))
         for s in range(numSteps):
             f.moveDrunk(d)
         locs.append(f.getLoc(d))
     return locs
 */
func getFinalLocations(numSteps: Int, numTrials: Int, drunkClass: Drunk.Type, fieldClass: Field.Type) -> [Location] {
    do {
        var locations: [Location] = []
        let drunk = drunkClass.init(name: "Homer", random: random)
        for _ in 0..<numTrials {
            let field = fieldClass.init()
            try field.add(drunk: drunk, at: Location(x: 0, y: 0))
            for _ in 0..<numSteps {
                try field.move(drunk: drunk)
            }
            locations.append(try field.getLocation(for: drunk))
        }
        return locations
    } catch {
        fatalError("\(error)")
    }
}

/**
 def plotLocs(drunkKinds, numSteps, numTrials):
     styleChoice = styleIterator(('k+', 'r^', 'mo'))
     for dClass in drunkKinds:
         locs = getFinalLocs(numSteps, numTrials, dClass)
         xVals, yVals = [], []
         for loc in locs:
             xVals.append(loc.getX())
             yVals.append(loc.getY())
         xVals = pylab.array(xVals)
         yVals = pylab.array(yVals)
         meanX = sum(abs(xVals))/len(xVals)
         meanY = sum(abs(yVals))/len(yVals)
         curStyle = styleChoice.nextStyle()
         pylab.plot(xVals, yVals, curStyle,
                       label = dClass.__name__ +\
                       ' mean abs dist = <'
                       + str(meanX) + ', ' + str(meanY) + '>')
     pylab.title('Location at End of Walks ('
                 + str(numSteps) + ' steps)')
     pylab.ylim(-1000, 1000)
     pylab.xlim(-1000, 1000)
     pylab.xlabel('Steps East/West of Origin')
     pylab.ylabel('Steps North/South of Origin')
     pylab.legend(loc = 'lower center')
 */
func plotLocations(drunkKinds: [Drunk.Type], fieldClass: Field.Type, numSteps: Int, numTrials: Int) {
    var styleChoice = StyleIterator(styles: ["k+", "r^", "mo"])
    for drunkClass in drunkKinds {
        let locations = getFinalLocations(numSteps: numSteps, numTrials: numTrials, drunkClass: drunkClass, fieldClass: fieldClass)
        var xValsRaw: [PythonObject] = []
        var yValsRaw: [PythonObject] = []
        for location in locations {
            xValsRaw.append(location.x)
            yValsRaw.append(location.y)
        }
        let xVals = pylab.array(xValsRaw)
        let yVals = pylab.array(yValsRaw)
        let meanX = Python.sum(Python.abs(xVals)) / Python.len(xVals)
        let meanY = Python.sum(Python.abs(yVals)) / Python.len(yVals)
        let curStyle = styleChoice.next()
        pylab.plot(xVals, yVals, curStyle, label: "\(drunkClass)  mean abs dist = <\(meanX), \(meanY)>")
    }
    pylab.title("Location at End of Walks \(numSteps) steps")
    pylab.ylim(-1000, 1000)
    pylab.xlim(-1000, 1000)
    pylab.xlabel("Steps East/West of Origin")
    pylab.ylabel("Steps North/South of Origin")
    pylab.legend(loc: "lower center")
    pylab.show()
}
plotLocations(drunkKinds: [UsualDrunk.self, MasochistDrunk.self], fieldClass: Field.self, numSteps: 10000, numTrials: 100)
