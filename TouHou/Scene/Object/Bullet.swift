//
//  Bullet.swift
//  TouHou
//
//  Created by lin on 2021/12/25.
//

import SpriteKit

// MARK: -BULLET基类
class bullet: SKSpriteNode {
    public var vx = CGFloat(0)//x速度
    public var vy = CGFloat(0)//y速度
    public var ax = CGFloat(0)//x加速度
    public var ay = CGFloat(0)//y加速度
    public var rot = CGFloat(0)
    public var a = CGFloat(8)// 判定半径
    public var vmax = CGFloat(999)
    public var navi = true// 朝向跟随方向
    public var timer = 0
    public var rotvelocity = CGFloat(0)
    
    convenience init(texture: SKTexture, x: CGFloat, y:CGFloat, v:CGFloat, angle:CGFloat, a:CGFloat = 8.0) {
        self.init(texture: texture)
        self.isHidden = true
        self.position = CGPoint(x: x, y: y)
        self.setBase(v: v, angle: angle)
        self.a = a
        self.ax = 0
        self.ay = 0
        self.rotvelocity = 0
        self.timer = 0
        self.setScale(2.5)
        self.setPhysicsBody(a: a)
        self.zPosition = 100
        self.run(dodefaultaction())
        self.parent?.addChild(self)
    }
    
    public func oncreate() {
        
    }
    
    public func setPhysicsBody(a: CGFloat){
        self.physicsBody = SKPhysicsBody(circleOfRadius: a)
        self.physicsBody?.allowsRotation = false  //禁止旋转
        self.physicsBody?.categoryBitMask = enemybulletCategory //设置物理体标示
        self.physicsBody?.collisionBitMask = 0x0
        self.physicsBody?.contactTestBitMask = playerCategory | sceneCategory  //设置可以碰撞检测的物理体
    }
    
    public func setBase(v: CGFloat, angle: CGFloat) {
        let ang = angle * Double.pi / 180
        self.vx = v * cos(ang)
        self.vy = v * sin(ang)
        if self.navi {
            self.rot = ang
            self.zRotation = self.rot
        }
    }
    public func setAcc(a: CGFloat, angle: CGFloat) {
        let ang = angle * Double.pi / 180
        self.ax = a * cos(ang)
        self.ay = a * sin(ang)
    }
    
    // MARK: -默认动作
    private func dodefaultaction() -> SKAction {
        let td = (1.0/60.0)
        // 定义雾化动作
        let start = SKAction.sequence([
            SKAction.run {
                var a = 0.0
                let t = SKSpriteNode(imageNamed: "test11")
                t.zPosition = 110
                t.alpha = 0
                t.size.width = self.size.width * 2
                t.size.height = self.size.height * 2
                t.position = self.position
                t.run(SKAction.scale(by: 1.0/2.5, duration: 15.0/60.0))
                t.run(SKAction.rotate(byAngle: self.rot, duration: 0))
                t.run(
                    SKAction.repeat(SKAction.sequence([
                        SKAction.run {
                            t.alpha = a
                            a += 0.05
                        },
                        SKAction.wait(forDuration: (1.0/60.0)),
                    ]), count: 15)
                )
                t.run(SKAction.sequence([
                    SKAction.wait(forDuration: 15.0/60.0),
                    SKAction.removeFromParent()
                ]))
                self.parent?.addChild(t)
            }
        ])
        return(
            SKAction.sequence([
                start,
                SKAction.wait(forDuration: 15.0/60.0),
                SKAction.run {
                    self.isHidden = false
                },
                // 执行每帧动作
                SKAction.repeatForever(
                    SKAction.sequence([
                        SKAction.run {
                            self.timer += 1
                            let v = sqrt(pow(self.vx, 2) + pow(self.vy, 2))
                            if v > self.vmax && Double(self.timer - 15) > (20.0/60.0){
                                self.vx /= (v / self.vmax)
                                self.vy /= (v / self.vmax)
                            }
                            else {
                                self.vx += self.ax
                                self.vy += self.ay
                            }
                            if self.rotvelocity != 0 {
                                self.navi = false
                                self.rot += self.rotvelocity / 180 * Double.pi
                                self.run(SKAction.rotate(byAngle: self.rotvelocity / 180 * Double.pi, duration: 0))
                            }
                            if self.navi {
                                self.rot = AimtoPlayer(from: self.position, to: CGPoint(x: self.position.x + self.vx, y: self.position.y + self.vy))
                                self.zRotation = CGFloat(self.rot / 180 * Double.pi)
                            }
                            self.run(SKAction.moveBy(x: self.vx, y: self.vy, duration: td))
                            if abs(self.position.x) > 375 && abs(self.position.y) > 667 {
                                self.run(SKAction.removeFromParent())
                            }
                        },
                    SKAction.wait(forDuration: td)
                    ])
                )
            ])
        )
    }
}

// MARK: -差速弹
// 差速弹貌似挺常用的，封装一下吧
class speedbullet: bullet{
    convenience init(texture: SKTexture, x: CGFloat, y:CGFloat, vs:CGFloat, ve:CGFloat, angle:CGFloat, t: CGFloat = 0.10, a:CGFloat = 8.0){
        self.init(texture: texture, x:x, y:y, v:vs, angle:angle)
        self.oncreate(angle: angle, v: ve, t: t)
    }
    
    func oncreate(angle: CGFloat, v: CGFloat, t:CGFloat) {
        self.run(SKAction.sequence([
            SKAction.wait(forDuration: 15.0/60.0 + t),
            SKAction.run {
                self.setBase(v: v, angle: angle)
            }
        ]))
    }
}

class bullettest: bullet{
    convenience init(po: CGPoint, angle: CGFloat, v: CGFloat, b: Int) {
        self.init(texture: grain, x: po.x, y: po.y, v: v, angle: angle)
        self.oncreate(angle: angle, v: v, b: b)
    }
    
    func oncreate(angle: CGFloat, v: CGFloat, b: Int) {
        var sv = v
        var sr = angle
        let dv = v / 60.0
        let dr = 1.0
        self.run(SKAction.sequence([
            SKAction.wait(forDuration: 15.0/60.0),
            SKAction.run {
                sv = v
                sr = angle
            },
            SKAction.repeat(SKAction.sequence([
                SKAction.run {
                    self.setBase(v: sv, angle: sr)
                    sv -= dv
                    sr += dr * Double(b)
                },
                SKAction.wait(forDuration: 1.0/60.0)
            ]), count: 60),
            SKAction.run {
                sv = v
                sr -= 90 * Double(b)
            },
            SKAction.repeat(SKAction.sequence([
                SKAction.run {
                    self.setBase(v: sv, angle: sr)
                    sv -= dv
                    sr += dr * Double(b)
                },
                SKAction.wait(forDuration: 1.0/60.0)
            ]), count: 60),
            SKAction.run {
                sv = v - 1
                sr -= 90 * Double(b)
                self.setBase(v: sv, angle: sr)
            },
        ]))
    }
}
