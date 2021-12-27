//
//  TouHouScene.swift
//  TouHou
//
//  Created by lin on 2021/12/24.
//

import SpriteKit
import GameplayKit

class TouHouScene: SKScene, SKPhysicsContactDelegate{
    var m : player?
    var bgm: SKAudioNode?
    var st = status()
    var quitbutton: MeCustomButton?
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector.zero
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsWorld.contactDelegate = self
        self.physicsBody?.categoryBitMask = sceneCategory //设置物理体标示
        self.physicsBody?.contactTestBitMask = playerbulletCategory | enemybulletCategory  //设置可以碰撞检测的物理体
        self.initializeStartButton()
    }
    
    func stageEnd(miss: Int) -> SKAction{
        SKAction.sequence([
            SKAction.wait(forDuration: 2),
            SKAction.run {
                let t = SKLabelNode()
                t.text = "Stage Clear"
                t.fontSize = 100                     //大小
                t.fontName = "Chalkduster"          //类型
                t.position = CGPoint(x: 0, y: 300)
                t.fontColor = UIColor.black
                t.zPosition = 200
                self.addChild(t)
            },
            SKAction.wait(forDuration: 1),
            SKAction.run {
                let t = SKLabelNode()
                t.text = String(format:"被弹次数：%d", arguments:[miss])
                t.fontSize = 60                     //大小
                t.fontName = "Chalkduster"          //类型
                t.position = CGPoint(x: 0, y: 0)
                t.fontColor = UIColor.black
                t.zPosition = 200
                self.addChild(t)
            },
            SKAction.wait(forDuration: 5),
            SKAction.run {
                self.quitbutton?.touchUpInside(highLightBGColor: .white, highLightFontColor: .black)
            }
        ])
    }
    
    func initializeStartButton() {
        quitbutton = MeCustomButton(btnName: "quit", btnSize:CGSize(width: 200, height: 150) , btnCornerRadius: 10);
        quitbutton?.position = CGPoint(x: 300, y: -630);//button的位置
        quitbutton?.m_fontColor = .white;//文字颜色默认为白色
        quitbutton?.m_BackgroundColor = .clear;//背景色为透明
        quitbutton?.m_FontName = "GB18030Bitmap";//设置字体
        quitbutton?.m_LabelText = "退出";//设置文字
        quitbutton?.m_FontSize = 80;//设置文字尺寸
        quitbutton?.borderColor = .white;//设置文字颜色
        quitbutton?.m_borderLineWidth = 5;//边框宽度
        quitbutton?.clickEvent = {//设置点击事件
            let firstScene = SKScene(fileNamed: "GameStartScene")!
            firstScene.scaleMode = .aspectFill
            self.view?.presentScene(firstScene,transition: SKTransition.crossFade(withDuration: 0.5));
        };
        self.addChild(quitbutton!);//场景添加按钮
    }
        
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { m?.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { m?.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self);
            
            let mnode = nodes(at: location);
            
            for nnode in mnode{
                let na = nnode as? MeCustomButton;
                if(na?.name == "quit"){
                    quitbutton?.touchUpInside(highLightBGColor: .white, highLightFontColor: .black)
                } else if(na?.name == "start"){
                    // stageone?.touchUpInside(highLightBGColor: .white, highLightFontColor: .black);
                }
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var bodyA: SKPhysicsBody
        var bodyB:SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask{
            bodyA=contact.bodyA
            bodyB=contact.bodyB
        } else {
            bodyA=contact.bodyB
            bodyB=contact.bodyA
        }
        if bodyA.categoryBitMask == playerbulletCategory && bodyB.categoryBitMask == enemyCategory{
            bodyA.node?.run(SKAction.removeFromParent())
            let e = bodyB.node as? enemy
            let pb = bodyA.node as? PlayerBullet
            e?.beack(dmg: pb?.dmg ?? 0)
        }
        if bodyB.categoryBitMask == sceneCategory{
            bodyA.node?.run(SKAction.sequence([
                SKAction.wait(forDuration: 1),
                SKAction.removeFromParent()
            ]))
        }
        if bodyA.categoryBitMask == playerCategory{
            let player = bodyA.node as? player
            player?.gethit()
        }
    }
}
