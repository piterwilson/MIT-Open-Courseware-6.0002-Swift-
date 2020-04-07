//
//  FairRoulette.swift
//  Lecture6
//
//  Created by Juan Carlos Ospina Gonzalez on 07/04/2020.
//  Copyright © 2020 piterwilsom. All rights reserved.
//

import Foundation
import Python
/**
 class FairRoulette():
 def __init__(self):
     self.pockets = []
     for i in range(1,37):
         self.pockets.append(i)
     self.ball = None
     self.pocketOdds = len(self.pockets) - 1
 def spin(self):
     self.ball = random.choice(self.pockets)
 def betPocket(self, pocket, amt):
     if str(pocket) == str(self.ball):
         return amt*self.pocketOdds
     else: return -amt
 def __str__(self):
     return 'Fair Roulette'
 */

public class FairRoulette: CustomStringConvertible {
    private var pockets: [Int] = []
    // -1 == None
    public var ball: Int = -1
    private var pocketOdds: Double
    private let random: PythonObject
    public var description: String {
        "Fair Roulette"
    }
    public init() {
        for i in 0..<37 {
            pockets.append(i)
        }
        random = Python.import("random")
        pocketOdds = Double(pockets.count - 1)
    }
    public func spin() {
        ball = Int(random.choice(PythonObject(pockets))) ?? -1
    }
    public func betPocket(_ pocket: Int, amount: Double) -> Double {
        if pocket == ball {
            return amount * pocketOdds
        } else {
            return -amount
        }
    }
}
