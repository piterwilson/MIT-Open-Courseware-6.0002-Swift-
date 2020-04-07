//
//  PylabUtils.swift
//  Lecture6
//
//  Created by Juan Carlos Ospina Gonzalez on 07/04/2020.
//  Copyright © 2020 piterwilsom. All rights reserved.
//

import Foundation
import Python
func setupPylabGraphStyles(pylab: PythonObject) {
    // set line width
    pylab.rcParams["lines.linewidth"] = 4
    // set font size for titles
    pylab.rcParams["axes.titlesize"] = 20
    // set font size for labels on axes
    pylab.rcParams["axes.labelsize"] = 20
    // set size of numbers on x-axis
    pylab.rcParams["xtick.labelsize"] = 16
    // set size of numbers on y-axis
    pylab.rcParams["ytick.labelsize"] = 16
    // set size of ticks on x-axis
    pylab.rcParams["xtick.major.size"] = 7
    // set size of ticks on y-axis
    pylab.rcParams["ytick.major.size"] = 7
    // set size of markers, e.g., circles representing points
    // st numpoints for legend
    pylab.rcParams["legend.numpoints"] = 1
    // print(pylab.rcParams)
}
