//
//  ViewController.swift
//  spritekit-spine-sdk
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
        
        SpineBuilder().buildSpine("example") { node in
            node.position = self.view.center
            
            scene.addChild(node)
            
        }
                
        skView.presentScene(scene)
        
        self.view.addSubview(skView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

