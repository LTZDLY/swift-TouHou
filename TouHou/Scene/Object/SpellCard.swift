//
//  SpellCard.swift
//  TouHou
//
//  Created by lin on 2021/12/27.
//

import Foundation
import SpriteKit

func boli(self: SKNode)->SKAction {
    SKAction.run {
        var i = -90.0
        var j = 0.0
        let a = 0.03
        self.run (SKAction.repeatForever (SKAction.sequence ([
            SKAction.run {
                self.run ( SKAction.sequence ([
                        SKAction.run {
                            var r = i
                            j = j + a
                            i = i + j
                            for _ in 0...4{
                                let b = bullet(
                                    texture: grain, x:self.position.x + 50 * cos(r / 180 * Double.pi), y:self.position.y + 50 * sin(r / 180 * Double.pi), v: 4, angle: CGFloat(r))
                                b.setAcc(a: 0.1, angle: CGFloat(r))
                                self.parent!.addChild(b)
                                r+=360.0/5.0
                            }
                        },
                    ]))
            },
            SKAction.wait(forDuration: 2.0/60.0)
        ])))
    }
}

func noncard(self: SKNode) -> SKAction{
    SKAction.run {
        var r1 = 80.0
        var r2 = 150.0
        var r3 = 225.0
        let t1 = (260 - r1) / 10.0
        let t2 = (264 - r2) / 10.0
        let t3 = (268 - r3) / 10.0
        var nx = 0.0
        var ny = 0.0
        self.run(
            SKAction.repeatForever(SKAction.sequence([
                // 发弹10次，移动
                SKAction.run {
                    nx = self.position.x
                    ny = self.position.y
                    r1 = 80.0
                    r2 = 150.0
                    r3 = 225.0
                },
                SKAction.repeat(SKAction.sequence([
                    SKAction.run{
                        self.run(se_tan00)
                        var v = 4.0
                        let vt = 10.0
                        let dt = 0.2
                        for _ in 0...2 {
                            let b1 = speedbullet(texture: grain, x: self.position.x, y: self.position.y, vs: v + vt, ve: v, angle: r1, t: dt)
                            let b2 = speedbullet(texture: grain, x: self.position.x, y: self.position.y, vs: v + vt, ve: v, angle: r2, t: dt)
                            let b3 = speedbullet(texture: grain, x: self.position.x, y: self.position.y, vs: v + vt, ve: v, angle: r3, t: dt)
                            let b4 = speedbullet(texture: grain, x: self.position.x, y: self.position.y, vs: v + vt, ve: v, angle: 180 - r1, t: dt)
                            let b5 = speedbullet(texture: grain, x: self.position.x, y: self.position.y, vs: v + vt, ve: v, angle: 180 - r2, t: dt)
                            let b6 = speedbullet(texture: grain, x: self.position.x, y: self.position.y, vs: v + vt, ve: v, angle: 180 - r3, t: dt)
                            self.parent!.addChild(b1)
                            self.parent!.addChild(b2)
                            self.parent!.addChild(b3)
                            self.parent!.addChild(b4)
                            self.parent!.addChild(b5)
                            self.parent!.addChild(b6)
                            v -= 0.5
                        }
                        r1 += t1
                        r2 += t2
                        r3 += t3
                    },
                    SKAction.wait(forDuration: 0.2)
                ]), count: 11),
                SKAction.run {
                    let tx = drand48() * 200 - 100
                    let ty = drand48() * 100 - 50
                    self.run(SKAction.moveBy(x: tx, y: ty, duration: 1))
                },
                SKAction.wait(forDuration: 2)
        ])))
        self.run(SKAction.repeatForever(SKAction.sequence([
            // 随机发弹，等待
            SKAction.run {
                self.run(se_tan00)
                var v = 1.0
                let x = nx + drand48() * 800 - 400
                let y = ny + drand48() * 400 - 200
                let r = CGFloat(-90) + drand48() * 4 - 2
                for _ in 0...1{
                    let b = bullet(
                        texture: smallball, x:x, y:y, v: v, angle: r, a:15)
                    self.parent!.addChild(b)
                    v += 2.0
                }
            },
            SKAction.wait(forDuration: 0.8)
        ])))
    }
}

func card1(self: SKNode) -> SKAction{
    SKAction.run {
        var r1 = 80.0
        var r2 = 150.0
        var r3 = 225.0
        let t1 = (260 - r1) / 10.0
        let t2 = (264 - r2) / 10.0
        let t3 = (268 - r3) / 10.0
        var nx = 0.0
        var ny = 0.0
        self.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.run {
                let tx = drand48() * 200 - 100
                let ty = drand48() * 100 - 50
                self.run(SKAction.moveBy(x: tx, y: ty, duration: 1))
            },
            SKAction.wait(forDuration: 2)
        ])))
        self.run(
            SKAction.repeatForever(SKAction.sequence([
                // 发弹10次，移动
                SKAction.run {
                    nx = self.position.x
                    ny = self.position.y
                    r1 = 80.0
                    r2 = 150.0
                    r3 = 225.0
                },
                SKAction.repeat(SKAction.sequence([
                    SKAction.run{
                        self.run(se_tan00)
                        var v = 4.0
                        let vt = 10.0
                        let dt = 0.2
                        for _ in 0...2 {
                            let b1 = speedbullet(texture: grain, x: self.position.x, y: self.position.y, vs: v + vt, ve: v, angle: r1, t: dt)
                            let b2 = speedbullet(texture: grain, x: self.position.x, y: self.position.y, vs: v + vt, ve: v, angle: r2, t: dt)
                            let b3 = speedbullet(texture: grain, x: self.position.x, y: self.position.y, vs: v + vt, ve: v, angle: r3, t: dt)
                            let b4 = speedbullet(texture: grain, x: self.position.x, y: self.position.y, vs: v + vt, ve: v, angle: 180 - r1, t: dt)
                            let b5 = speedbullet(texture: grain, x: self.position.x, y: self.position.y, vs: v + vt, ve: v, angle: 180 - r2, t: dt)
                            let b6 = speedbullet(texture: grain, x: self.position.x, y: self.position.y, vs: v + vt, ve: v, angle: 180 - r3, t: dt)
                            self.parent!.addChild(b1)
                            self.parent!.addChild(b2)
                            self.parent!.addChild(b3)
                            self.parent!.addChild(b4)
                            self.parent!.addChild(b5)
                            self.parent!.addChild(b6)
                            v -= 0.5
                        }
                        r1 += t1
                        r2 += t2
                        r3 += t3
                    },
                    SKAction.wait(forDuration: 0.2)
                ]), count: 11)
        ])))
        self.run(SKAction.repeatForever(SKAction.sequence([
            // 随机发弹，等待
            SKAction.run {
                self.run(se_tan00)
                var v = 1.0
                let x = nx + drand48() * 800 - 400
                let y = ny + drand48() * 400 - 200
                var r = CGFloat(-90) + drand48() * 4 - 2
                for _ in 0...2{
                    let b = bullet(
                        texture: smallball, x:x, y:y, v: v, angle: r, a: 15)
                    self.parent!.addChild(b)
                    v += 1.5
                    r += 0.3
                }
            },
            SKAction.wait(forDuration: 0.8)
        ])))
    }
}
func noncard2(self: SKNode, player: player) -> SKAction{
    SKAction.run {
        var r1 = 80.0
        var r2 = 150.0
        var r3 = 225.0
        let t1 = (250 - r1) / 10.0
        let t2 = (258 - r2) / 10.0
        let t3 = (266 - r3) / 10.0
        var nx = 0.0
        var ny = 0.0
        self.run(
            SKAction.repeatForever(SKAction.sequence([
                // 发弹10次，移动
                SKAction.run {
                    nx = self.position.x
                    ny = self.position.y
                    r1 = 80.0
                    r2 = 150.0
                    r3 = 225.0
                },
                SKAction.repeat(SKAction.sequence([
                    SKAction.run{
                        self.run(se_tan00)
                        var v = 4.0
                        let vt = 10.0
                        let dt = 0.2
                        for _ in 0...3 {
                            let b1 = speedbullet(texture: grain, x: self.position.x, y: self.position.y, vs: v + vt, ve: v, angle: r1, t: dt)
                            let b2 = speedbullet(texture: grain, x: self.position.x, y: self.position.y, vs: v + vt, ve: v, angle: r2, t: dt)
                            let b3 = speedbullet(texture: grain, x: self.position.x, y: self.position.y, vs: v + vt, ve: v, angle: r3, t: dt)
                            let b4 = speedbullet(texture: grain, x: self.position.x, y: self.position.y, vs: v + vt, ve: v, angle: 180 - r1, t: dt)
                            let b5 = speedbullet(texture: grain, x: self.position.x, y: self.position.y, vs: v + vt, ve: v, angle: 180 - r2, t: dt)
                            let b6 = speedbullet(texture: grain, x: self.position.x, y: self.position.y, vs: v + vt, ve: v, angle: 180 - r3, t: dt)
                            self.parent!.addChild(b1)
                            self.parent!.addChild(b2)
                            self.parent!.addChild(b3)
                            self.parent!.addChild(b4)
                            self.parent!.addChild(b5)
                            self.parent!.addChild(b6)
                            v -= 0.4
                        }
                        r1 += t1
                        r2 += t2
                        r3 += t3
                    },
                    SKAction.wait(forDuration: 0.2)
                ]), count: 11),
                SKAction.run {
                    let tx = drand48() * 200 - 100
                    let ty = drand48() * 100 - 50
                    self.run(SKAction.moveBy(x: tx, y: ty, duration: 1))
                },
                SKAction.wait(forDuration: 2)
        ])))
        self.run(SKAction.repeatForever(SKAction.sequence([
            // 随机发弹，等待
            SKAction.run {
                self.run(se_tan00)
                self.run(se_kira00)
                let x = nx + drand48() * 800 - 400
                let y = ny + drand48() * 400 - 200
                var r = AimtoPlayer(from: CGPoint(x: x, y: y), to: player.position) - 10
                for _ in 0...4{
                    let b = bullet(
                        texture: smallball, x:x, y:y, v: 3, angle: r, a:15)
                    self.parent!.addChild(b)
                    r += 5
                }
            },
            SKAction.wait(forDuration: 0.5)
        ])))
    }
}

func card2(self: SKNode, player: player) -> SKAction {
    SKAction.run {
        var r1 = 150.0
        let t1 = (276 - r1) / 10.0
        var nx = 0.0
        var ny = 0.0
        self.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.wait(forDuration: 0.8),
            SKAction.run {
                let tx = drand48() * 200 - 100
                let ty = drand48() * 100 - 50
                self.run(SKAction.moveBy(x: tx, y: ty, duration: 0.5))
            },
            SKAction.wait(forDuration: 0.7)
        ])))
        self.run(
            SKAction.repeatForever(SKAction.sequence([
                // 发弹10次，移动
                SKAction.run {
                    nx = self.position.x
                    ny = self.position.y
                    r1 = 150.0
                },
                SKAction.repeat(SKAction.sequence([
                    SKAction.run{
                        self.run(se_tan00)
                        self.run(se_kira00)
                        var v = 5.0
                        for _ in 0...2 {
                            let b1 = bullettest(po: self.position, angle: r1, v: v, b:-1)
                            self.parent!.addChild(b1)
                            let b2 = bullettest(po: self.position, angle: 180 - r1, v: v, b:1)
                            self.parent!.addChild(b2)
                            v -= 0.5
                        }
                        r1 += t1
                    },
                    SKAction.wait(forDuration: 0.1)
                ]), count: 11),
                SKAction.wait(forDuration: 0.4)
        ])))
        self.run(SKAction.repeatForever(SKAction.sequence([
            // 随机发弹，等待
            SKAction.run {
                self.run(se_tan00)
                let x = nx + drand48() * 800 - 400
                let y = ny + drand48() * 400 - 200
                let r = AimtoPlayer(from: CGPoint(x: x, y: y), to: player.position)
                let b = bullet(
                    texture: ellipse, x:x, y:y, v: 3, angle: r, a:15)
                self.parent!.addChild(b)
            },
            SKAction.wait(forDuration: 0.5)
        ])))
    }
}

func masterspark(self: SKNode, player: player) -> SKAction{
    SKAction.run{
        // 魔炮，两个task
        // task1: 循环【发射魔炮，移动】
        var r = 0.0
        self.run(SKAction.repeatForever(SKAction.sequence([
            // 发弹10次，移动
            SKAction.run {
                self.run(se_ch02)
                let tx = drand48() * 400 - 200
                let ty = drand48() * 100 - 50
                self.run(SKAction.moveBy(x: tx, y: ty, duration: 1))
            },
            SKAction.wait(forDuration: 1),
            SKAction.run {
                self.run(se_nep00)
                r = AimtoPlayer(from: self.position, to: player.position)
            },
            SKAction.repeat(SKAction.sequence([
                SKAction.run{
                    let v = 5.0
                    let b1 = bullet(texture: lightball, x: self.position.x, y: self.position.y, v: v + drand48() * 10.0, angle: r + drand48() * 30.0 - 15.0, a:40)
                    self.parent!.addChild(b1)
                },
                SKAction.wait(forDuration: 1.0/60.0)
            ]), count: 300),
            SKAction.wait(forDuration: 2)
        ])))
        // task2: 循环【开花弹】
        self.run(SKAction.sequence([
            SKAction.wait(forDuration: 2),
            SKAction.repeatForever(SKAction.sequence([
                SKAction.run{
                    self.run(se_tan00)
                    let rr = drand48() * 360.0
                    let v = 2.0
                    for i in 0...11{
                        for j in 0...1{
                            let b1 = bullet(texture: bigstar, x: self.position.x, y: self.position.y, v: v + 3.0 * Double(j), angle: rr + Double(i) * (360.0/11.0), a: 22)
                            self.parent!.addChild(b1)
                            b1.rotvelocity = 2
                        }
                    }
                },
                SKAction.wait(forDuration: 0.5)
            ]))
        ]))
    }
}
