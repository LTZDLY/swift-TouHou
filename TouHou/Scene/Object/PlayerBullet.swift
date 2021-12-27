//
//  PlayerBullet.swift
//  TouHou
//
//  Created by lin on 2021/12/25.
//

import SpriteKit
class PlayerBullet: SKSpriteNode {
    public var dmg: Float?
}

class PCommonBullet: PlayerBullet{
    
    convenience init(x: CGFloat, y: CGFloat, p:SKNode) {
        self.init(texture: cplayerbullet)
        self.dmg = 1.0
        self.setScale(2.5)
        self.alpha = 0.5
        self.position = CGPoint(x:x, y:y)
        self.zRotation = CGFloat(.pi / 2.0)
        self.zPosition = 20
        
        self.run(SKAction.sequence([
            SKAction.moveBy(x: 0, y: 1500, duration: 0.3),
            SKAction.removeFromParent()
        ]))
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        self.physicsBody?.allowsRotation = false  //禁止旋转
        self.physicsBody?.categoryBitMask = playerbulletCategory //设置物理体标示
        self.physicsBody?.collisionBitMask = 0x0
        self.physicsBody?.contactTestBitMask = enemyCategory | sceneCategory  //设置可以碰撞检测的物理体
        
        p.addChild(self)
    }
}
