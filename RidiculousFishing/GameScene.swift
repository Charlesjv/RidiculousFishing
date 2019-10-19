//
//  GameScene.swift
//  RidiculousFishing
//
//  Created by MacBook Pro on 2019-10-18.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    
    
    var fishCam: SKCameraNode?
    var boat: SKSpriteNode?
    var fisherman: SKSpriteNode?
    var fishingpole: SKSpriteNode?
    var hook: SKSpriteNode?
    var fishingline: SKSpriteNode?
    var pole:SKSpriteNode?
    var line: SKSpriteNode?
  

    
    var score: Int = 0
    var lives: Int = 3
    // Labels
    var scoreLabel: SKLabelNode?
    
    
    override func didMove(to view: SKView) {
        sceneSetup()
    }
    
    func sceneSetup(){
        
        fishCam = childNode(withName: "fishCam") as? SKCameraNode
        camera = fishCam
        
        boat = childNode(withName: "boat") as? SKSpriteNode
        fisherman = boat?.childNode(withName: "fisherman") as? SKSpriteNode
        pole = boat?.childNode(withName: "pole") as? SKSpriteNode
        line = childNode(withName: "line") as? SKSpriteNode
        hook = line?.childNode(withName: "hook") as? SKSpriteNode
        
        
    }
   
}
