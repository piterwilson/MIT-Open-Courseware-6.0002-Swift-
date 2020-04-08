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
