//
//  EuroRoulette.swift
//  Lecture6
//
//  Created by Juan Carlos Ospina Gonzalez on 08/04/2020.
//  Copyright © 2020 piterwilsom. All rights reserved.
//

import Foundation
import Python

/**
 class EuRoulette(FairRoulette):
     def __init__(self):
         FairRoulette.__init__(self)
         self.pockets.append('0')
     def __str__(self):
         return 'European Roulette'
 */

public class EuroRoulette: FairRoulette {
    override init() {
        super.init()
        pockets.append("0")
    }
    override public var description: String {
        "European Roulette"
    }
}
