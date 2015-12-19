//
//  UIColoFromHexString.swift
//  spritekit-spine-sdk
//
//  Created by Thiago Medeiros dos Santos on 12/18/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(hex: String) {
        
        var clearHex: String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (clearHex.hasPrefix("#")) {
            clearHex = (clearHex as NSString).substringFromIndex(1)
        }

        var red: CUnsignedInt = 0, green: CUnsignedInt = 0, blue: CUnsignedInt = 0;
        
        if (clearHex.characters.count == 6) {
            
            let redString = (clearHex as NSString).substringToIndex(2)
            let greenString = ((clearHex as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
            let blueString = ((clearHex as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
            
            NSScanner(string: redString).scanHexInt(&red)
            NSScanner(string: greenString).scanHexInt(&green)
            NSScanner(string: blueString).scanHexInt(&blue)
        }
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(1))

    }
}