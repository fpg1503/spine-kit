//
//  EventHandler.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/24/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

typealias SpineKitEventFunction = (text: String, decimalNumber: Double, integerNumber: Int) -> Void

class EventHandler {
    
    private var functions: [String: [String: SpineKitEventFunction]] = [:]
    
    func registerToEvent(eventName: String, functionId: String?, function: SpineKitEventFunction) -> Bool {
        var result: Bool = false
        if var functionsArray = self.functions[eventName] {
           functionsArray[functionId ?? "Default"] = function
            result = true
        }
        return result
    }

    func unregisterToEvent(eventName: String, functionId: String?) -> Bool {
        return self.functions[eventName]?.removeValueForKey(functionId ?? "Default") == nil ? false : true
    }
    
    func removeEventFunctions(eventName: String) -> Bool {
        return self.functions.removeValueForKey(eventName) == nil ? false : true
    }

}