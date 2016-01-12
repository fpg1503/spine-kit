//
//  SKSpineNode.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/11/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

class SKSpineRootNode: SKNode {
    
    var animationController: AnimationController?
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(spine: SpineModel?, bonesDict: [String: SKNode]?) {
        self.animationController = AnimationController(animations: spine?.animations, bonesDict: bonesDict)
    }
    
    func play(name: String) {
        if let animationController = self.animationController {
            animationController.play(name)
        }
    }
}