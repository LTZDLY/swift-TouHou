//
//  Player.swift
//  TouHou
//
//  Created by lin on 2021/12/25.
//

import SpriteKit

class player: SKSpriteNode {
    var miss = 0
    convenience init(x: CGFloat, y: CGFloat, p:SKNode) {
        self.init(imageNamed:"reimu_01")
        self.setScale(2.5)
        self.position = CGPoint(x:x, y:y)
        self.birdStartFly()
        self.zPosition = 50
        
        // let s = SKShapeNode.init(circleOfRadius: 40)
        // s.fillColor = SKColor.black
        // p.addChild(s)
        // s.run(SKAction.move(to: self.position, duration: 0))
        self.physicsBody = SKPhysicsBody(circleOfRadius:8)
        self.physicsBody?.allowsRotation = false  //禁止旋转
        self.physicsBody?.categoryBitMask = playerCategory //设置物理体标示
        self.physicsBody?.collisionBitMask = 0x0
        self.physicsBody?.contactTestBitMask = enemyCategory | enemybulletCategory
        
        self.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.run {
                self.run(self.shot(parent: p, s: self))
            },
            SKAction.wait(forDuration: (3.0/60.0))
        ])))
        
        p.addChild(self)
    }
    
    func birdStartFly()  {
        let birdTexture1 = SKTexture(imageNamed: "reimu_01")
        birdTexture1.filteringMode = .nearest
        let birdTexture2 = SKTexture(imageNamed: "reimu_02")
        birdTexture2.filteringMode = .nearest
        let birdTexture3 = SKTexture(imageNamed: "reimu_03")
        birdTexture3.filteringMode = .nearest
        let birdTexture4 = SKTexture(imageNamed: "reimu_04")
        birdTexture4.filteringMode = .nearest
        let birdTexture5 = SKTexture(imageNamed: "reimu_05")
        birdTexture5.filteringMode = .nearest
        let birdTexture6 = SKTexture(imageNamed: "reimu_06")
        birdTexture6.filteringMode = .nearest
        let birdTexture7 = SKTexture(imageNamed: "reimu_07")
        birdTexture7.filteringMode = .nearest
        let birdTexture8 = SKTexture(imageNamed: "reimu_08")
        birdTexture8.filteringMode = .nearest
        let anim = SKAction.animate(with: [birdTexture1,birdTexture2,birdTexture3,birdTexture4,birdTexture5,birdTexture6,birdTexture7,birdTexture8], timePerFrame: 0.1)
        self.run(SKAction.repeatForever(anim))
    }
    
    func touchDown(atPoint pos : CGPoint){
        self.run(SKAction.move(to: pos, duration: 0.2))
    }
    func shot(parent: SKNode, s: SKNode) -> SKAction{
        return SKAction.run {
            for i in 0...1 {
                let _ = PCommonBullet(x: s.position.x - 20 + CGFloat(40 * i), y: s.position.y + 40, p: parent)
            }
        }
    }
    func gethit(){
        print("biu")
        self.run(se_pldead00)
        self.miss += 1
        var a = 1.0
        self.run(
            SKAction.sequence([
                SKAction.run {
                    self.physicsBody?.categoryBitMask = 0x0 //设置物理体标示
                    print("start")
                },
                SKAction.run {
                    self.run(
                        SKAction.repeat(SKAction.sequence([
                            SKAction.run {
                                if a == 1.0{
                                    a = 0.2
                                }
                                else {
                                    a = 1.0
                                }
                                self.alpha = a
                                // self.isHidden = !self.isHidden
                            },
                            SKAction.wait(forDuration: 0.05),
                        ]), count: 60)
                    )
                },
                SKAction.wait(forDuration: 3),
                SKAction.run {
                    print("end")
                    self.physicsBody?.categoryBitMask = playerCategory //设置物理体标示
                }
            ])
        )
    }
}
