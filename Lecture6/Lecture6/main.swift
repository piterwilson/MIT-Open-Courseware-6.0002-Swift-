//
//  main.swift
//  Lecture6
//
//  Created by Juan Carlos Ospina Gonzalez on 07/04/2020.
//  Copyright © 2020 piterwilsom. All rights reserved.
//

import Foundation
import Python
print(Python.version) //  Sanity check, prints 3.8.1 (v3.8.1:1b293b6006, Dec 18 2019, 14:08:53)
let pylab = Python.import("pylab")
let random = Python.import("random")
setupPylabGraphStyles(pylab: pylab)

/*
 def playRoulette(game, numSpins, pocket, bet, toPrint):
     totPocket = 0
     for i in range(numSpins):
         game.spin()
         totPocket += game.betPocket(pocket, bet)
     if toPrint:
         print(numSpins, 'spins of', game)
         print('Expected return betting', pocket, '=',\
               str(100*totPocket/numSpins) + '%\n')
     return (totPocket/numSpins)
 */
func playRoulette(game: FairRoulette,  numSpins: Int, pocket: String, bet: Double) -> Double {
    var totPocket: Double = 0
    for _ in 0..<numSpins {
        game.spin()
        totPocket += game.betPocket(pocket, amount: bet)
    }
    print("\(numSpins) spins of \(game)")
    print("Expected return betting pocket: \(pocket)")
    let returnPercentage = totPocket / Double(numSpins)
    print("\(100 * returnPercentage)%")
    return returnPercentage
}
/*
 random.seed(0)
 game = FairRoulette()
 for numSpins in (100, 1000000):
     for i in range(3):
         playRoulette(game, numSpins, 2, 1, True)
 */
random.seed(0)
let game = FairRoulette()
for numSpins in [100, 10000] {
    for _ in 0..<3 {
        playRoulette(game: game, numSpins: numSpins, pocket: "2", bet: 1)
    }
}
/**
 def findPocketReturn(game, numTrials, trialSize, toPrint):
     pocketReturns = []
     for t in range(numTrials):
         trialVals = playRoulette(game, trialSize, 2, 1, toPrint)
         pocketReturns.append(trialVals)
     return pocketReturns
 */
func findPocketReturn(game: FairRoulette, numTrials: Int, trialSize: Int) -> [Double] {
    var pocketReturns: [Double] = []
    for _ in 0..<numTrials {
        let trialsVals = playRoulette(game: game, numSpins: trialSize, pocket: "2", bet: 1)
        pocketReturns.append(trialsVals)
    }
    return pocketReturns
}
/**
 random.seed(0)
 numTrials = 20
 resultDict = {}
 games = (FairRoulette, EuRoulette, AmRoulette)
 for G in games:
     resultDict[G().__str__()] = []
 for numSpins in (1000, 10000, 100000, 1000000):
     print('\nSimulate', numTrials, 'trials of',
           numSpins, 'spins each')
     for G in games:
         pocketReturns = findPocketReturn(G(), numTrials,
                                          numSpins, False)
         expReturn = 100*sum(pocketReturns)/len(pocketReturns)
         print('Exp. return for', G(), '=',
              str(round(expReturn, 4)) + '%')
 */
random.seed(0)
let numTrials = 20
var resultDict: [String: [Double]] = [:]
let games = [FairRoulette(), EuroRoulette(), AmericanRoulette()]
for game in games {
    resultDict["\(game)"] = []
    for numSpins in [1000, 10000, 100000] {
        print("Simulate \(numTrials) trails of numSpins \(numSpins) each")
        for game in games {
            let pocketReturns = findPocketReturn(game: game, numTrials: numTrials, trialSize: numSpins)
            let expReturn = 100 * (pocketReturns.reduce(0.0, { $0 + $1 }) / Double(pocketReturns.count))
            print("expected return for \(game) = \(expReturn)%")
        }
    }
}
