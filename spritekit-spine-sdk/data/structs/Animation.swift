//
//  Animation.swift
//  spritekit-spine-sdk
//
//  Created by Thiago Medeiros dos Santos on 12/17/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation

struct Animation {
    var name: String
    var slotTimelines: [SlotTimeline]
    var boneTimelines: [BoneTimeline]
    var drawOrderKeyFrames: [DrawOrderKeyFrame]
    var events: [Event]
}

extension Animation: JSONDecodable {
    
    static func decode(json: JSON?) -> Animation? {
        
        let name = asSafeString(json, key: "name")
        let slotTimelines = parseSlotTimelines(json)
        let boneTimelines = parseBoneTimelines(json)
        let drawOrderKeyFrames = decodeArray(json, key: "drawOrder", decode: DrawOrderKeyFrame.decode)
        let events = decodeArray(json, key: "events", decode: Event.decode)
        
        return Animation(name: name, slotTimelines: slotTimelines, boneTimelines: boneTimelines, drawOrderKeyFrames: drawOrderKeyFrames, events: events)
    }
    
    static func parseSlotTimelines(json: JSON?) -> [SlotTimeline] {
        let slotsJson = asSafeJSON(json, key: "slots")
        var slots: [SlotTimeline] = []
        for (key, value) in slotsJson {
            if let value = value as? JSON {
                if var slot = SlotTimeline.decode(value) {
                    slot.name = key
                    slots.append(slot)
                }
            }
        }
        return slots
    }
    
    static func parseBoneTimelines(json: JSON?) -> [BoneTimeline] {
        let bonesJSON = asSafeJSON(json, key: "bones")
        var bones: [BoneTimeline] = []
        for (key, value) in bonesJSON {
            if let value = value as? JSON {
                if var bone = BoneTimeline.decode(value) {
                    bone.name = key
                    bones.append(bone)
                }
            }
        }
        return bones
    }
}
