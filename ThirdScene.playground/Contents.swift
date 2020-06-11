//: A SpriteKit based Playground

import Foundation
import PlaygroundSupport
import SpriteKit
import UIKit

// Conditions
var salto = false

// BitMasks
let characterCategory:UInt32 = 0x1 << 0
let oscarCategory:UInt32 = 0x1 << 1

class GameScene: SKScene {
//    ANIMATION
    var texturesJumpBack:[SKTexture] = [SKTexture(imageNamed: "images/RdiCapriojump.png"),SKTexture(imageNamed: "images/diCaprio0.png")]
    var texturesJump:[SKTexture] = [SKTexture(imageNamed: "images/diCapriojump.png"),SKTexture(imageNamed: "images/diCaprio0.png")]
    var texturesRunBack:[SKTexture] = [SKTexture(imageNamed: "images/RdiCaprio1.png"),SKTexture(imageNamed: "images/RdiCaprio2.png"),SKTexture(imageNamed: "images/RdiCaprio3.png"),SKTexture(imageNamed: "images/diCaprio0.png")]
    var texturesRun:[SKTexture] = [SKTexture(imageNamed: "images/diCaprio1.png"),SKTexture(imageNamed: "images/diCaprio2.png"),SKTexture(imageNamed: "images/diCaprio3.png"),SKTexture(imageNamed: "images/diCaprio0.png")]
    var textureOscar:[SKTexture] = [SKTexture(imageNamed: "images/pop1.png"),SKTexture(imageNamed: "images/pop2.png"),SKTexture(imageNamed: "images/empty.png")]
    
//    IMAGES
    
    let background = SKSpriteNode(imageNamed: "images/sfondoDiCaprio.png")
    let floor = SKSpriteNode(imageNamed: "images/floor.png")
    let character = SKSpriteNode(imageNamed: "images/diCaprio0.png")
    let oscar = SKSpriteNode(imageNamed: "images/oscar1.png")
    let obstacle = SKSpriteNode (imageNamed: "images/actor1.png")
    let obstacle2 = SKSpriteNode (imageNamed: "images/actor2.png")
    let instructions = SKLabelNode(text: "Click on the low left or right part of the screen to move in that direction\nClick on the high left or right part of the screen to jump in that direction\nClick anywhere to close the instructions ")
    var printedInstructions = false
    
    let finalLabel = SKLabelNode(text: "Oh no! You have lost the Oscar!")
    
//    Background Music
    let backgroundMusic = SKAudioNode(fileNamed: "sounds/soundTrack.caf")
 
    
    override func didMove(to view: SKView) {
        
        finalLabel.position = CGPoint(x: frame.midX, y:frame.midY+230)
        finalLabel.fontColor = UIColor.white
        finalLabel.fontName = "Menlo-Bold"
        finalLabel.fontSize = 50
        
        instructions.position = CGPoint(x: frame.midX, y:frame.midY+230)
        instructions.fontColor = UIColor.white
        instructions.fontName = "Menlo-Bold"
        instructions.fontSize = 21
        instructions.numberOfLines = 3
        
        floor.size = CGSize(width: frame.size.width, height: frame.size.height/5)
        floor.anchorPoint = CGPoint(x:0.5, y:2.5)
        floor.physicsBody = SKPhysicsBody (rectangleOf: CGSize(width: floor.frame.width*2, height: floor.frame.height/7), center: floor.frame.origin)
        floor.physicsBody?.affectedByGravity = false
        floor.physicsBody?.isDynamic = false
        
        
        character.size = CGSize(width:100.0, height: 120.0)
        character.anchorPoint = CGPoint(x:4.8, y:2.7)
        character.physicsBody = SKPhysicsBody (circleOfRadius:60.0, center: CGPoint(x: character.frame.minX, y: character.frame.minY))

        character.physicsBody?.affectedByGravity = true
        character.physicsBody?.allowsRotation = false
        
       oscar.size = CGSize(width:140.0, height: 100.0)
        oscar.anchorPoint = CGPoint(x:-2.5, y:3.0)
        
        obstacle.size = CGSize(width: 130, height: 170.0)
        obstacle.anchorPoint = CGPoint (x:2.0, y:1.9)
        obstacle.physicsBody = SKPhysicsBody (circleOfRadius:30.0, center: CGPoint(x: obstacle.frame.minX + 20, y: obstacle.frame.minY + 40))
        obstacle.physicsBody?.affectedByGravity = false
        obstacle.physicsBody?.isDynamic = false
        
        obstacle2.size = CGSize(width: 100, height: 140.0)
        obstacle2.anchorPoint = CGPoint (x:-0.5, y:2.2)
        obstacle2.physicsBody = SKPhysicsBody (circleOfRadius:30.0, center: CGPoint(x: obstacle2.frame.minX, y: obstacle.frame.minY + 40))
        obstacle2.physicsBody?.affectedByGravity = false
        obstacle2.physicsBody?.isDynamic = false
        
//        Detection of collisions by bitmask
        character.physicsBody?.categoryBitMask = characterCategory
        floor.physicsBody?.collisionBitMask = characterCategory
        character.physicsBody?.collisionBitMask = characterCategory
        obstacle.physicsBody?.categoryBitMask = characterCategory
 
        
        
        
        
//      Insert a background music
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        

        background.size = CGSize(width: frame.size.width, height: frame.size.height)
        background.position = CGPoint(x: frame.midX, y: frame.midY + 130)


        addChild(background)
        addChild(floor)
        addChild(character)
        addChild(oscar)
        addChild(obstacle)
        addChild(obstacle2)
        addChild(instructions)
        
    }
    
    
   

    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let characterAnimation = SKAction.animate(with: texturesJump, timePerFrame: 1.4)
        let characterAnimation2 = SKAction.animate(with: texturesRun, timePerFrame: 0.3)
        let characterAnimation3 = SKAction.animate(with: texturesRunBack, timePerFrame: 0.3)
        let characterAnimation4 = SKAction.animate(with: texturesJumpBack, timePerFrame: 1.4)
        let oscarAnimation = SKAction.animate(with: textureOscar, timePerFrame: 0.4)
        
        if printedInstructions == false {
            instructions.removeFromParent()
            printedInstructions = true
        }
        
            if let touch = touches.first {
                let position = touch.location(in: view)
                
                //Divide the screen in 4 parts
                
                    if position.y > view!.frame.midY {
                        if position.x < view!.frame.midX {
                                let actionMove = SKAction.moveBy(x: -40, y: 0, duration: 0.7)
                            
                                    
                                character.run(characterAnimation3)

                                character.run(actionMove)
                            }

                        else if position.x > view!.frame.midX {
                                let actionMove = SKAction.moveBy(x: 40, y: 0, duration: 0.7)
                            
                                character.run(characterAnimation2)
                            
                                character.run(actionMove, completion: {
                                    if(abs(self.oscar.frame.maxX-self.character.frame.maxX)<90)  {
                                        self.oscar.run(oscarAnimation) {
                                            self.oscar.removeFromParent()
                                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                               
                                                self.backgroundMusic.removeFromParent()
                                                self.addChild(self.finalLabel)
                                                self.run(SKAction.playSoundFileNamed("sounds/loseSound.caf", waitForCompletion: true))
                                            })
                                        }
                                    }
                                })
                        }
                        

                    } else if position.y < view!.frame.midY {
                        
                        if !salto {
                            
                            salto = true
                                                    
                                if position.x < view!.frame.midX {
                                    run(SKAction.playSoundFileNamed("sounds/smb_jump-small.caf", waitForCompletion: true))
                                    let actionMove = SKAction.moveBy(x: -100, y: 600, duration: 0.7)
                                    let actionMove2 = SKAction.moveBy(x: -100, y:0, duration: 0.7)
                                    let sequenza = SKAction.sequence([actionMove, actionMove2])
                                                    
                                    character.run(characterAnimation4)

                                    character.run(sequenza, completion: {
                                        salto=false
                 
                                    })
                                    
                                } else if position.x > view!.frame.midX {
                                    run(SKAction.playSoundFileNamed("sounds/smb_jump-small.caf", waitForCompletion: true))
                                    let actionMove1 = SKAction.moveBy(x: 100, y: 600, duration: 0.7)
                                    let actionMove2 = SKAction.moveBy(x: 100, y:0, duration: 0.7)
                                    let sequenza = SKAction.sequence([actionMove1, actionMove2])
                                                
                                    character.run(characterAnimation)
                                                        
                                    character.run(sequenza, completion: {
                                        salto=false
                                        if(abs(self.oscar.frame.maxX-self.character.frame.maxX)<90)  {
                                            self.oscar.run(oscarAnimation) {
                                                self.oscar.removeFromParent()
                                                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                          
                                                    self.backgroundMusic.removeFromParent()
                                                    self.addChild(self.finalLabel)
                                                    self.run(SKAction.playSoundFileNamed("sounds/loseSound.caf", waitForCompletion: true))
                                                    
                                                })
                                        }
                                                                
                                    }
                                })
                            }
                        }
                    }
       }
    }
}



// Load the SKScene from 'GameScene.sks'
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 480))
if let scene = GameScene(fileNamed: "GameScene") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFill
    // Present the scene
    sceneView.presentScene(scene)

    }


PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
