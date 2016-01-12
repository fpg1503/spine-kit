//
//  Animation.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 12/17/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

struct Animation {
    var name: String
    let slotTimelines: [SlotTimeline]
    let boneTimelines: [BoneTimeline]
    let drawOrderTimeline: [DrawOrderKeyFrame]
    let events: [Event]
}

extension Animation: JSONDecodable {
    
    static func decode(json: JSON?) -> Animation? {
        
        let name = asSafeString(json, key: "name")
        let slotTimelines = parseSlotTimelines(json)
        let boneTimelines = parseBoneTimelines(json)
        let drawOrderTimeline = decodeArray(json, key: "drawOrder", decode: DrawOrderKeyFrame.decode)
        let events = decodeArray(json, key: "events", decode: Event.decode)
        
        return Animation(name: name, slotTimelines: slotTimelines, boneTimelines: boneTimelines, drawOrderTimeline: drawOrderTimeline, events: events)
    }
    
    static func parseSlotTimelines(json: JSON?) -> [SlotTimeline] {
        let slotsJSON = asSafeJSON(json, key: "slots")
        var slots: [SlotTimeline] = []
        for (key, value) in slotsJSON {
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
