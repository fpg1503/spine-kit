//
//  JsonParserHelper.swift
//  spritekit-spine-sdk
//
//  Created by Thiago Medeiros dos Santos on 12/19/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation

import UIKit

struct JsonParserHelper {
    
    static func parseColor(dictionary: [String: AnyObject], key: String) -> UIColor {
        var color = UIColor.grayColor()
        if let colorValue = dictionary[key] as? String {
            color = UIColor(hex: colorValue)
        }
        return color
    }

    static func parseFloat(dictionary:[String: AnyObject], key: String) -> Float {
        var value: Float = 0
        if let dictionaryValue = dictionary[key] as? Float {
            value = dictionaryValue
        }
        return value
    }

    static func parseInt(dictionary:[String: AnyObject], key: String) -> Int {
        var value: Int = 0
        if let dictionaryValue = dictionary[key] as? Int {
            value = dictionaryValue
        }
        return value
    }

    static func parseString(dictionary:[String: AnyObject], key: String) -> String {
        var value: String = ""
        if let dictionaryValue = dictionary[key] as? String {
            value = dictionaryValue
        }
        return value
    }
}