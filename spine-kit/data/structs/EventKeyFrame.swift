//
//  Events.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 12/20/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

struct EventKeyFrame {
    var name: String
    var time: Double
    var int: Int?
    var double: Double?
    var string: String?
}

extension EventKeyFrame: JSONDecodable {
    
    static func decode(json: JSON?) -> EventKeyFrame? {
        
        let name = asSafeString(json, key: "name")
        let time = asSafeDouble(json, key: "time")
        let int = asInt(json, key: "int")
        let double = asDouble(json, key: "float") //Float in this case is represented by double due precision point
        let string = asString(json, key: "string")
        
        return EventKeyFrame(name: name, time: time, int: int, double: double, string: string)
    }
}
