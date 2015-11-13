//
//  GameScene.swift
//  Hexacolors
//
//  Created by Joshua Liu on 10/24/14.
//  Copyright (c) 2014 Joshua Liu. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let labelColorArray = [SKColor.redColor(),SKColor(red: 0, green: 116/255, blue: 217/255, alpha: 1),SKColor.darkTextColor(),SKColor.orangeColor(),SKColor.purpleColor()]
    var mode = NSUserDefaults.standardUserDefaults().stringForKey("hexacolorsmode")
    var infiniteLabel = SKLabelNode()
    var secondLabel = SKLabelNode()
    var reverseLabel = SKLabelNode()
    
    override func   didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        let randomNum = Int(arc4random_uniform(5))
        
        if (mode != "Infinite" && mode != "10 Seconds" && mode != "Reverse") {
            mode = "Infinite"
            NSUserDefaults.standardUserDefaults().setObject("Infinite", forKey: "hexacolorsmode")
            NSUserDefaults.standardUserDefaults().synchronize()
        } else {
            //do nothing
        }
        
        self.backgroundColor = SKColor.whiteColor()
        
        let hexacolorsLabel = SKLabelNode()
        hexacolorsLabel.text = "Hexacolors"
        hexacolorsLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMaxY(self.frame)-150);
        hexacolorsLabel.fontColor = SKColor.darkTextColor()
        hexacolorsLabel.fontSize = 55
        hexacolorsLabel.alpha = 1
        
        self.addChild(hexacolorsLabel)
        
        if (mode == "Infinite") {
            infiniteLabel.alpha = 1
            secondLabel.alpha = 0
            reverseLabel.alpha = 0
        } else if (mode == "Reverse") {
            reverseLabel.alpha = 1
            infiniteLabel.alpha = 0
            secondLabel.alpha = 0
        } else {
            infiniteLabel.alpha = 0
            secondLabel.alpha = 1
            reverseLabel.alpha = 0
        }
        infiniteLabel.text = "Infinite"
        infiniteLabel.fontColor = labelColorArray[randomNum]
        infiniteLabel.fontSize = 40
        infiniteLabel.name = "mode"
        infiniteLabel.position = CGPoint(x: CGRectGetMinX(self.frame)+360, y: CGRectGetMinY(self.frame)+15)
        
        self.addChild(infiniteLabel)
        
        secondLabel.text = "10 Seconds"
        secondLabel.fontColor = labelColorArray[randomNum]
        secondLabel.fontSize = 40
        secondLabel.name = "mode"
        secondLabel.position = CGPoint(x: CGRectGetMinX(self.frame)+410, y: CGRectGetMinY(self.frame)+15)
        
        self.addChild(secondLabel)
        
        reverseLabel.text = "Reverse"
        reverseLabel.fontColor = labelColorArray[randomNum]
        reverseLabel.fontSize = 40
        reverseLabel.name = "mode"
        reverseLabel.position = CGPoint(x: CGRectGetMinX(self.frame)+370, y: CGRectGetMinY(self.frame)+15)
        
        self.addChild(reverseLabel)
        
        let playLabel = SKLabelNode()
        playLabel.text = "Play";
        playLabel.fontSize = 65;
        playLabel.name = "playButton"
        playLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        playLabel.fontColor = labelColorArray[randomNum]
        
        self.addChild(playLabel)
        
        let fadein = SKAction.runBlock({
            hexacolorsLabel.runAction(SKAction.fadeInWithDuration(1.5))
        })
        let fadeout = SKAction.runBlock({
            hexacolorsLabel.runAction(SKAction.fadeOutWithDuration(1.5))
        })
        let wait = SKAction.waitForDuration(2)
        
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([wait,fadeout,wait,fadein])))
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) { 
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            
            if (touchedNode.name == "playButton") {
                let transition = SKTransition.revealWithDirection(SKTransitionDirection.Right, duration: 0.2)
                NSUserDefaults.standardUserDefaults().setObject(mode, forKey: "hexacolorsmode")
                NSUserDefaults.standardUserDefaults().synchronize()
                if (mode == "Infinite") {
                    let scene = InifiniteScene()
                    scene.size = self.size
                    scene.scaleMode = SKSceneScaleMode.AspectFill
                    
                    self.scene?.view?.presentScene(scene, transition: transition)
                } else if (mode == "Reverse") {
                    let scene = ReverseScene()
                    scene.size = self.size
                    scene.scaleMode = SKSceneScaleMode.AspectFill
                    
                    self.scene?.view?.presentScene(scene, transition: transition)
                } else {
                    let scene = HexacolorsScene()
                    scene.size = self.size
                    scene.scaleMode = SKSceneScaleMode.AspectFill
                    
                    self.scene?.view?.presentScene(scene, transition: transition)
                }
                
            } else if (touchedNode.name == "mode") {
                
                let smallWait = SKAction.waitForDuration(0.2)
                
                if (mode == "Infinite") {
                    mode = "10 Seconds"
                    NSUserDefaults.standardUserDefaults().setObject("10 Seconds", forKey: "hexacolorsmode")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    infiniteLabel.runAction(SKAction.fadeOutWithDuration(0.5))
                    secondLabel.runAction(SKAction.sequence([smallWait,SKAction.fadeInWithDuration(0.5)]))
                } else if (mode == "10 Seconds") {
                    mode = "Reverse"
                    NSUserDefaults.standardUserDefaults().setObject("Reverse", forKey: "hexacolorsmode")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    secondLabel.runAction(SKAction.fadeOutWithDuration(0.5))
                    reverseLabel.runAction(SKAction.sequence([smallWait,SKAction.fadeInWithDuration(0.5)]))
                } else {
                    mode = "Infinite"
                    NSUserDefaults.standardUserDefaults().setObject("Infinite", forKey: "hexacolorsmode")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    reverseLabel.runAction(SKAction.fadeOutWithDuration(0.5))
                    infiniteLabel.runAction(SKAction.sequence([smallWait,SKAction.fadeInWithDuration(0.5)]))
                }
                
            } else {
                //lol
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
