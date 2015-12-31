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
    let events: [Event]?
    let animations: [Animation]?
    let defaultSkin: String
}

extension SpineModel: JSONDecodable {
    
    static func decode(json: JSON?) -> SpineModel? {
        
        let slots = decodeArray(json, key: "slots", decode: Slot.decode)
        let bones = decodeArray(json, key: "bones", decode: Bone.decode)
        let skins = parseSkin(json)
        let events = decodeArray(json, key: "events", decode: Event.decode)
        let animations = decodeArray(json, key: "animations", decode: Animation.decode)
        let defaultSkin = asSafeString(json, key: "defaultSkin", defaultValue: "default")
        
        return SpineModel(name: "", slots: slots, bones: bones, skins: skins, events: events, animations: animations, defaultSkin: defaultSkin)
    }
    
    static func parseSkin(json: JSON?) -> [Skin] {
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
