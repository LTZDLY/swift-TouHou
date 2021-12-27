//
//  Boss.swift
//  TouHou
//
//  Created by lin on 2021/12/25.
//

import SpriteKit

class boss : enemy {
    var life = 1 // 几条命
    var health = [100.0] //每条命多少血
    var spellcard = [SKAction.move(to: CGPoint(x:0, y:0), duration: 4)] // 每条命做什么ACTION
    var status = 0 // 当前第几条命
    var back : SKSpriteNode?//魔法阵
    var hplable : SKLabelNode?//血量显示
    
    override func beack(dmg: Float) {
        if self.status >= life{
            return
        }
        self.health[self.status] -= Double(dmg)
        if self.health[self.status] <= 0{
            self.removeAllChildren()
            self.removeAllActions()
            self.run(SKAction.repeatForever(anim!))
            self.status += 1
            if self.status >= life{
                self.hplable?.removeFromParent()
                self.back?.removeFromParent()
                self.run(se_enep01)
                self.onkill()
                return
            }
            self.run(se_enep00)
            self.run(SKAction.sequence([
                SKAction.run {
                    self.physicsBody?.categoryBitMask = 0x0 //设置物理体标示
                    print("next")
                },
                SKAction.move(to: CGPoint(x:0, y:300), duration: 2),
                SKAction.run {
                    self.run(se_ch02)
                    print("begin")
                    self.physicsBody?.categoryBitMask = enemyCategory //设置物理体标示
                },
                SKAction.wait(forDuration: 2),
                spellcard[self.status]
            ]))
        }
    }
    func dodefaultaction()->SKAction{
        // 绘制魔法阵和血条
        SKAction.sequence([
            SKAction.run {
                self.zPosition = 10
                var po = self.position
                let t = SKSpriteNode(imageNamed: "misc_13")
                t.setScale(2.5)
                t.alpha = 0.8
                t.position = self.position
                t.zPosition = -10
                t.run(SKAction.repeatForever(SKAction.rotate(byAngle: Double.pi, duration: 5)))
                t.run(
                    SKAction.repeatForever(SKAction.sequence([
                        SKAction.run {
                            po = self.position
                            t.run(SKAction.move(to: po, duration: 0))
                        },
                        SKAction.wait(forDuration: (1.0/60.0)),
                    ]))
                )
                self.parent?.addChild(t)
                self.back = t
            },
            SKAction.run{
                var po = self.position
                po.y -= 40
                let t = SKLabelNode()
                t.text = String(format:"HP: %.0f", arguments:[self.health[self.status]])
                t.fontSize = 40                     //大小
                t.fontName = "Chalkduster"          //类型
                t.position = po
                t.fontColor = UIColor.black
                t.zPosition = 200
                t.run(
                    SKAction.repeatForever(SKAction.sequence([
                        SKAction.run {
                            po = self.position
                            po.y -= 40
                            t.text = String(format:"HP: %.0f", arguments:[self.health[self.status]])
                            t.run(SKAction.move(to: po, duration: 0))
                        },
                        SKAction.wait(forDuration: (1.0/60.0)),
                    ]))
                )
                self.parent?.addChild(t)
                self.hplable = t
            }
        ])
    }
}

class bosstest: boss{
    
    convenience init(x: CGFloat, y: CGFloat, p:SKNode, player: player) {
        self.init(imageNamed:"0")
        self.setScale(2.5)
        self.position = CGPoint(x:x, y:y)
        self.anim = enemystrong
        self.run(SKAction.repeatForever(anim!))
        
        self.physicsBody = SKPhysicsBody(circleOfRadius:self.size.width / 2)
        self.physicsBody?.allowsRotation = false  //禁止旋转
        self.physicsBody?.categoryBitMask = enemyCategory //设置物理体标示
        self.physicsBody?.collisionBitMask = sceneCategory
        self.physicsBody?.contactTestBitMask = playerbulletCategory
        p.addChild(self)
        
        self.life = 4
        self.health = [600,700,700,800]
        
        let sk1 = noncard(self: self)
        let sk2 = card1(self: self)
        let sk3 = noncard2(self: self, player: player)
        let sk4 = card2(self: self, player: player)
        self.spellcard = [sk1, sk2, sk3, sk4]
        self.run(SKAction.sequence([
            SKAction.move(to: CGPoint(x: 0, y: 300), duration: 2),
            self.spellcard[0]
        ]))
        self.run(dodefaultaction())
    }
}

class midboss1 : boss {

    convenience init(x: CGFloat, y: CGFloat, p:SKNode, player: player) {
        self.init(texture: enemystrong1)
        self.anim = enemystrong
        self.zPosition = 10
        self.setScale(2.5)
        self.position = CGPoint(x:x, y:y)
        self.run(SKAction.repeatForever(anim!))
        p.addChild(self)
        
        self.physicsBody = SKPhysicsBody(circleOfRadius:self.size.width / 2)
        self.physicsBody?.allowsRotation = false  //禁止旋转
        self.physicsBody?.categoryBitMask = enemyCategory //设置物理体标示
        self.physicsBody?.collisionBitMask = 0x0
        self.physicsBody?.contactTestBitMask = playerbulletCategory
        
        self.life = 1
        self.health = [400]
        
        let sk1 = SKAction.run {
            // 移动
            self.run(SKAction.sequence([
                SKAction.move(by: CGVector(dx: -700, dy: 200), duration: 2),
                SKAction.move(by: CGVector(dx: 100, dy: -100), duration: 1.5),
                SKAction.move(to: CGPoint(x: 0, y: 300), duration: 2),
                SKAction.repeatForever(SKAction.moveBy(x: drand48()*200-100, y: drand48()*200-100, duration: 3))
            ]))
            
            // 发弹
            self.run(SKAction.sequence([
                SKAction.wait(forDuration: 5),
                SKAction.run {
                    self.run(SKAction.repeatForever(SKAction.sequence([
                        SKAction.run {
                            self.run(se_boon00)
                            let child = enemyformidboss(r: drand48() * 360, boss: self, player: player)
                            self.addChild(child)
                        },
                        SKAction.wait(forDuration: 0.25)
                    ])))
                }
            ]))
            }
        self.spellcard = [sk1]
        self.run(self.spellcard[0])
        self.run(dodefaultaction())
        }
}

class bossonly: boss{
    
    convenience init(x: CGFloat, y: CGFloat, p:SKNode, player: player) {
        self.init(imageNamed:"0")
        self.setScale(2.5)
        self.position = CGPoint(x:x, y:y)
        self.anim = enemystrong
        self.run(SKAction.repeatForever(anim!))
        
        self.physicsBody = SKPhysicsBody(circleOfRadius:self.size.width / 2)
        self.physicsBody?.allowsRotation = false  //禁止旋转
        self.physicsBody?.categoryBitMask = enemyCategory //设置物理体标示
        self.physicsBody?.collisionBitMask = sceneCategory
        self.physicsBody?.contactTestBitMask = playerbulletCategory
        p.addChild(self)
        
        self.life = 6
        self.health = [600, 700, 700, 800, 1000, 1000]
        
        let sk1 = noncard(self: self)
        let sk2 = card1(self: self)
        let sk3 = noncard2(self: self, player: player)
        let sk4 = card2(self: self, player: player)
        let sk5 = boli(self: self)
        let sk6 = masterspark(self: self, player: player)
        self.spellcard = [sk1, sk2, sk3, sk4, sk5, sk6]
        self.run(SKAction.sequence([
            SKAction.move(to: CGPoint(x: 0, y: 300), duration: 2),
            self.spellcard[0]
        ]))
        self.run(dodefaultaction())
    }
}
