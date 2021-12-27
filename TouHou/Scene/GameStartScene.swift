//
//  SingleBossScene.swift
//  TouHou
//
//  Created by lin on 2021/12/25.
//


import SpriteKit

class GameStartScene: SKScene {
    override func didMove(to view: SKView) {
        initializeStartButton()
    }
    
    var stageone: MeCustomButton?
    var singleboss: MeCustomButton?
    
    func initializeStartButton() {
        stageone = MeCustomButton(btnName: "start", btnSize:CGSize(width: 400, height: 150) , btnCornerRadius: 10);
        stageone?.position = CGPoint(x: 0, y: 200);//button的位置
        stageone?.m_fontColor = .white;//文字颜色默认为白色
        stageone?.m_BackgroundColor = .clear;//背景色为透明
        stageone?.m_FontName = "GB18030Bitmap";//设置字体
        stageone?.m_LabelText = "全关游戏";//设置文字
        stageone?.m_FontSize = 80;//设置文字尺寸
        stageone?.borderColor = .white;//设置文字颜色
        stageone?.m_borderLineWidth = 5;//边框宽度
        stageone?.clickEvent = {//设置点击事件
           let firstScene = SKScene(fileNamed: "StageOneScene")!
            firstScene.scaleMode = .aspectFill
           self.view?.presentScene(firstScene,transition: SKTransition.crossFade(withDuration: 0.5));
        };
        self.addChild(stageone!);//场景添加按钮
        
        singleboss = MeCustomButton(btnName: "singleboss", btnSize:CGSize(width: 600, height: 150) , btnCornerRadius: 10);
        singleboss?.position = CGPoint(x: 0, y: -200);//button的位置
        singleboss?.m_fontColor = .white;//文字颜色默认为白色
        singleboss?.m_BackgroundColor = .clear;//背景色为透明
        singleboss?.m_FontName = "GB18030Bitmap";//设置字体
        singleboss?.m_LabelText = "单独boss模式";//设置文字
        singleboss?.m_FontSize = 80;//设置文字尺寸
        singleboss?.borderColor = .white;//设置文字颜色
        singleboss?.m_borderLineWidth = 5;//边框宽度
        singleboss?.clickEvent = {//设置点击事件
           let firstScene = SKScene(fileNamed: "SingleBossScene")!
            firstScene.scaleMode = .aspectFill
           self.view?.presentScene(firstScene,transition: SKTransition.crossFade(withDuration: 0.5));
        };
        self.addChild(singleboss!);//场景添加按钮
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let location = t.location(in: self);
            
            let mnode = nodes(at: location);
            
            for nnode in mnode{
                let na = nnode as? MeCustomButton;
                if(na?.name == "singleboss"){
                    singleboss?.touchUpInside(highLightBGColor: .white, highLightFontColor: .black)
                } else if(na?.name == "start"){
                    stageone?.touchUpInside(highLightBGColor: .white, highLightFontColor: .black);
                }
            }
        }
    }
}

