//
//  Events.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 12/20/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

struct Event {
    var name: String
    var int: Int?
    var double: Double?
    var string: String?
}

extension Event: JSONDecodable {
    
    static func decode(json: JSON?) -> Event? {
        
        let name = asSafeString(json, key: "name")
        let int = asInt(json, key: "int")
        let double = asDouble(json, key: "float") //Float in this case is represented by double due precision point
        let string = asString(json, key: "string")
        
        return Event(name: name, int: int, double: double, string: string)
    }
}
