//
//  GameScene.swift
//  jokurope
//
//  Created by Ilpo Lehtinen on 24.12.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var down_atlas: SKTextureAtlas {
        return SKTextureAtlas(named: "dude_down")
    }

    private var up_atlas: SKTextureAtlas {
        return SKTextureAtlas(named: "dude_up")
    }
    
    private var left_atlas: SKTextureAtlas {
        return SKTextureAtlas(named: "dude_left")
    }
    
    private var right_atlas: SKTextureAtlas {
        return SKTextureAtlas(named: "dude_right")
    }
    
    func atlas_to_textures(_ src: SKTextureAtlas) -> [SKTexture]{
        return src.textureNames.map {name in src.textureNamed(name)}
    }
    
    private var down_textures: [SKTexture] {
        return atlas_to_textures(down_atlas)
    }
    
    private var up_textures: [SKTexture] {
        return atlas_to_textures(up_atlas)
    }
    
    private var left_textures: [SKTexture] {
        return atlas_to_textures(left_atlas)
    }
    
    private var right_textures: [SKTexture] {
        return atlas_to_textures(right_atlas)
    }
    
    override func didMove(to view: SKView)  {
        
        let animation = SKAction.animate(with: right_textures, timePerFrame: 0.1)
        
        let dude = SKSpriteNode(texture: right_textures.first)
        
        dude.position = CGPoint(x: 100, y: 100)
        dude.run(SKAction.repeatForever(animation), withKey: "down_anim")
        self.addChild(dude)
    }
    
}
