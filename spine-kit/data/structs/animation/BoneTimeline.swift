//
//  BoneTimeline.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 12/30/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation

struct BoneTimeline {
    var name: String? = ""
    let rotate: [RotateKeyFrame]
    let translate: [TranslateKeyFrame]
    let scale: [ScaleKeyFrame]
}

extension BoneTimeline: JSONDecodable {
    
    static func decode(json: JSON?) -> BoneTimeline? {

        let rotate = decodeArray(json, key: "rotate", decode: RotateKeyFrame.decode)
        let translate = decodeArray(json, key: "translate", decode: TranslateKeyFrame.decode)
        let scale = decodeArray(json, key: "scale", decode: ScaleKeyFrame.decode)
        
        return BoneTimeline(name:  "", rotate: rotate, translate: translate, scale: scale)
    }
}
