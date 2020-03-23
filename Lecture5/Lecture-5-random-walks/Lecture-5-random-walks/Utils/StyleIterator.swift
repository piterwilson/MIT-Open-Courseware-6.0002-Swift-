//
//  StyleIterator.swift
//  Lecture-5-random-walks
//
//  Created by Juan Carlos Ospina Gonzalez on 23/03/2020.
//  Copyright © 2020 Juan Carlos Ospina Gonzalez. All rights reserved.
//

import Foundation

/**
 class styleIterator(object):
     def __init__(self, styles):
         self.index = 0
         self.styles = styles

     def nextStyle(self):
         result = self.styles[self.index]
         if self.index == len(self.styles) - 1:
             self.index = 0
         else:
             self.index += 1
         return result
 */
struct StyleIterator {
    var index: Int = 0
    var styles: [String] = []
    mutating func next() -> String {
        guard styles.count > 0 else { fatalError("no styles to give") }
        let result = styles[index]
        if index + 1 == result.count {
            index = 0
        } else {
            index += 1
        }
        return result
    }
}
