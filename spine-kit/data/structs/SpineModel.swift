//
//  SpineModel.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 12/18/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation

struct SpineModel {
    var name: String?
    let slots: [Slot]?
    let bones: [Bone]?
    let skins: [Skin]?
    let animations: [Animation]?
    let defaultSkin: String
}

extension SpineModel: JSONDecodable {
    
    static func decode(json: JSON?) -> SpineModel? {
        
        let slots = decodeArray(json, key: "slots", decode: Slot.decode)
        let bones = decodeArray(json, key: "bones", decode: Bone.decode)
        let skins = parseSkin(json)
        let animations = parseAnimation(json)
        let defaultSkin = asSafeString(json, key: "defaultSkin", defaultValue: "default")
        
        return SpineModel(name: "", slots: slots, bones: bones, skins: skins, animations: animations, defaultSkin: defaultSkin)
    }
    
    static func parseAnimation(json: JSON?) -> [Animation]? {
        var result: [Animation] = []
        let animationJSONs = asSafeJSON(json, key: "animations")
        
        for (animationName, value) in animationJSONs {
            
            if let animationJSON = value as? JSON {
                if var animation = Animation.decode(animationJSON) {
                    animation.name = animationName
                    result.append(animation)
                }
            }
        }
        return result
    }
    
    static func parseSkin(json: JSON?) -> [Skin]? {
        let skinsJSON = asSafeJSON(json, key: "skins")
        var skins: [Skin] = []
        for (key, value) in skinsJSON {
            if let value = value as? JSON {
                if var skin = Skin.decode(value) {
                    skin.name = key
                    skins.append(skin)
                }
            }
        }
        return skins
    }

}
