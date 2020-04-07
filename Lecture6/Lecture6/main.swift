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
