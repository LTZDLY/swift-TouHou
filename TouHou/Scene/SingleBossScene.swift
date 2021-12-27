//
//  SingleBossScene.swift
//  TouHou
//
//  Created by lin on 2021/12/25.
//

import SpriteKit

class SingleBossScene: TouHouScene {
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        m = player(x:0, y:-300, p:self)
        let a = SKAudioNode(fileNamed: "/audio/bgm/stage1boss.mp3")
        a.autoplayLooped = false
        self.addChild(a)
        a.run(SKAction.sequence([
            SKAction.wait(forDuration: 2),SKAction.play()]),withKey: "frontbgm")
        self.bgm = a
        self.run(
            SKAction.sequence([
                SKAction.wait(forDuration: 1),self.dodefaultaction(player: m!)
            ])
        )
    }
    
    func dodefaultaction(player: player)->SKAction{
        SKAction.sequence([
            SKAction.run {
                self.st.inboss = true
                let boss = bossonly(x:0, y:800, p:self, player: player)
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
