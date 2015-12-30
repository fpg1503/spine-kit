//
//  SpineModel.swift
//  spritekit-spine-sdk
//
//  Created by Thiago Medeiros dos Santos on 12/18/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation

struct Skeleton {
    var name: String
    var slots: [Slot]
    var bones: [Bone]
    var skins: [Skin]
    var animations: [Animation]
    var defaultSkin: String
}
