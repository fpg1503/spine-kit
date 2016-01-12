//
//  Skins.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 12/16/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

struct Skin {
    var name: String
    let attachments: [String : [String : Attachment]]
}

extension Skin: JSONDecodable {
    
    static func decode(json: JSON?) -> Skin? {
        var attachments: [String : [String : Attachment]] = [:]

        if let verifiedJson = json {
            attachments = parseSlots(verifiedJson)
        }
        return Skin(name: "", attachments: attachments)
    }
    
    static func parseSlots(json: JSON) -> [String : [String : Attachment]] {
        var attachments: [String : [String : Attachment]] = [:]
        
        for (slotName, slotJSON) in json {
            if let json = slotJSON as? JSON {
                attachments[slotName] = parseAttachmentOfSlots(json)
            }
        }
        return attachments
    }
    
    static func parseAttachmentOfSlots(json: JSON) -> [String: Attachment] {
        var attachmentMap: [String: Attachment] = [:]
        
        for (attachmentName, attachmentJSON) in json {
            
            if let attachment = attachmentJSON as? JSON {
                attachmentMap[attachmentName] = Attachment.decode(attachment)
            }
        }
        return attachmentMap
    }
}

