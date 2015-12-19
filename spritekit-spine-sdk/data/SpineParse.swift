//
//  SpineParse.swift
//  spritekit-spine-sdk
//
//  Created by Thiago Medeiros dos Santos on 12/17/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation
import UIKit

class SpineParse {

    func parse(name: String, data: String) -> SpineModel? {

        var result: SpineModel?

        do {
            if !data.isEmpty {
                
                let json = try NSJSONSerialization.JSONObjectWithData((data as NSString).dataUsingEncoding(NSUTF8StringEncoding)!, options: .AllowFragments)
                
                if let verifiedJson = json as? [String: AnyObject] {
                    result = SpineModel(
                        name: name,
                        slots: self.parseSlots(verifiedJson),
                        bones: self.parseBones(verifiedJson),
                        skins: self.parseSkins(verifiedJson),
                        animations: self.parseAnimations(verifiedJson))
                }
                
            }
        } catch {
            print("Error serializing JSON: \(error)")
        }
        
        return result
    }
    
    func parseSlots(json: [String: AnyObject]) -> [Slot] {

        var result = [Slot]()
        
        if let slots = json["slots"] as? [[String: String]] {
            
            for slot in slots {
            
                if let name = slot["name"] {
                    result.append(
                        Slot(name: name,
                            bone: JsonParserHelper.parseString(slot, key:"bone"),
                            color: JsonParserHelper.parseColor(slot, key:"color"),
                            attachment: JsonParserHelper.parseString(slot, key:"attachment")));
                } else {
                    print("Warning parsing JSON, slot name not found")
                }
            }
        }
        return result
    }
    
    func parseBones(json: [String: AnyObject]) -> [Bone] {
        
        var result = [Bone]()

        if let bones = json["bones"] as? [[String: AnyObject]] {
            
            for bone in bones {
                
                if let name = bone["name"] as? String {
                    result.append(Bone(name: name ,
                                        length: JsonParserHelper.parseInt(bone, key: "length"),
                                        x: JsonParserHelper.parseFloat(bone, key: "x"),
                                        y: JsonParserHelper.parseFloat(bone, key: "y"),
                                        scaleX: JsonParserHelper.parseFloat(bone, key: "scaleX"),
                                        scaleY: JsonParserHelper.parseFloat(bone, key: "scaleY"),
                                        rotation: JsonParserHelper.parseFloat(bone, key: "rotation")))
                } else {
                    print("Warning parsing JSON, bone name not found")
                }
            }
        }
        return result
    }
    
    func parseSkins(json: [String: AnyObject]) -> [Skin] {
        
        var result = [Skin]()
        
        if let skins = json["skins"] as? [String: AnyObject] {

            for (name, skin) in skins {
                
                if let verifiedSkin = skin as? [String: AnyObject] {
                    result.append(self.parseSkin(verifiedSkin, name:name))
                }
            }
        }
        
        return result
    }
    
    func parseSkin(dictionary: [String: AnyObject], name: String) -> Skin {
        
        var result = Skin(name: "", entries: [:])
        
        for (slot, value) in dictionary {
            
            if let verifiedValue = value as? [String: [String: AnyObject]] {
                
                for (attachment, entry) in verifiedValue {
                    
                    var skinEntries = Dictionary<PairKey<String, String>, Attachment>()
                    skinEntries[PairKey(key1: slot, key2: attachment)] = self.parseAttachment(entry)
                    result = Skin(name: name, entries: skinEntries)
                }
            }
        }
        return result
    }
    
    func parseAttachment(dictionary: [String: AnyObject]) -> Attachment {
        return Attachment(
            name: JsonParserHelper.parseString(dictionary, key: "name"),
            x: JsonParserHelper.parseFloat(dictionary, key: "x"),
            y: JsonParserHelper.parseFloat(dictionary, key: "y"),
            scaleX: JsonParserHelper.parseFloat(dictionary, key: "scaleX"),
            scaleY: JsonParserHelper.parseFloat(dictionary, key: "scaleY"),
            rotation: JsonParserHelper.parseFloat(dictionary, key: "rotation"),
            width: JsonParserHelper.parseInt(dictionary, key: "width"),
            height: JsonParserHelper.parseInt(dictionary, key: "height"))
    }
    
    func parseAnimations(json: [String: AnyObject]) -> [Animation] {
        
        var result = [Animation]()
        
        if let animations = json["animations"] as? [String: [String: AnyObject]] {
            
            for (name, animation) in animations {
                var parsedBones = [String: [Timeline]]()
                
                if let bones = animation["bones"] as? [String: [String: [AnyObject]]] {

                    for (boneName, timelines) in bones  {

                        parsedBones[boneName] = self.parseTimelines(timelines)
                        
                    }
                    result.append(Animation(name: name, bones: parsedBones))
                }
            }
        }

        return result
    }
    
    func parseTimelines(json: [String: [AnyObject]]) -> [Timeline] {
        var result = [Timeline]()

        for (type, timelines) in json {

            var timelineEntries = [TimelineEntry]()
            
            if let verifiedTimelines = timelines as? [[String: AnyObject]] {
                
                for timeline in verifiedTimelines {
                    
                    let timelineEntry =
                        TimelineEntry(time: JsonParserHelper.parseFloat(timeline, key: "time"),
                                      angle: JsonParserHelper.parseFloat(timeline, key: "angle"),
                                      x: JsonParserHelper.parseFloat(timeline, key: "x"),
                                      y: JsonParserHelper.parseFloat(timeline, key: "y"),
                                      curve: self.parseCurve(timeline, key: "curve"))
                    timelineEntries.append(timelineEntry);
                }
                
                var timelineType = TimelineType.Undefined
                if (type == "rotate") { timelineType = TimelineType.Rotate }
                if (type == "translate") { timelineType = TimelineType.Translate }
                if (type == "scale") { timelineType = TimelineType.Scale }
                
                result.append(Timeline(type: timelineType, timelineEntries: timelineEntries))
            }
        }
        return result
    }
    
    func parseCurve(dictionary: [String: AnyObject], key: String) -> Curve {
        var result = Curve.Undefined
        
        if let curve = dictionary["curve"] as? String {

            if (curve == "stepped") { result = Curve.Stepped }
        
        } else if let curve = dictionary["curve"] as? [Float] {
            
            result = Curve.Bezier(curve)
            
        }
        return result;
    }
}