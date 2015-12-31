//
//  JsonSerializable.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 12/21/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation

import UIKit

typealias JSON = Dictionary<String, AnyObject>

protocol JSONDecodable {
    
    static func decode(json: JSON?) -> Self?
    
}

extension JSONDecodable {
    
    static func asString(json: JSON?, key: String?, defaultValue: String? = nil) -> String? {
        return asGeneric(json, key: key, defaultValue: defaultValue)
    }
    
    static func asSafeString(json: JSON?, key: String?, defaultValue: String? = "") -> String! {
        return asSafeGeneric(json, key: key, safeValue: "", defaultValue: defaultValue)
    }
    
    static func asDouble(json: JSON?, key: String?, defaultValue: Double? = nil) -> Double? {
        return asGeneric(json, key: key, defaultValue: defaultValue)
    }

    static func asSafeDouble(json: JSON?, key: String?, defaultValue: Double? = 0.0) -> Double! {
        return asSafeGeneric(json, key: key, safeValue: 0.0, defaultValue: defaultValue)
    }
    
    static func asFloat(json: JSON?, key: String?, defaultValue: Float? = nil) -> Float? {
        return asGeneric(json, key: key, defaultValue: defaultValue)
    }
    
    static func asSafeFloat(json: JSON?, key: String?, defaultValue: Float? = 0.0) -> Float! {
        return asSafeGeneric(json, key: key, safeValue: 0.0, defaultValue: defaultValue)
    }

    static func asInt(json: JSON?, key: String?, defaultValue: Int? = nil) -> Int? {
        return asGeneric(json, key: key, defaultValue: defaultValue)
    }

    static func asSafeInt(json: JSON?, key: String?, defaultValue: Int? = 0) -> Int! {
        return asSafeGeneric(json, key: key, safeValue: 0, defaultValue: defaultValue)
    }

    static func asBool(json: JSON?, key: String?, defaultValue: Bool? = nil) -> Bool? {
        return asGeneric(json, key: key, defaultValue: defaultValue)
    }
    
    static func asSafeBool(json: JSON?, key: String?, defaultValue: Bool? = false) -> Bool! {
        return asSafeGeneric(json, key: key, safeValue: false, defaultValue: defaultValue)
    }
    
    static func asJSON(json: JSON?, key:String?, defaultValue: JSON? = nil) -> JSON? {
        return asGeneric(json, key: key, defaultValue: defaultValue)
    }
    
    static func asSafeJSON(json: JSON?, key:String?, defaultValue: JSON? = [:]) -> JSON! {
        return asSafeGeneric(json, key: key, safeValue: [:], defaultValue: defaultValue)
    }

    static func asStringArray(json: JSON?, key:String?, defaultValue: [String]? = nil) -> [String]? {
        return asGeneric(json, key: key, defaultValue: defaultValue)
    }
    
    static func asSafeStringArray(json: JSON?, key:String?, defaultValue: [String]? = []) -> [String]! {
        return asSafeGeneric(json, key: key, safeValue: [], defaultValue: defaultValue)
    }
    
    static func asDoubleArray(json: JSON?, key:String?, defaultValue: [Double]? = nil) -> [Double]? {
        return asGeneric(json, key: key, defaultValue: defaultValue)
    }
    
    static func asSafeDoubleArray(json: JSON?, key:String?, defaultValue: [Double]? = []) -> [Double]! {
        return asSafeGeneric(json, key: key, safeValue: [], defaultValue: defaultValue)
    }
    
    static func asFloatArray(json: JSON?, key:String?, defaultValue: [Float]? = nil) -> [Float]? {
        return asGeneric(json, key: key, defaultValue: defaultValue)
    }
    
    static func asSafeFloatArray(json: JSON?, key:String?, defaultValue: [Float]? = []) -> [Float]! {
        return asSafeGeneric(json, key: key, safeValue: [], defaultValue: defaultValue)
    }
    
    static func asIntArray(json: JSON?, key:String?, defaultValue: [Int]? = nil) -> [Int]? {
        return asGeneric(json, key: key, defaultValue: defaultValue)
    }
    
    static func asSafeIntArray(json: JSON?, key:String?, defaultValue: [Int]? = []) -> [Int]! {
        return asSafeGeneric(json, key: key, safeValue: [], defaultValue: defaultValue)
    }
    
    static func asBoolArray(json: JSON?, key:String?, defaultValue: [Bool]? = nil) -> [Bool]? {
        return asGeneric(json, key: key, defaultValue: defaultValue)
    }
    
    static func asSafeBoolArray(json: JSON?, key:String?, defaultValue: [Bool]? = []) -> [Bool]! {
        return asSafeGeneric(json, key: key, safeValue: [], defaultValue: defaultValue)
    }
    
    static func asJSONArray(json: JSON?, key:String?, defaultValue: [JSON]? = nil) -> [JSON]? {
        return asGeneric(json, key: key, defaultValue: defaultValue)
    }
    
    static func asSafeJSONArray(json: JSON?, key:String?, defaultValue: [JSON]? = []) -> [JSON]! {
        return asSafeGeneric(json, key: key, safeValue: [], defaultValue: defaultValue)
    }
    
    static func asGeneric<T>(json: JSON?, key: String?, defaultValue: T?) -> T? {
        
        if let verifiedJson = json, let verifiedKey = key {
            if let object = verifiedJson[verifiedKey] as? T {
                return object
            }
        }
        return defaultValue
    }

    static func asSafeGeneric<T>(json: JSON?, key: String?, safeValue: T!, defaultValue: T!) -> T! {
        var result = safeValue
        if let optionalValue = asGeneric(json, key: key, defaultValue: defaultValue) {
            result = optionalValue
        }
        return result
    }
    
    static func decodeArray<T>(json: JSON?, key: String?, decode: (json: JSON?) -> T?) -> [T]{
        var result: [T] = []
        let arrayJSON = asSafeJSONArray(json, key: key)
        for jsonItem in arrayJSON {
            if let item = decode(json: jsonItem) {
                result.append(item)
            }
        }
        return result
    }
}