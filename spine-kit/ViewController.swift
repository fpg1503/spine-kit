//
//  ViewController.swift
//  spine-kit
//
//  Created by Thiago Medeiros dos Santos on 12/19/15.
//  Copyright © 2015 Thiago Medeiros dos Santos. All rights reserved.
//

import UIKit
import SpriteKit



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

        if let node = SpineBuilder().build("speedy") {

            node.position = self.view.center
            node.runAction(SKAction.scaleTo(0.4, duration: 0.0))
            node.play("run")

            scene.addChild(node)
        }

        skView.presentScene(scene)
        skView.frameInterval = 2

        self.view.addSubview(skView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

