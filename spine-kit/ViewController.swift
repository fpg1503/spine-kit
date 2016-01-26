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
        
     /*   if let node = spineBuilder.build("powerup") {
            
            node.position = self.view.center
            node.runAction(SKAction.scaleTo(0.4, duration: 0.0))
            node.play("animation")
            node.position = CGPoint(x: CGFloat(node.position.x), y:CGFloat(400))
            scene.addChild(node)
        }*/
        
        if let node = spineBuilder.build("movile") {

            node.position = self.view.center
            node.runAction(SKAction.scaleTo(0.4, duration: 0.0))
            node.play("idle")
            node.position = CGPoint(x: CGFloat(node.position.x), y:CGFloat(270))
            scene.addChild(node)
            
            var delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                node.stop()
                
                delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
                dispatch_after(delayTime, dispatch_get_main_queue()) {
                    node.play("idle")
                }
            }
        }

        if let node = spineBuilder.build("dragon") {
            
            node.position = self.view.center
            node.runAction(SKAction.scaleTo(0.3, duration: 0.0))
            node.play("flying")
            node.position = CGPoint(x: CGFloat(node.position.x), y:CGFloat(100))

            let audioPlayer = self.getDragonSoundPlayer()
            node.registerToEvent("sound", function: { (text, decimalNumber, integerNumber) -> Void in
                audioPlayer?.stop()
                audioPlayer?.currentTime = 0
                audioPlayer?.play()
            })
            
            scene.addChild(node)
            
            var delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
                node.pause()
                
                delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
                dispatch_after(delayTime, dispatch_get_main_queue()) {
                    node.resume()
                }
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
    
    private func getDragonSoundPlayer() -> AVAudioPlayer? {
        // Grab the path, make sure to add it to your project!
        let sound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("dragon-bite", ofType: "mp3") ?? "")
        var audioPlayer: AVAudioPlayer? = nil
        
        // Initial setup
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: sound, fileTypeHint: nil) as AVAudioPlayer
            audioPlayer?.prepareToPlay()
        } catch {
            print("Fail to load sound file: \(error)")
        }
        return audioPlayer
    }


}

