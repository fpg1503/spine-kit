//
//  UIColoFromHexString.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 12/18/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import UIKit

struct Text2ColorComponents {
    
    static func parse(hex: String) -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        let clearHex = removeHashIfNeeded(hex)
        let textSize = clearHex.characters.count
        let hasAlpha = (textSize == 8)
        let isValidSize = (textSize == 6 || textSize == 8)
        
        let rgb: (red: CGFloat, green: CGFloat, blue: CGFloat)
        let alpha: CGFloat
        
        if (isValidSize) {
            rgb = parseRGB(clearHex)
            alpha = hasAlpha ? parseAlpha(clearHex) : 1
            return (rgb.red, rgb.green, rgb.blue, alpha)
        }
        
        return nil
    }

    static func removeHashIfNeeded(hex: String) -> String {
        var clearHex: String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (clearHex.hasPrefix("#")) {
            clearHex = (clearHex as NSString).substringFromIndex(1)
        }
        return clearHex
    }
    
    static func parseAlpha(clearHex: String) -> CGFloat {
        var alpha: CUnsignedInt = 1;
        
        let alphaString = ((clearHex as NSString).substringFromIndex(6) as NSString).substringToIndex(2)
        NSScanner(string: alphaString).scanHexInt(&alpha)
        return CGFloat(alpha)
    }
    
    static func parseRGB(clearHex: String) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        var red: CUnsignedInt = 0
        var green: CUnsignedInt = 0
        var blue: CUnsignedInt = 0
        
        let redString = (clearHex as NSString).substringToIndex(2)
        let greenString = ((clearHex as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
        let blueString = ((clearHex as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
        
        NSScanner(string: redString).scanHexInt(&red)
        NSScanner(string: greenString).scanHexInt(&green)
        NSScanner(string: blueString).scanHexInt(&blue)
        return (CGFloat(red), CGFloat(green), CGFloat(blue))
    }
}

extension UIColor {
    
    convenience init(hex: String) {
        
        let colorComponents = Text2ColorComponents.parse(hex)
        if let colorComponents = colorComponents {
            self.init(red: colorComponents.red/255.0, green: colorComponents.green/255.0, blue: colorComponents.blue/255.0, alpha: colorComponents.alpha/255.0)
        } else {
            self.init()
        }
    }
    
}