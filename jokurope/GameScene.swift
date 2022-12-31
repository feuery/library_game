//
//  GameScene.swift
//  jokurope
//
//  Created by Ilpo Lehtinen on 24.12.2022.
//

import SpriteKit
import GameplayKit
import GameController

// copypastea https://gist.github.com/swillits/df648e87016772c7f7e5dbed2b345066
let leftArrow                 : UInt16 = 0x7B
let rightArrow                : UInt16 = 0x7C
let downArrow                 : UInt16 = 0x7D
let upArrow                   : UInt16 = 0x7E


func atlas_to_textures(_ src: SKTextureAtlas) -> [SKTexture]{
    return src.textureNames.map {name in src.textureNamed(name)}
}

class GameScene: SKScene {

    let atlases = ["down": SKTextureAtlas(named: "dude_down"),
                   "up": SKTextureAtlas(named: "dude_up"),
                   "left":  SKTextureAtlas(named: "dude_left"),
                   "right": SKTextureAtlas(named: "dude_right")]

    var textures: Dictionary<String, [SKTexture]> {
        // return atlases.mapValues { text_atlas in atlas_to_textures(text_atlas) }
        return ["down": atlas_to_textures(atlases["down"]!),
                "up": atlas_to_textures(atlases["up"]!),
                "left": atlas_to_textures(atlases["left"]!),
                "right": atlas_to_textures(atlases["right"]!)]
    }

    var animations: Dictionary<String, SKAction> {
        return textures.mapValues{ anims in SKAction.animate(with: anims, timePerFrame: 0.5)}
    }
        
    override func didMove(to view: SKView)  {
        
        let animation = SKAction.animate(with: textures["right"]!, timePerFrame: 0.1)
        //animations["right"]
        
        let dude = SKSpriteNode(texture: textures["right"]!.first)
        
        dude.position = CGPoint(x: 100, y: 100)
        dude.run(SKAction.repeatForever(animation), withKey: "down_anim")
        self.addChild(dude)
    }

    func update(currentTime: TimeInterval) {
        guard let direction = (leftPressed ? "left":
                                 rightPressed ? "right":
                                 upPressed ? "up":
                                 downPressed ? "down": nil) else { return}
        
        
    }
    
    var leftPressed: Bool = false
    var rightPressed: Bool = false
    var upPressed: Bool = false
    var downPressed: Bool = false

    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case leftArrow:
            leftPressed = true
        case rightArrow:
            rightPressed = true
        case upArrow:
            upPressed = true
        case downArrow:
            downPressed = true
        default:
            break
        }
    }

    override func keyUp(with event: NSEvent) {
        switch event.keyCode {
        case leftArrow:
            leftPressed = false
        case rightArrow:
            rightPressed = false
        case upArrow:
            upPressed = false
        case downArrow:
            downPressed = false
        default:
            break
        }
    }
}
