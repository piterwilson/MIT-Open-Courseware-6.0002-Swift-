//
//  Operator+Exponential.swift
//
//  Created by Juan Carlos Ospina Gonzalez on 03/03/2020.
//

import Darwin
import Python

precedencegroup ExponentiationPrecedence {
  associativity: right
  higherThan: MultiplicationPrecedence
}

infix operator ** : ExponentiationPrecedence

func ** (_ base: Double, _ exp: Double) -> Double {
  return pow(base, exp)
}

func ** (_ base: Float, _ exp: Float) -> Float {
  return pow(base, exp)
}

func ** (_ base: Int, _ exp: Int) -> Double {
  return pow(Double(base), Double(exp))
}

func ** (_ base: PythonObject, _ exp: PythonObject) -> PythonObject {
    if let base = Float(base), let exp = Float(exp) {
        return PythonObject(base ** exp)
    }
    if let base = Double(base), let exp = Double(exp) {
        return PythonObject(base ** exp)
    }
    if let base = Int(base), let exp = Int(exp) {
        return PythonObject(base ** exp)
    }
    fatalError("** can only be between `PythonObject` wrapping `Double`, `Float` or `Int`")
}
