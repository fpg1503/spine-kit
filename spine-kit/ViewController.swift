//
//  ViewController.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 12/19/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation


class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let skView = SKView(frame: self.view.bounds)
        skView.ignoresSiblingOrder = true
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsDrawCount = true
        
        let scene = SKScene(size: self.view.bounds.size)
        scene.scaleMode = SKSceneScaleMode.AspectFill

        let spineBuilder = SpineBuilder()

        if let node = spineBuilder.build("skin") {

            node.position = self.view.center
            node.runAction(SKAction.scaleTo(0.4, duration: 0.0))
            node.play("idle")
            scene.addChild(node)
            
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(4 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                node.changeSkin("green")
            }
        }
        
        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)
        skView.frameInterval = 2

        self.view.addSubview(skView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

