//
//  GameScene.swift
//  PileUp
//
//  Created by nagata on 4/30/15.
//  Copyright (c) 2015 nagata. All rights reserved.
//

import Foundation
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var bowl: SKSpriteNode?
    var timer: NSTimer?
    var lowestShape: SKShapeNode?
    
    /* score */
    var score = 0
    var scoreLabel: SKLabelNode?
    
    override func didMoveToView(view: SKView) {
        /* 重力を追加 */
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        self.physicsWorld.contactDelegate = self
        
        /* 背景 */
        let backgroud = SKSpriteNode(imageNamed: "background")
        backgroud.position = CGPointMake(self.size.width*0.5, self.size.height*0.5)
        backgroud.size = self.size
        self.addChild(backgroud)
        
        /* 落下用ノード */
        let lowestShape = SKShapeNode(rectOfSize: CGSize(width: self.size.width*3, height: 10))
        lowestShape.position = CGPoint(x: self.size.width*0.5, y: -10)
        let physicsBody = SKPhysicsBody(rectangleOfSize: lowestShape.frame.size)
        physicsBody.dynamic = false
        physicsBody.contactTestBitMask = 0x1 << 1
        lowestShape.physicsBody = physicsBody
        
        self.addChild(lowestShape)
        self.lowestShape = lowestShape

        /* 受け皿 */
        let bowlTexture = SKTexture(imageNamed: "bowl")
        let bowl = SKSpriteNode(texture: bowlTexture)
        bowl.position = CGPointMake(self.size.width*0.5, 100)
        bowl.size = CGSize(width: bowlTexture.size().width*0.4, height: bowlTexture.size().height*0.4)
        bowl.physicsBody = SKPhysicsBody(texture: bowlTexture, size: bowl.size)
        bowl.physicsBody?.dynamic = false
        self.bowl = bowl
        self.addChild(bowl)
        
        /* score */
        var scoreLabel = SKLabelNode(fontNamed: "Copperplate")
        scoreLabel.position = CGPoint(x: self.size.width*0.15, y: self.size.height*0.90)
        scoreLabel.text = "0"
        scoreLabel.fontSize = 32
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
        scoreLabel.fontColor = UIColor.whiteColor()
        self.addChild(scoreLabel)
        self.scoreLabel = scoreLabel
        
        self.fallSpecialty()
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "fallSpecialty", userInfo: nil, repeats: true)
    }
    
    /* ものを落とす */
    func fallSpecialty() {
        let texture = SKTexture(imageNamed: "0")
        let sprite = SKSpriteNode(texture: texture)
        sprite.position = CGPointMake(self.size.width*0.5, self.size.height*0.68)
        sprite.size = CGSize(width: texture.size().width*0.4, height: texture.size().height*0.4)
        
        sprite.physicsBody?.contactTestBitMask = 0x1 << 1
        
        /* 重力を追加 */
        sprite.physicsBody = SKPhysicsBody(texture: texture, size: sprite.size)
        
        self.addChild(sprite)
        
        self.score += 1
        self.scoreLabel?.text = "\(self.score)"
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            let location = touch.locationInNode(self)
            let action = SKAction.moveTo(CGPoint(x: location.x, y: 100), duration: 0.2)
            self.bowl?.runAction(action)
        }
        
        if self.paused == true {
            //Gameover
            NSLog("retry")
        }
    }
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            let location = touch.locationInNode(self)
            let action = SKAction.moveTo(CGPoint(x: location.x, y: 100), duration: 0.2)
            self.bowl?.runAction(action)
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        if contact.bodyA.node == self.lowestShape || contact.bodyB.node == self.lowestShape {
            let sprite = SKSpriteNode(imageNamed: "gameover")
            sprite.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.5)
            self.addChild(sprite)
            self.paused = true
            self.timer?.invalidate()
        }
    }
}
