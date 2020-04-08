//
//  AmericanRoulette.swift
//  Lecture6
//
//  Created by Juan Carlos Ospina Gonzalez on 08/04/2020.
//  Copyright © 2020 piterwilsom. All rights reserved.
//

import Foundation

/*
 class AmRoulette(EuRoulette):
     def __init__(self):
         EuRoulette.__init__(self)
         self.pockets.append('00')
     def __str__(self):
         return 'American Roulette'
 */
public final class AmericanRoulette: EuroRoulette {
    override init() {
        super.init()
        pockets.append("00")
    }
    override public var description: String {
        "American Roulette"
    }
}
