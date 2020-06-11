//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit



class GameScene: SKScene {
    
    var player : SKSpriteNode!
    var bear : SKSpriteNode!
    var healthBar1 : SKSpriteNode!
    var healthBar2 : SKSpriteNode!
    var oscar : SKSpriteNode!
    var instruction : SKLabelNode!
    
    var widthValue:CGFloat = 100
    
    var loseEvent : SKAction!
    var winEvent : SKAction!
    
    let backgroundMusic = SKAudioNode(fileNamed: "soundTrack.caf")
    let winMusic = SKAudioNode(fileNamed: "winSound.caf")
    var instructionsPrinted = false


    override func didMove(to view: SKView) {
              
        
        oscar = childNode(withName: "oscar") as? SKSpriteNode
        healthBar1 = childNode(withName: "healthBar") as? SKSpriteNode
        healthBar2 = childNode(withName: "healthBar2") as? SKSpriteNode
        player = childNode(withName: "glass") as? SKSpriteNode
        bear = childNode(withName: "bear") as? SKSpriteNode
        instruction = (childNode(withName: "instruction") as! SKLabelNode)
        
        addChild(backgroundMusic)

    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if instructionsPrinted == false {
            self.childNode(withName: "instruction")?.removeFromParent()
            instructionsPrinted = true
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        
        let touchLocation = touch.location(in: self)
    

        if healthBar2.size.width > 0 {
            
            if bear.frame.contains(touchLocation) {
                
                widthValue -= 20
                
                let actionMove = SKAction.resize(toWidth: widthValue, duration: 0.5)
                
                healthBar2.run(actionMove, completion: {
                    
                    if self.healthBar2.size.width == 0 {
                        
                        let winLabel = SKLabelNode(text: "You win the Oscar!")
                        winLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 150)
                        winLabel.alpha = 0
                        winLabel.fontSize = 64
                        winLabel.fontName = "Helvetica Neue Bold"
                        self.oscar.alpha = 0
                        
                        let oscarMove = SKAction.fadeIn(withDuration: 2.0)
                        
                        
                        self.removeAllChildren()
                        
                        self.backgroundColor = UIColor.systemGreen
                        
                        self.addChild(self.oscar)
                        self.addChild(winLabel)
                        winLabel.run(oscarMove)
                        self.oscar.run(oscarMove)
                        self.addChild(self.winMusic)
                        
                        
                    }
                    
                })
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

