//
//  GameScene.swift
//  RidiculousFishing
//
//  Created by MacBook Pro on 2019-10-18.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import SpriteKit
import GameplayKit


enum GameState: Int {
    case readyTofish
    case fishing
    case pullinghookback
    case collectingFish
    case gameOver
}

class GameScene: SKScene {
    
    
    
    var fishCam: SKCameraNode?
    var boat: SKSpriteNode?
    var fisherman: SKSpriteNode?
    var fishingpole: SKSpriteNode?
    var hook: SKSpriteNode?
    var fishingline: SKSpriteNode?
    var pole:SKSpriteNode?
    var line: SKSpriteNode?
  
    var gameState: GameState = .readyTofish
    
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
    
    
    func dropHook(){
        
        let hookDepth = CGFloat(3600.0)
        let hookSpeed = Double(7)
        
        let lineAction = SKAction.resize(toHeight: hookDepth , duration: hookSpeed)
        let hookAction = SKAction.moveTo(y: -hookDepth, duration: hookSpeed)
        
        hook?.run(hookAction)
        line?.run(lineAction)
        
        
    
    
        
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchLocation = touches.first?.location(in: self)
        playerAction(at: touchLocation!)
        
        
        
    }
    
    func playerAction(at location: CGPoint){
        
        switch gameState{
            
        case .readyTofish: startFishing(location:location)
        case .fishing:break
        case .pullinghookback: pullHook()
        case .gameOver: break

        default: break

        }
        
    }
    
    func startFishing(location:CGPoint){
        
        for node in nodes(at: location){
            if let buttonName = node.name{
                if buttonName == "fisherman"{
                    
                    dropHook()
                    return
                }
            }
        
        
        }
    }
    
    func pullHook(){
        
        self.camera?.removeAllActions()
        self.camera!.position = CGPoint(x:0.0, y: self.boat!.position.y)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
       
        
        
        let maxCameraDepth:CGFloat = -1545.0
        // Update Camera
        let hookPosition = convert((hook?.position)!, from: line!)
       
        if hookPosition.y < boat!.position.y &&
            hookPosition.y > maxCameraDepth {
            camera?.position = CGPoint(x: 0.0, y: hookPosition.y)
        }
        
    }
   
}
