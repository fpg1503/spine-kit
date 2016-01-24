//
//  EventHandler.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/24/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//
import Foundation

typealias SpineKitEventFunction = (text: String?, decimalNumber: Double?, integerNumber: Int?) -> Void

class EventHandler {
    
    private var functions: [String: [String: SpineKitEventFunction]] = [:]
    
    func registerToEvent(eventName: String, functionId: String?, function: SpineKitEventFunction) {

        var functionsDict = self.functions[eventName] ?? [:]
        
        functionsDict[functionId ?? "Default"] = function
        self.functions[eventName] = functionsDict
    }

    func unregisterToEvent(eventName: String, functionId: String?) -> Bool {
        return self.functions[eventName]?.removeValueForKey(functionId ?? "Default") == nil ? false : true
    }
    
    func removeEventFunctions(eventName: String) -> Bool {
        return self.functions.removeValueForKey(eventName) == nil ? false : true
    }

    func fire(eventName: String, text: String?, decimalNumber: Double?, integerNumber: Int?) {
        
        if let functions = self.functions[eventName] {
        
            functions.values.forEach { function in
            
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                    function(text: text, decimalNumber: decimalNumber, integerNumber:  integerNumber)
                }
            }
        }
    }
    
}