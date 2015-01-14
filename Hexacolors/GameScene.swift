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
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.backgroundColor = SKColor.whiteColor()
        
        var hexacolorsLabel = SKLabelNode()
        hexacolorsLabel.text = "Hexacolors"
        hexacolorsLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMaxY(self.frame)-150);
        hexacolorsLabel.fontColor = SKColor.darkTextColor()
        hexacolorsLabel.fontSize = 55
        hexacolorsLabel.alpha = 1
        
        self.addChild(hexacolorsLabel)
        
        let myLabel = SKLabelNode()
        myLabel.text = "Play";
        myLabel.fontSize = 65;
        myLabel.name = "playButton"
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        var randomNum = Int(arc4random_uniform(5))
        myLabel.fontColor = labelColorArray[randomNum]
        
        self.addChild(myLabel)
        
        var fadein = SKAction.runBlock({
            hexacolorsLabel.runAction(SKAction.fadeInWithDuration(1.5))
        })
        var fadeout = SKAction.runBlock({
            hexacolorsLabel.runAction(SKAction.fadeOutWithDuration(1.5))
        })
        var wait = SKAction.waitForDuration(2)
        
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([wait,fadeout,wait,fadein])))
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            
            if (touchedNode.name == "playButton") {
                let transition = SKTransition.revealWithDirection(SKTransitionDirection.Right, duration: 0.2)
                let scene = HexacolorsScene()
                scene.size = self.size
                scene.scaleMode = SKSceneScaleMode.AspectFill
                
                self.scene?.view?.presentScene(scene, transition: transition)
            } else {
                
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
