//: A SpriteKit based Playground

import PlaygroundSupport
import SpriteKit
import UIKit
import Foundation

extension String {
    var characterArray: [Character]{
        var characterArray = [Character]()
        for character in self {
            characterArray.append(character)
        }
        return characterArray
    }
}



class GameScene: SKScene {
    
    var available = true
    var touchCounter = 0
    var characterIndex = 0
    var dialogue = SKLabelNode(fontNamed: "Courier")
    let diCaprio = SKSpriteNode(imageNamed: "images/diCaprioFace.png")
    let textBox = SKSpriteNode(imageNamed: "images/textBox.png")
    
    let backgroundMusic = SKAudioNode(fileNamed: "sounds/oscarTheme.caf")
    
    let textArray = ["Today i want to tell you about my last film: \n The Wolf of Wall Street ", "The film was directed by Martin Scorzese. It's set in New York, in the '80s. ", "I play the part of Jordan Belfort, an ambicious broker that makes a lot of money. ", "I'm candidate at the oscars for best actor, and I'm going to premiere. ", "Follow me \n in the second playground! "]
    var count = 0
    
    override func didMove(to view: SKView) {
        
        backgroundMusic.autoplayLooped = true
        addChild(backgroundMusic)
        
        textBox.size=CGSize(width: frame.width-90, height: frame.height-50)
        textBox.position=CGPoint(x:0.0, y:frame.midY-65.0)
        
        dialogue.text = "Welcome to everybody, I’m Leonardo di Caprio. "
        dialogue.fontColor = UIColor.black
        dialogue.position = CGPoint(x: 0.0, y: frame.midY-320.0)
        dialogue.numberOfLines = 3
        dialogue.preferredMaxLayoutWidth = frame.width-450
        
        diCaprio.position=CGPoint(x: frame.midX, y:frame.midY+60)
        diCaprio.size = CGSize(width: 360, height: 360)
        
        addChild(textBox)
        addChild(diCaprio)
        addChild(dialogue)
        fireTyping(x: dialogue.text!)
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if available {
            if count<textArray.count {
                dialogue.text = textArray[count]
                count+=1
                fireTyping(x: dialogue.text!)
            }
        }
    }

    

    func fireTyping(x: String)
    {
        available = false
        let characters = x.characterArray
        dialogue.text = ""
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
            
            self.dialogue.text?.append(characters[self.characterIndex])
            self.characterIndex += 1
            if self.characterIndex == characters.count {
                self.characterIndex=0
                timer.invalidate()
                self.available = true
                
            }
        }
        
    }
    
}

// Load the SKScene from 'GameScene.sks'
let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 640, height: 480))
if let scene = GameScene(fileNamed: "GameScene") {
    // Set the scale mode to scale to fit the window
    scene.scaleMode = .aspectFill
    scene.backgroundColor = UIColor.white
    
    // Present the scene
    sceneView.presentScene(scene)
}

PlaygroundSupport.PlaygroundPage.current.liveView = sceneView
