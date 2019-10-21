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
    var fish = SKSpriteNode()
  
    var gameState: GameState = .readyTofish
    
    var score: Int = 0
    var lives: Int = 3
    // Labels
    var scoreLabel: SKLabelNode?
    
    var isMovingLeft:Bool = true
    var isMovingRight:Bool = true
    
    

    
    
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
      
        
        spawnFish()
        
    }
    
    
    func dropHook(){
        
        let hookDepth = CGFloat(3600.0)
        let hookSpeed = Double(7)
        
        
        
        let lineAction = SKAction.resize(toHeight: hookDepth , duration: hookSpeed)
        let hookAction = SKAction.moveTo(y: -hookDepth, duration: hookSpeed)
        
        hook?.run(hookAction)
        line?.run(lineAction)
        
//        let timer = Timer()
//
//        Timer(timeInterval: 1000.0, target: self, selector: #selector(changeGameState), userInfo: nil, repeats: true)
        
        castAndReel(depth: hookDepth, speed: hookSpeed, completion: {
            self.gameState = .pullinghookback
            
        })
    
        
        
    }
    
  
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchLocation = touches.first?.location(in: self)
        playerAction(at: touchLocation!)
        
        
        
    }
    
    func playerAction(at location: CGPoint){
        
        switch gameState{
            
        case .readyTofish: startFishing(location:location)
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
    
    
    func castAndReel(depth: CGFloat, speed: Double, completion: @escaping () -> ()) {
    
        let lineAction = SKAction.resize(toHeight: depth, duration: speed)
        lineAction.timingMode = SKActionTimingMode.easeOut
        
        let hookAction = SKAction.moveTo(y: -depth, duration: speed)
        hookAction.timingMode = SKActionTimingMode.easeOut
        
        hook?.run(hookAction)
        line?.run(lineAction, completion: completion)
       
    }
        
    func pullHook() {
        if gameState == .pullinghookback {
//            gameState = .pullinghookback
            
            let targetDepth = CGFloat(100.0)
            let currentDepth = line!.size.height
            let hookVelocity = Double(currentDepth / 500)
            
            castAndReel(depth: targetDepth, speed: hookVelocity, completion: {
                self.camera?.removeAllActions()
                self.camera!.position = CGPoint(x: 0.0, y: self.boat!.position.y)
                
            })
        }
    }
    
    func spawnFish(){
        
        fish = childNode(withName: "fish") as! SKSpriteNode
     
       
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
       
        
        
        let maxCameraDepth:CGFloat = -1545.0
        // Update Camera
        let hookPosition = convert((hook?.position)!, from: line!)
        
        
        
       
        if hookPosition.y < boat!.position.y &&
            hookPosition.y > maxCameraDepth {
            camera?.position = CGPoint(x: 0.0, y: hookPosition.y)
        }
        
        
        
        
     
        
                if (self.isMovingRight == true) {
                 fish.position.x = self.fish.position.x + 10;
                    fish.xScale = 0.5
                    
                    if (fish.position.x >= 300) {
                        // bounce off left wall
                        self.isMovingRight = false;
                        self.isMovingLeft = true;
        
                    }
                }
        
                if (self.isMovingLeft == true) {
                 fish.xScale = -0.5
                  fish.position.x = self.fish.position.x - 10;
        
                    if (fish.position.x <= -250) {
                        // bounce off right wall
                        self.isMovingLeft = false
                        self.isMovingRight = true
                    }
                }
        
            
            
        
    }
    
   
}
