//
//  endScene.swift
//  Hexacolors
//
//  Created by Joshua Liu on 10/24/14.
//  Copyright (c) 2014 Joshua Liu. All rights reserved.
//

import SpriteKit

class endScene: SKScene {
    
    var mode = ""
    var score = 0
    var time = Float()
    var scoreFloat = Float()
    var highscore : Int = NSUserDefaults.standardUserDefaults().integerForKey("hexacolorhs")
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        if (mode == "Infinite") {
            highscore = NSUserDefaults.standardUserDefaults().integerForKey("infinitehs")
            if (score >= highscore) {
                highscore = score
                NSUserDefaults.standardUserDefaults().setObject(highscore, forKey: "infinitehs")
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        } else {
            if (score >= highscore) {
                highscore = score
                NSUserDefaults.standardUserDefaults().setObject(highscore, forKey: "hexacolorhs")
                NSUserDefaults.standardUserDefaults().synchronize()
            }
        }
        
        scoreFloat = Float(score)/time
        var tps = NSString(format: "%.2f", scoreFloat)
        
        self.backgroundColor = SKColor.whiteColor()
        
        let myLabel = SKLabelNode()
        myLabel.text = "Game Over"
        myLabel.fontColor = SKColor.darkTextColor()
        myLabel.fontSize = 65;
        myLabel.name = "playButton"
        myLabel.color = SKColor.grayColor()
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)+200);
        
        let scoreLabel = SKLabelNode()
        scoreLabel.text = "Score"
        scoreLabel.fontColor = SKColor.darkTextColor()
        scoreLabel.fontSize = 40
        scoreLabel.position = CGPoint(x:CGRectGetMidX(self.frame)-75, y:CGRectGetMidY(self.frame));
        
        let scoreL = SKLabelNode()
        scoreL.text = "\(score)"
        scoreL.fontColor = SKColor.darkTextColor()
        scoreL.fontSize = 40
        scoreL.position = CGPoint(x:CGRectGetMidX(self.frame)-75, y:CGRectGetMidY(self.frame)-60);
        
        let bestLabel = SKLabelNode()
        bestLabel.text = "Best"
        bestLabel.fontColor = SKColor.darkTextColor()
        bestLabel.fontSize = 40
        bestLabel.position = CGPoint(x: CGRectGetMidX(self.frame)+75, y: CGRectGetMidY(self.frame))
        
        let bestLabel1 = SKLabelNode()
        bestLabel1.text = "\(highscore)"
        bestLabel1.fontColor = SKColor.darkTextColor()
        bestLabel1.fontSize = 40
        bestLabel1.position = CGPoint(x: CGRectGetMidX(self.frame)+75, y: CGRectGetMidY(self.frame)-60)
        
        let tpsLabel = SKLabelNode()
        if scoreFloat.isNaN {
            tpsLabel.text = "0 colors per second"
        } else {
            tpsLabel.text = "\(tps) colors per second"
        }
        tpsLabel.fontColor = SKColor.darkTextColor()
        tpsLabel.fontSize = 30
        tpsLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)-200);
        
        
        self.addChild(bestLabel)
        self.addChild(bestLabel1)
        self.addChild(scoreL)
        self.addChild(myLabel)
        self.addChild(scoreLabel)
        self.addChild(tpsLabel)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            let transition = SKTransition.revealWithDirection(SKTransitionDirection.Right, duration: 0.2)
            let scene = GameScene()
            scene.size = self.size
            scene.scaleMode = SKSceneScaleMode.AspectFill
            
            self.scene?.view?.presentScene(scene, transition: transition)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
