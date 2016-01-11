//
//  SlotColorKeyFrame.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 12/30/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation

import UIKit

struct ColorTransitionKeyFrame {
    var time: Double
    var color: UIColor?
    var curve: Curve?
}

extension ColorTransitionKeyFrame: JSONDecodable {
    
    static func decode(json: JSON?) -> ColorTransitionKeyFrame? {
        
        let time = asSafeDouble(json, key: "time")
        let color = asSafeString(json, key: "color", defaultValue: "#FFFFFFFF")
        
        return ColorTransitionKeyFrame(time: time, color: UIColor(hex: color), curve: Curve.decode(json))
    }
}
