//
//  StageOneScene.swift
//  TouHou
//
//  Created by lin on 2021/12/26.
//

import SpriteKit

class StageOneScene: TouHouScene {
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        m = player(x:0, y:-300, p:self)
        let a = SKAudioNode(fileNamed: "/audio/bgm/stage1.mp3")
        a.autoplayLooped = false
        self.addChild(a)
        a.run(SKAction.sequence([
            SKAction.wait(forDuration: 3),SKAction.play()]),withKey: "frontbgm")
        self.bgm = a
        self.run(
            SKAction.sequence([
                SKAction.wait(forDuration: 3),self.dodefaultaction(player: m!)
            ])
        )
    }
    
    func dodefaultaction(player: player)->SKAction{
        SKAction.sequence([
            SKAction.run {
                var f = 1
                var x = -300
                self.run(
                    SKAction.repeat(
                        SKAction.sequence([
                        SKAction.run {
                            let er = myenemyr1(x: CGFloat(x * f), y: 800, p: self, player: player, b: f)
                            f = f * -1
                            x += 20
                        },
                        SKAction.wait(forDuration: 0.5)
                    ]), count: 20))
            },
            SKAction.wait(forDuration: 14),
            SKAction.run {self.run(
                SKAction.repeat(
                    SKAction.sequence([
                    SKAction.run {
                        let er = myenemyr2(x: -100 + drand48() * 50, y: 800, p: self, player: player, b: 1)
                    },
                    SKAction.wait(forDuration: 0.3)
                ]), count: 14)
            )},
            SKAction.wait(forDuration: 3),
            SKAction.run {self.run(
                SKAction.repeat(
                    SKAction.sequence([
                    SKAction.run {
                        let er = myenemyr2(x: 300 + drand48() * 50, y: 800, p: self, player: player, b: -1)
                    },
                    SKAction.wait(forDuration: 0.3)
                ]), count: 14)
            )},
            SKAction.wait(forDuration: 3),
            SKAction.run {self.run(
                SKAction.repeat(
                    SKAction.sequence([
                    SKAction.run {
                        let er = myenemyr2(x: -300 - drand48() * 50, y: 800, p: self, player: player, b: 1)
                    },
                    SKAction.wait(forDuration: 0.3)
                ]), count: 14)
            )},
            SKAction.wait(forDuration: 1),
            SKAction.run {
                let er = myenemybig1(x: 0, y: 800, p: self, player: player)
            },
            SKAction.wait(forDuration: 6),
            SKAction.run {self.run(
                SKAction.repeat(
                    SKAction.sequence([
                    SKAction.run {
                        let er = myenemynoatk(x: 250 + drand48() * 100, y: 800, p: self, player: player, b: -1)
                    },
                    SKAction.wait(forDuration: 0.5)
                ]), count: 5)
            )},
            SKAction.repeat(
                SKAction.sequence([
                SKAction.run {
                    let er = myenemybig2(x: -500, y: 500, p: self, b: 1)
                },
                SKAction.wait(forDuration: 1.5)
            ]), count: 3),
            SKAction.wait(forDuration: 1),
            SKAction.run {self.run(
                SKAction.repeat(
                    SKAction.sequence([
                    SKAction.run {
                        let er = myenemyr1(x: -250 - drand48() * 100, y: 800, p: self, player: player, b: 1)
                    },
                    SKAction.wait(forDuration: 0.5)
                ]), count: 5)
            )},
            SKAction.repeat(
                SKAction.sequence([
                SKAction.run {
                    let er = myenemybig2(x: 500, y: 500, p: self, b: -1)
                },
                SKAction.wait(forDuration: 1.5)
                ]), count: 3),
            SKAction.wait(forDuration: 3),
            SKAction.run {
                self.st.inboss = true
                let midboss = midboss1(x: 500, y: 200, p: self, player: player)
                self.run(SKAction.repeatForever(
                    SKAction.sequence([
                        SKAction.run {
                        if midboss.status >= midboss.life{
                            self.st.inboss = false
                            self.removeAction(forKey: "midboss")
                            }
                        },
                        SKAction.wait(forDuration: 1.0/60.0)
                    
                    ])), withKey: "midboss")
            },
            SKAction.wait(forDuration: 2),
            SKAction.run {self.run(
                SKAction.repeat(
                    SKAction.sequence([
                    SKAction.run {
                        if self.st.inboss == false {
                            self.run(se_boon00)
                            let er = myenemyfire(x: 200 + drand48() * 100, y: 300 + drand48() * 300, p: self, player: player)
                        }
                    },
                    SKAction.run {
                        if self.st.inboss == false {
                            self.run(se_boon00)
                            let er = myenemyfire(x: -200 - drand48() * 100, y: 300 + drand48() * 300, p: self, player: player)
                        }
                    },
                    SKAction.wait(forDuration: 0.5),
                    SKAction.run {
                        if self.st.inboss == false {
                            self.run(se_boon00)
                            let er = myenemyfire(x: -200 - drand48() * 100, y: 300 + drand48() * 300, p: self, player: player)
                        }
                    },
                    SKAction.wait(forDuration: 0.5),
                    SKAction.run {
                        if self.st.inboss == false {
                            self.run(se_boon00)
                            let er = myenemyfire(x: -200 - drand48() * 100, y: 300 + drand48() * 300, p: self, player: player)
                        }
                    },
                    SKAction.wait(forDuration: 1),
                    SKAction.run {
                        if self.st.inboss == false {
                            self.run(se_boon00)
                            let er = myenemyfire(x: 200 + drand48() * 100, y: 400 + drand48() * 200, p: self, player: player)
                        }
                    },
                    SKAction.wait(forDuration: 0.5),
                    SKAction.run {
                        if self.st.inboss == false {
                            self.run(se_boon00)
                            let er = myenemyfire(x: 200 + drand48() * 100, y: 400 + drand48() * 200, p: self, player: player)
                        }
                    },
                    SKAction.wait(forDuration: 0.5),
                ]), count:6)
            )},
            SKAction.wait(forDuration: 17.5),
            SKAction.repeat(
                SKAction.sequence([
                    SKAction.run {
                        let er = myenemybig2(x: 500, y: 500, p: self, b: -1)
                    },
                    SKAction.wait(forDuration: 1.5)
                ]), count: 3),
            SKAction.wait(forDuration: 0.5),
            SKAction.run{self.run(
                SKAction.repeat(
                    SKAction.sequence([
                    SKAction.run {
                        self.run(se_boon00)
                        let er = myenemyfire(x: 200 + drand48() * 100, y: 400 + drand48() * 200, p: self, player: player)
                    },
                    SKAction.wait(forDuration: 0.5),
                    SKAction.run {
                        self.run(se_boon00)
                        let er = myenemyfire(x: 200 + drand48() * 100, y: 400 + drand48() * 200, p: self, player: player)
                    },
                    SKAction.wait(forDuration: 1),
                    SKAction.run {
                        self.run(se_boon00)
                        let er = myenemyfire(x: -200 - drand48() * 100, y: 300 + drand48() * 300, p: self, player: player)
                    },
                    SKAction.wait(forDuration: 0.5),
                    SKAction.run {
                        self.run(se_boon00)
                        let er = myenemyfire(x: -200 - drand48() * 100, y: 300 + drand48() * 300, p: self, player: player)
                    },
                    SKAction.wait(forDuration: 1),
                ]), count:4)
            )},
            SKAction.repeat(
                SKAction.sequence([
                    SKAction.run {
                        let er = myenemybig2(x: -500, y: 500, p: self, b: 1)
                    },
                    SKAction.wait(forDuration: 1.5)
                ]), count: 6),
            SKAction.wait(forDuration: 0.5),
            SKAction.repeat(
                SKAction.sequence([
                    SKAction.run {
                        let er = myenemybig2(x: 500, y: 500, p: self, b: -1)
                    },
                    SKAction.wait(forDuration: 1.5)
                ]), count: 3),
            SKAction.wait(forDuration: 1),
            SKAction.run {self.run(
                SKAction.repeat(
                    SKAction.sequence([
                    SKAction.run {
                        let er = myenemyr1(x: -250 - drand48() * 100, y: 800, p: self, player: player, b: 1)
                    },
                    SKAction.wait(forDuration: 0.5)
                ]), count: 5)
            )},
            SKAction.run {self.run(
                SKAction.repeat(
                    SKAction.sequence([
                    SKAction.run {
                        let er = myenemynoatk(x: 250 + drand48() * 100, y: 800, p: self, player: player, b: -1)
                    },
                    SKAction.wait(forDuration: 0.5)
                ]), count: 5)
            )},
            SKAction.repeat(
                SKAction.sequence([
                SKAction.run {
                    let er = myenemybig2(x: -500, y: 500, p: self, b: 1)
                },
                SKAction.wait(forDuration: 1.5)
            ]), count: 3),
            SKAction.wait(forDuration: 0.5),
            SKAction.run {self.run(
                SKAction.repeat(
                    SKAction.sequence([
                    SKAction.run {
                        let er = myenemyr1(x: -250 - drand48() * 100, y: 800, p: self, player: player, b: 1)
                    },
                    SKAction.wait(forDuration: 0.5)
                ]), count: 5)
            )},
            SKAction.run {self.run(
                SKAction.repeat(
                    SKAction.sequence([
                    SKAction.run {
                        let er = myenemynoatk(x: 250 + drand48() * 100, y: 800, p: self, player: player, b: -1)
                    },
                    SKAction.wait(forDuration: 0.5)
                ]), count: 5)
            )},
            SKAction.repeat(
                SKAction.sequence([
                SKAction.run {
                    let er = myenemybig2(x: 500, y: 500, p: self, b: -1)
                },
                SKAction.wait(forDuration: 1.5)
            ]), count: 3),
            SKAction.wait(forDuration: 10),
            SKAction.run{
                self.bgm?.run(SKAction.stop())
                self.bgm?.removeAction(forKey: "frontbgm")
                let a = SKAudioNode(fileNamed: "/audio/bgm/stage1boss.mp3")
                a.autoplayLooped = false
                self.addChild(a)
                a.run(SKAction.play(),withKey: "bossbgm")
                self.bgm = a
            },
            SKAction.wait(forDuration: 2),
            SKAction.run {
                self.st.inboss = true
                let boss = bosstest(x: 0, y: 800, p: self, player: player)
                self.run(SKAction.repeatForever(
                    SKAction.sequence([
                        SKAction.run {
                        if boss.status >= boss.life{
                            self.st.inboss = false
                            self.run(self.stageEnd(miss: player.miss))
                            self.removeAction(forKey: "stop")
                            }
                        },
                        SKAction.wait(forDuration: 1.0/60.0)
                    
                    ])
                ), withKey: "stop")
            }
        ])
    }
}
