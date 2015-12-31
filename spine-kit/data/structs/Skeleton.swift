//
//  Skeleton.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 12/30/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation


struct Skeleton {
    var hash: String?
    var spine: String?
    var width: Double?
    var height: Double?
}


extension Skeleton: JSONDecodable {
    
    static func decode(json: JSON?) -> Skeleton? {
        
        let hash = asString(json, key: "hash")
        let spine = asString(json, key: "spine")
        
        let width = asSafeDouble(json, key:"width", defaultValue: 0.0)
        let height = asSafeDouble(json, key:"height", defaultValue: 0.0)
        
        return Skeleton(hash: hash, spine: spine, width: width, height: height)
    }
}
