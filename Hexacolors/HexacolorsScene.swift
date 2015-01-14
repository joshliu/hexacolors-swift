//
//  HexacolorsScene.swift
//  Hexacolors
//
//  Created by Joshua Liu on 10/24/14.
//  Copyright (c) 2014 Joshua Liu. All rights reserved.
//

import SpriteKit

class HexacolorsScene: SKScene {
    var time = Float(10)
    var score = 0
    let colorArray = ["red","orange","yellow","green","blue","purple"]
    let labelColorArray = [SKColor.redColor(),SKColor.blueColor(),SKColor.greenColor(),SKColor.orangeColor(),SKColor.purpleColor()]
    var timestring = NSString()
    var hundreths = 0
    var hundrethsString = ""
    
    var gamebool = false
    
    var colorBlue = SKColor(red: 0, green: 116/255, blue: 217/255, alpha: 1)
    var colorRed  = SKColor(red: 1, green: 65/255, blue: 54/255, alpha: 1)
    var colorGreen = SKColor(red: 46/225, green: 204/255, blue: 64/255, alpha: 1)
    var colorOrange = SKColor(red: 1, green: 133/255, blue: 27/255, alpha: 1)
    var colorPurple = SKColor(red: 177/225, green: 13/255, blue: 201/255, alpha: 1)
    var colorYellow = SKColor(red: 1, green: 220/255, blue: 0, alpha: 1)
    
    var colorLabel = SKLabelNode()
    var timerLabel = SKLabelNode()
    var scoreLabel = SKLabelNode()
    var instructions = SKLabelNode()
    var instructions2 = SKLabelNode()
    var randomColor = ""
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */ 
        
        self.backgroundColor = SKColor.whiteColor()
        self.name = "background"
        
        timerLabel.fontSize = 36
        timerLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)+200)
        timerLabel.text = "\(timestring)\(hundrethsString)"
        timerLabel.fontColor = SKColor.darkTextColor()
        timerLabel.alpha = 0
        
        self.addChild(timerLabel)
        
        colorLabel.fontSize = 40
        colorLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)+140)
        colorLabel.alpha = 0
        updateColorLabel()
        self.addChild(colorLabel)
        
        instructions.fontSize = 36
        instructions.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)+200)
        instructions.alpha = 0
        instructions.text = "Tap the colors"
        instructions.fontColor = SKColor.darkTextColor()
        self.addChild(instructions)
        
        instructions2.fontSize = 36
        instructions2.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)+160)
        instructions2.alpha = 0
        instructions2.text = "of the hexagon"
        instructions2.fontColor = SKColor.darkTextColor()
        self.addChild(instructions2)
        
        let position = CGPoint(x:CGRectGetMidX(self.frame)-150, y:CGRectGetMidY(self.frame)-150)
        
        let redNode = SKShapeNode()
        let redLine = CGPathCreateMutable()
        redNode.name = "red"
        CGPathMoveToPoint(redLine, nil, 150, 125)
        CGPathAddLineToPoint(redLine, nil, 258, 187.5)
        CGPathAddLineToPoint(redLine, nil, 150, 250)
        redNode.path = redLine
        redNode.strokeColor = colorRed
        redNode.fillColor = colorRed
        redNode.position = position
        
        self.addChild(redNode)
        
        let greenNode = SKShapeNode()
        let greenLine = CGPathCreateMutable()
        greenNode.name = "green"
        CGPathMoveToPoint(greenLine, nil, 42, 62.5)
        CGPathAddLineToPoint(greenLine, nil, 150, 125)
        CGPathAddLineToPoint(greenLine, nil, 150, 0)
        greenNode.path = greenLine
        greenNode.strokeColor = colorGreen
        greenNode.fillColor = colorGreen
        greenNode.position = position
        
        self.addChild(greenNode)
        
        let blueNode = SKShapeNode()
        let blueLine = CGPathCreateMutable()
        blueNode.name = "blue"
        CGPathMoveToPoint(blueLine, nil, 150,0)
        CGPathAddLineToPoint(blueLine, nil, 150, 125)
        CGPathAddLineToPoint(blueLine, nil, 258,62.5)
        blueNode.path = blueLine
        blueNode.strokeColor = colorBlue
        blueNode.fillColor = colorBlue
        blueNode.position = position
        
        self.addChild(blueNode)
        
        let purpleNode = SKShapeNode()
        let purpleLine = CGPathCreateMutable()
        purpleNode.name = "purple"
        CGPathMoveToPoint(purpleLine, nil, 258,62.5)
        CGPathAddLineToPoint(purpleLine, nil, 150, 125)
        CGPathAddLineToPoint(purpleLine, nil, 258,187.5)
        purpleNode.path = purpleLine
        purpleNode.strokeColor = colorPurple
        purpleNode.fillColor = colorPurple
        purpleNode.position = position
        
        self.addChild(purpleNode)
        
        let yellowNode = SKShapeNode()
        let yellowLine = CGPathCreateMutable()
        yellowNode.name = "yellow"
        CGPathMoveToPoint(yellowLine, nil, 42, 187.6)
        CGPathAddLineToPoint(yellowLine, nil, 150, 125)
        CGPathAddLineToPoint(yellowLine, nil, 42,62.5)
        yellowNode.path = yellowLine
        yellowNode.strokeColor = colorYellow
        yellowNode.fillColor = colorYellow
        yellowNode.position = position
        
        self.addChild(yellowNode)
        
        let orangeNode = SKShapeNode()
        let orangeLine = CGPathCreateMutable()
        orangeNode.name = "orange"
        CGPathMoveToPoint(orangeLine, nil, 42,187.6)
        CGPathAddLineToPoint(orangeLine, nil, 150, 125)
        CGPathAddLineToPoint(orangeLine, nil, 150,250)
        orangeNode.path = orangeLine
        orangeNode.strokeColor = colorOrange
        orangeNode.fillColor = colorOrange
        orangeNode.position = position
        
        self.addChild(orangeNode)
        
        var run1 = SKAction.runBlock({
            self.instructions.runAction(SKAction.fadeInWithDuration(0.5))
            self.instructions2.runAction(SKAction.fadeInWithDuration(0.5))
        })
        var run2 = SKAction.runBlock({
            self.instructions.runAction(SKAction.fadeOutWithDuration(0.5))
            self.instructions2.runAction(SKAction.fadeOutWithDuration(0.5))
        })
        var wait1 = SKAction.waitForDuration(0.5)
        var run3 = SKAction.runBlock({
            self.timerLabel.runAction(SKAction.fadeInWithDuration(0.5))
        })
        var wait2 = SKAction.waitForDuration(0.3)
        var run4 = SKAction.runBlock({
            self.colorLabel.runAction(SKAction.fadeInWithDuration(0.3))
            self.startGame()
            self.updateHundreths()
        })
        
        self.runAction(SKAction.sequence([run1,wait1,run2,wait2,wait2,run3,wait2,run4]))
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            
            //determine touched node
            let location = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(location)
            
            if (touchedNode.name == randomColor) {
                score += 1
                updateColorLabel()
            } else if (touchedNode.name == "background") {
                //do nothing
            } else if gamebool == false {
                //do nothing
            } else {
                endGame()
            }
        }
    }
    
    func startGame() {
        gamebool = true
        var timerWait = SKAction.waitForDuration(0.1)
        var timerRun = SKAction.runBlock({
            self.time -= 0.1
            self.timestring = NSString(format: "%.1f", self.time)
            self.timerLabel.text = "\(self.timestring)\(self.hundrethsString) seconds"
            if (self.time <= 0) {
                self.endGame()
            }
        })
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([timerWait,timerRun])))
    }
    
    func updateHundreths() {
        var timerWait = SKAction.waitForDuration(0.01)
        var timerRun = SKAction.runBlock({
            self.hundreths += 1
            self.hundrethsString = String(self.hundreths)
            
            if (self.hundreths == 9) {
                self.hundreths = 0
            }
            
            self.timerLabel.text = "\(self.timestring)\(self.hundrethsString) seconds left"
        })
        self.runAction(SKAction.repeatActionForever(SKAction.sequence([timerWait,timerRun])))
    }
    
    func updateColorLabel() {
        var randomNum = Int(arc4random_uniform(6))
        var randomNum2 = Int(arc4random_uniform(5))
        
        // makes sure that the same color does not appear consecutively
        if randomColor == colorArray[randomNum] {
            var modifiedArray = colorArray
            modifiedArray.removeAtIndex(randomNum)
            randomNum = Int(arc4random_uniform(5))
            randomColor = modifiedArray[randomNum]
        } else {
            randomColor = colorArray[randomNum]
        }
        
        // update color label text
        colorLabel.text = randomColor
        colorLabel.fontColor = labelColorArray[randomNum2]
    }
    
    func endGame() {
        let transition = SKTransition.revealWithDirection(SKTransitionDirection.Right, duration: 0.2)
        let scene = endScene()
        scene.score = score
        scene.time = Float(10) - self.time
        scene.size = self.size
        scene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene?.view?.presentScene(scene, transition: transition)
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        
        
    }
}
