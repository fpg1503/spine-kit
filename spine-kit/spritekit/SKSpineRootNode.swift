//
//  SKSpineNode.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/11/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import Foundation
import SpriteKit

class SKSpineRootNode: SKNode {
    
    private var spine: SpineModel? = nil
    private var bonesMap: [String: SKNode]? = nil
    
    init(spine: SpineModel, bonesMap: [String: SKNode]) {
        self.spine = spine
        self.bonesMap = bonesMap
        super.init()
    }

    override init() {
       super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func animate(name: String) {
    }
}