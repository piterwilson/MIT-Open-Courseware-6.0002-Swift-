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

/**
 import random, pylab

 #set line width
 pylab.rcParams['lines.linewidth'] = 4
 #set font size for titles
 pylab.rcParams['axes.titlesize'] = 20
 #set font size for labels on axes
 pylab.rcParams['axes.labelsize'] = 20
 #set size of numbers on x-axis
 pylab.rcParams['xtick.labelsize'] = 16
 #set size of numbers on y-axis
 pylab.rcParams['ytick.labelsize'] = 16
 #set size of ticks on x-axis
 pylab.rcParams['xtick.major.size'] = 7
 #set size of ticks on y-axis
 pylab.rcParams['ytick.major.size'] = 7
 #set size of markers, e.g., circles representing points
 #set numpoints for legend
 pylab.rcParams['legend.numpoints'] = 1

 */
