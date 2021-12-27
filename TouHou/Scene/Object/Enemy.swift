//
//  Enemy.swift
//  TouHou
//
//  Created by lin on 2021/12/25.
//

import SpriteKit
import GameplayKit

class enemy: SKSpriteNode {
    
    var hp: Float? // 生命值
    var anim: SKAction? // 动作帧
    func beack(dmg: Float){ // 被攻击
        self.hp! -= dmg
        if self.hp! < 0{
            self.onkill()
        }
    }
    
    func onkill(){
        var a = 1.0
        self.run(
            SKAction.sequence([
                SKAction.scale(to: 0, duration: 0),
                SKAction.run {
                    self.run(se_enep00)
                    let t = SKSpriteNode(imageNamed: "misc_05")
                    t.position = self.position
                    t.run(SKAction.scale(by: 5, duration: 0.3))
                    t.run(SKAction.rotate(byAngle: 3.14, duration: 0.3))
                    t.run(
                        SKAction.repeat(SKAction.sequence([
                            SKAction.run {
                                t.alpha = a
                                a -= (1.0/(0.3/0.02))
                            },
                            SKAction.wait(forDuration: 0.02),
                        ]), count: Int((0.3/0.02))))
                    t.run(SKAction.sequence([
                        SKAction.wait(forDuration: 0.3),
                        SKAction.removeFromParent()
                    ]))
                    self.parent?.addChild(t)
                },
                SKAction.removeFromParent(),
                SKAction.run {
                    self.removeAllChildren()
                    self.removeAllActions()
                },
            ])
        )
    }
}

class enemyo: enemy{
    
    convenience init(x: CGFloat, y: CGFloat, p:SKNode) {
        self.init(imageNamed:"0")
        self.zPosition = 10
        self.setScale(2.5)
        self.position = CGPoint(x:x, y:y)
        self.birdStartFly()
        self.hp = 100
        
        self.physicsBody = SKPhysicsBody(circleOfRadius:self.size.width / 2)
        self.physicsBody?.allowsRotation = false  //禁止旋转
        self.physicsBody?.categoryBitMask = enemyCategory //设置物理体标示
        self.physicsBody?.collisionBitMask = 0x0
        self.physicsBody?.contactTestBitMask = playerbulletCategory
        self.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.run {
                self.run(self.buildAction(x: 0, y: 0, parent: p, s: self, lock: true))
            },
            SKAction.wait(forDuration: 0.5)
        ])))
        
        self.run(SKAction.sequence([
            SKAction.wait(forDuration: 2),
            SKAction.move(to: CGPoint(x: x+300, y: x+300), duration: 3),
            SKAction.wait(forDuration: 5),
            SKAction.removeFromParent()
        ]))
        p.addChild(self)
    }
    
    func birdStartFly()  {
        let birdTexture1 = SKTexture(imageNamed: "0")
        birdTexture1.filteringMode = .nearest
        let birdTexture2 = SKTexture(imageNamed: "1")
        birdTexture2.filteringMode = .nearest
        let birdTexture3 = SKTexture(imageNamed: "2")
        birdTexture3.filteringMode = .nearest
        let birdTexture4 = SKTexture(imageNamed: "3")
        birdTexture4.filteringMode = .nearest
        anim = SKAction.animate(with: [birdTexture1,birdTexture2,birdTexture3,birdTexture4], timePerFrame: 0.1)
        self.run(SKAction.repeatForever(anim!))
    }
    
    func buildAction(x: CGFloat, y: CGFloat, parent: SKNode, s: SKNode, lock: Bool) -> SKAction {
        var i = drand48() * 360
        return SKAction.run {
            parent.run(
                SKAction.repeat(
                    SKAction.sequence([
                        SKAction.run {
                            let b = bullet(texture: grain, x:s.position.x + x, y:s.position.y + y, v: 5, angle: CGFloat(i))
                            parent.addChild(b)
                            i+=10
                        }
                    ]), count: 36
                )
            )
        }
    }
}

class myenemynoatk: enemy{
    convenience init(x: CGFloat, y: CGFloat, p:SKNode, player: player, b: Int) {
        self.init(texture: enemyb1)
        self.anim = enemyb
        self.zPosition = 10
        self.setScale(2.5)
        self.position = CGPoint(x:x, y:y)
        self.run(SKAction.repeatForever(anim!))
        self.hp = 5
        
        self.physicsBody = SKPhysicsBody(circleOfRadius:self.size.width / 2)
        self.physicsBody?.allowsRotation = false  //禁止旋转
        self.physicsBody?.categoryBitMask = enemyCategory //设置物理体标示
        self.physicsBody?.collisionBitMask = 0x0
        self.physicsBody?.contactTestBitMask = playerbulletCategory
        
        self.run(SKAction.sequence([
            SKAction.move(to: CGPoint(x: x+150 * Double(b), y: y-500), duration: 1.5),
            SKAction.wait(forDuration: 0.5),
            SKAction.move(by: getvector(from: self.position, to: player.position), duration: 10),
            SKAction.removeFromParent()
        ]))
        p.addChild(self)
    }
}

class myenemyr1: enemy{
    convenience init(x: CGFloat, y: CGFloat, p:SKNode, player: player, b: Int) {
        self.init(texture: enemyr1)
        self.anim = enemyr
        self.zPosition = 10
        self.setScale(2.5)
        self.position = CGPoint(x:x, y:y)
        self.run(SKAction.repeatForever(anim!))
        self.hp = 5
        
        self.physicsBody = SKPhysicsBody(circleOfRadius:self.size.width / 2)
        self.physicsBody?.allowsRotation = false  //禁止旋转
        self.physicsBody?.categoryBitMask = enemyCategory //设置物理体标示
        self.physicsBody?.collisionBitMask = 0x0
        self.physicsBody?.contactTestBitMask = playerbulletCategory
        
        
        self.run(
            SKAction.sequence([
                SKAction.wait(forDuration: 1),
                SKAction.run{
                    var r2 = drand48() * 360.0
                    for _ in 0...5{
                        let b = bullet(texture: circle, x: self.position.x, y: self.position.y, v: 3, angle: r2, a: 15)
                        p.addChild(b)
                        r2+=360.0 / 6
                    }
                },
                SKAction.repeat(SKAction.sequence([
                    SKAction.run {
                        p.run(se_tan00)
                        var r = AimtoPlayer(from: self.position, to: player.position) - 3
                        for _ in 0...2{
                            let b = bullet(texture: smallball, x: self.position.x, y: self.position.y, v: 6, angle: r, a: 15)
                            p.addChild(b)
                            r += 3
                        }
                    },
                SKAction.wait(forDuration: 0.5)
                ]), count: 3)
            ])
        )
        
        self.run(SKAction.sequence([
            SKAction.move(to: CGPoint(x: x+150 * Double(b), y: y-500), duration: 1.5),
            SKAction.wait(forDuration: 0.5),
            SKAction.move(by: getvector(from: self.position, to: player.position), duration: 10),
            SKAction.removeFromParent()
        ]))
        p.addChild(self)
    }
}

class myenemyr2: enemy{
    convenience init(x: CGFloat, y: CGFloat, p:SKNode, player: player, b: Int) {
        self.init(texture: enemyr1)
        self.anim = enemyr
        self.zPosition = 10
        self.setScale(2.5)
        self.position = CGPoint(x:x, y:y)
        self.run(SKAction.repeatForever(anim!))
        self.hp = 5
        
        self.physicsBody = SKPhysicsBody(circleOfRadius:self.size.width / 2)
        self.physicsBody?.allowsRotation = false  //禁止旋转
        self.physicsBody?.categoryBitMask = enemyCategory //设置物理体标示
        self.physicsBody?.collisionBitMask = 0x0
        self.physicsBody?.contactTestBitMask = playerbulletCategory
        
        // 发弹
        self.run(
            SKAction.sequence([
                SKAction.wait(forDuration: 0.5 + drand48() * 0.5),
                SKAction.repeat(SKAction.sequence([
                    SKAction.run {
                        p.run(se_tan00)
                        let r = AimtoPlayer(from: self.position, to: player.position)
                        let b = speedbullet(texture: grain, x: self.position.x, y: self.position.y, vs: 16, ve: 6, angle: r, t: 0.2)
                        p.addChild(b)
                    },
                    SKAction.wait(forDuration: 0.1 + drand48() * 0.1)
                ]), count: 10)
            ])
        )
        
        self.run(SKAction.sequence([
            SKAction.move(by: CGVector(dx: 0, dy: -400), duration: 1),
            SKAction.move(by: CGVector(dx: 800 * b, dy: -300), duration: 3),
            SKAction.wait(forDuration: 5),
            SKAction.removeFromParent()
        ]))
        p.addChild(self)
    }
}

class myenemybig1: enemy{
    convenience init(x: CGFloat, y: CGFloat, p:SKNode, player: player) {
        self.init(texture: enemyr1)
        self.anim = enemybig
        self.zPosition = 10
        self.setScale(3)
        self.position = CGPoint(x:x, y:y)
        self.run(SKAction.repeatForever(anim!))
        self.hp = 50
        
        self.physicsBody = SKPhysicsBody(circleOfRadius:self.size.width / 2)
        self.physicsBody?.allowsRotation = false  //禁止旋转
        self.physicsBody?.categoryBitMask = enemyCategory //设置物理体标示
        self.physicsBody?.collisionBitMask = 0x0
        self.physicsBody?.contactTestBitMask = playerbulletCategory
        
        var sv = 5.0
        self.run(
            SKAction.sequence([
                SKAction.wait(forDuration: 2),
                SKAction.repeat(SKAction.sequence([
                    SKAction.run {
                        p.run(se_tan00)
                        p.run(se_kira00)
                        var r = drand48() * 360
                        sv = 6
                        for _ in 0...2{
                            for _ in 0...31{
                                let b = bullet(texture: smallball, x: self.position.x, y: self.position.y, v: sv, angle: r, a: 15)
                                p.addChild(b)
                                r += 360.0/32.0
                            }
                            sv -= 0.8
                            r -= 2
                        }
                    },
                SKAction.wait(forDuration: 0.7)
                ]), count: 3)
            ])
        )
        
        self.run(SKAction.sequence([
            SKAction.move(by: CGVector(dx: 0, dy: -400), duration: 2),
            SKAction.wait(forDuration: 5),
            SKAction.move(by: getvector(from: self.position, to: player.position), duration: 10),
            SKAction.removeFromParent()
        ]))
        p.addChild(self)
    }
}

class myenemybig2: enemy{
    convenience init(x: CGFloat, y: CGFloat, p:SKNode, b: Int) {
        self.init(texture: enemyr1)
        self.anim = enemybig
        self.zPosition = 10
        self.setScale(3)
        self.position = CGPoint(x:x, y:y)
        self.run(SKAction.repeatForever(anim!))
        self.hp = 30
        
        self.physicsBody = SKPhysicsBody(circleOfRadius:self.size.width / 2)
        self.physicsBody?.allowsRotation = false  //禁止旋转
        self.physicsBody?.categoryBitMask = enemyCategory //设置物理体标示
        self.physicsBody?.collisionBitMask = 0x0
        self.physicsBody?.contactTestBitMask = playerbulletCategory
        
        self.run(
            SKAction.sequence([
                SKAction.wait(forDuration: 1 + drand48()),
                SKAction.repeat(SKAction.sequence([
                    SKAction.run {
                        p.run(se_tan00)
                        var r = drand48() * 360
                        var sv = 4.0
                        for _ in 0...1 {
                            for _ in 0...12 {
                                let b = speedbullet(texture: smallball, x: self.position.x, y: self.position.y, vs: sv * 4, ve: sv, angle: r, t: 0.15, a: 15)
                                p.addChild(b)
                                r += 360.0/13.0
                            }
                            sv -= 2
                        }
                    },
                    SKAction.wait(forDuration: 1.7)
                ]), count: 3)
            ])
        )
        
        self.run(SKAction.sequence([
            SKAction.move(by: CGVector(dx: 600 * b, dy: 50), duration: 3),
            SKAction.move(by: CGVector(dx: 100 * b, dy: -300), duration: 2),
            SKAction.move(by: CGVector(dx: -700 * b, dy: -50), duration: 3),
            SKAction.removeFromParent()
        ]))
        p.addChild(self)
    }
}

class enemyformidboss: enemy{
    convenience init(r:CGFloat, boss: boss, player: player) {
        self.init(texture: enemyfire1)
        self.anim = enemyfire
        self.zPosition = 10
        self.position = CGPoint(x:0, y:0)
        self.run(SKAction.repeatForever(anim!))
        self.hp = 7
        
        self.physicsBody = SKPhysicsBody(circleOfRadius:self.size.width / 2)
        self.physicsBody?.allowsRotation = false  //禁止旋转
        self.physicsBody?.categoryBitMask = enemyCategory //设置物理体标示
        self.physicsBody?.collisionBitMask = 0x0
        self.physicsBody?.contactTestBitMask = playerbulletCategory
        
        self.run(
            SKAction.sequence([
                SKAction.wait(forDuration: 0.5 + drand48()),
                SKAction.repeatForever(
                    SKAction.sequence([
                        SKAction.run {
                            self.run(se_tan00)
                            var r = drand48() * 360
                            let v = 1.0
                            for _ in 0...7{
                                let b = speedbullet(texture: smallball, x: boss.position.x + self.position.x * 2, y: boss.position.y + self.position.y * 2, vs: v + 15, ve: v, angle: r, a: 15)
                                b.setAcc(a: 0.1, angle: AimtoPlayer(from: boss.position, to: player.position))
                                b.vmax = 4
                                boss.parent?.addChild(b)
                                r += 360.0/8.0
                            }
                        },
                        SKAction.wait(forDuration: 2 + drand48() * 2.0)
                    ])
                )
                  
            ])
        )
        var t = r
        self.run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run {
                    t += 2 / 180 * Double.pi
                    self.run(SKAction.move(to: CGPoint(x: 40 * cos(t), y: 40 * sin(t)), duration: 1.0/60.0))
                },
                SKAction.wait(forDuration: 1.0/60.0)
            ])
        ))
    }
    override func onkill(){
        var a = 1.0
        self.run(
            SKAction.sequence([
                SKAction.scale(to: 0, duration: 0),
                SKAction.run {
                    self.run(se_enep00)
                    let t = SKSpriteNode(imageNamed: "misc_05")
                    t.position = self.position
                    t.run(SKAction.scale(by: 2, duration: 0.3))
                    t.run(SKAction.rotate(byAngle: 3.14, duration: 0.3))
                    t.run(
                        SKAction.repeat(SKAction.sequence([
                            SKAction.run {
                                t.alpha = a
                                a -= (1.0/(0.3/0.02))
                            },
                            SKAction.wait(forDuration: 0.02),
                        ]), count: Int((0.3/0.02))))
                    t.run(SKAction.sequence([
                        SKAction.wait(forDuration: 0.3),
                        SKAction.removeFromParent()
                    ]))
                    self.parent?.addChild(t)
                },
                SKAction.removeFromParent()
            ])
        )
    }
}

class myenemyfire: enemy{
    convenience init(x: CGFloat, y: CGFloat, p:SKNode, player: player) {
        self.init(texture: enemyfire1)
        self.anim = enemyfire
        self.zPosition = 10
        self.setScale(3)
        self.position = CGPoint(x:x, y:y)
        self.run(SKAction.repeatForever(anim!))
        self.hp = 10
        
        self.physicsBody = SKPhysicsBody(circleOfRadius:self.size.width / 2)
        self.physicsBody?.allowsRotation = false  //禁止旋转
        self.physicsBody?.categoryBitMask = enemyCategory //设置物理体标示
        self.physicsBody?.collisionBitMask = 0x0
        self.physicsBody?.contactTestBitMask = playerbulletCategory
        
        self.run(
            SKAction.sequence([
                SKAction.wait(forDuration: 1 + drand48()*2),
                    SKAction.run {
                        p.run(se_tan00)
                        var sv = 8.0
                        for _ in 0...7{
                            let b = bullet(texture: smallball, x: self.position.x, y: self.position.y, v: sv, angle: AimtoPlayer(from: self.position, to: player.position), a: 15)
                            p.addChild(b)
                            sv -= 0.8
                        }
                    },
                SKAction.wait(forDuration: 0.7)
            ])
        )
        
        self.run(SKAction.sequence([
            SKAction.move(by: CGVector(dx: drand48() * 200 - 100, dy: -1000), duration: 15),
            SKAction.removeFromParent()
        ]))
        p.addChild(self)
    }
}
