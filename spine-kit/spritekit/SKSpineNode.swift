//
//  SKSpineNode.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 1/11/16.
//  Copyright © 2016 Thiago Medeiros dos Santos. All rights reserved.
//

import SpriteKit

class SKSpineNode: SKNode {
    
    private var animationController: AnimationController?

    init(animationController: AnimationController?) {
        super.init()
        self.animationController = animationController
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func play(name: String, times: Int? = nil) {
        if let animationController = self.animationController {
            animationController.play(name, times: times)
        }
    }
    
    func findAnimatedNode(name: String) -> SKNode? {
        return animationController?.findAnimatedNode(name)
    }
    
    func setupPose() {
        for child in self.children {
            if let boneChild = child as? SKBoneNode {
                boneChild.setupPose()
            }
        }
    }
}