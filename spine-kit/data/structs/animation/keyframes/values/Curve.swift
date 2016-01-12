//
//  Curve.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 12/17/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//


enum Curve {
    case Stepped
    case Linear
    case Bezier([Double])
}

extension Curve: JSONDecodable {
    
    static func decode(json: JSON?) -> Curve? {
        
        var result: Curve? = Curve.Linear
        
        if let stringValue = asString(json, key:"curve") where stringValue == "stepped" {
            result = Curve.Stepped
        }
        if let doubleVector = asDoubleArray(json, key: "curve") {
            result = Curve.Bezier(doubleVector)
        }
        return result
    }
    
}
