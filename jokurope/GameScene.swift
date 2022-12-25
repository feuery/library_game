//
//  GameScene.swift
//  jokurope
//
//  Created by Ilpo Lehtinen on 24.12.2022.
//

import SpriteKit
import GameplayKit

func atlas_to_textures(_ src: SKTextureAtlas) -> [SKTexture]{
    return src.textureNames.map {name in src.textureNamed(name)}
}

class GameScene: SKScene {

    let atlases = ["down": SKTextureAtlas(named: "dude_down"),
                   "up": SKTextureAtlas(named: "dude_up"),
                   "left":  SKTextureAtlas(named: "dude_left"),
                   "right": SKTextureAtlas(named: "dude_right")]

    var textures: Dictionary<String, [SKTexture]> {
        return ["down": atlas_to_textures(atlases["down"]!),
                "up": atlas_to_textures(atlases["up"]!),
                "left": atlas_to_textures(atlases["left"]!),
                "right": atlas_to_textures(atlases["right"]!)]
    }
                            
    override func didMove(to view: SKView)  {
        
        let animation = SKAction.animate(with: textures["right"]!, timePerFrame: 0.1)
        
        let dude = SKSpriteNode(texture: textures["right"]!.first)
        
        dude.position = CGPoint(x: 100, y: 100)
        dude.run(SKAction.repeatForever(animation), withKey: "down_anim")
        self.addChild(dude)
    }    
}
