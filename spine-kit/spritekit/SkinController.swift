//
//  SkinController.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/27/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

class SkinController {
    
    private let skins: [Skin]?
    
    init(skins: [Skin]?) {
       self.skins = skins
    }
    
    func findSkinByName(name: String?) -> Skin? {
        let skins = self.skins?.filter{ (skin) in skin.name == name }
        return skins?.count > 0 ? skins?.first : nil
    }
}
