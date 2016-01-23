//
//  UIColorRGB.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/23/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import UIKit

extension UIColor {

    func getRGBA() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        var result: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) = (r: 0, g: 0, b: 0, a: 0)
        
        if self.getRed(&red, green: &green , blue: &blue, alpha: &alpha) {
            result = (r: red, g: green, b: blue, a: alpha)
        }
        return result
    }

}