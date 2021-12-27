//
//  File.swift
//  TouHou
//
//  Created by lin on 2021/12/25.
//

import CoreGraphics
import SpriteKit
import AVFoundation
import MediaPlayer

let playerCategory: UInt32 = 0x1 << 0
let playerbulletCategory: UInt32 = 0x1 << 1
let enemyCategory: UInt32 = 0x1 << 2
let enemybulletCategory: UInt32 = 0x1 << 3
let sceneCategory: UInt32 = 0x1 << 8

func AimtoPlayer(from: CGPoint, to: CGPoint)->CGFloat{
    var r = atan((from.x - to.x)/(from.y - to.y))
        r = Double.pi / 2 + r
    if (from.y > to.y){
        r = -r
    } else {
        r = Double.pi - r
    }
    return r / Double.pi * 180
}

func getvector(from: CGPoint, to: CGPoint) -> CGVector {
    let x = to.x - from.x
    let y = to.y - from.y
    let d = sqrt(pow(x, 2.0) + pow(y, 2.0))
    let dx = x / d
    let dy = y / d
    return CGVector(dx: dx * 1500, dy: dy * 1500)
}

let grain=SKTexture(imageNamed: "grain")
let ellipse=SKTexture(imageNamed: "ellipse")
let lightball=SKTexture(imageNamed: "lightball")
let smallball=SKTexture(imageNamed: "smallball")
let bigball=SKTexture(imageNamed: "bigball")
let bigstar=SKTexture(imageNamed: "bigstar")
let test=SKTexture(imageNamed: "test11")
let circle=SKTexture(imageNamed: "circle")
let cplayerbullet=SKTexture(imageNamed: "reimubullet1")

let bgm_1boss = SKAudioNode(fileNamed: "/audio/bgm/stage1boss.mp3")
let bgm_1mid = SKAudioNode(fileNamed: "/audio/bgm/stage1.mp3")

let se_tan00 = SKAction.playSoundFileNamed("/audio/se/se_tan00_", waitForCompletion: false)
let se_kira00 = SKAction.playSoundFileNamed("/audio/se/se_kira00", waitForCompletion: false)
let se_enep00 = SKAction.playSoundFileNamed("/audio/se/se_enep00_", waitForCompletion: false)
let se_enep01 = SKAction.playSoundFileNamed("/audio/se/se_enep01", waitForCompletion: false)
let se_nep00 = SKAction.playSoundFileNamed("/audio/se/se_nep00", waitForCompletion: false)
let se_ch02 = SKAction.playSoundFileNamed("/audio/se/se_ch02", waitForCompletion: false)
let se_boon00 = SKAction.playSoundFileNamed("/audio/se/se_boon00", waitForCompletion: false)
let se_pldead00 = SKAction.playSoundFileNamed("/audio/se/se_pldead00", waitForCompletion: false)

let enemyr1 = SKTexture(imageNamed: "enemyr_01")
let enemyr2 = SKTexture(imageNamed: "enemyr_02")
let enemyr3 = SKTexture(imageNamed: "enemyr_03")
let enemyr4 = SKTexture(imageNamed: "enemyr_04")
let enemyr = SKAction.animate(with: [enemyr1,enemyr2,enemyr3,enemyr4], timePerFrame: 0.1)

let enemyb1 = SKTexture(imageNamed: "enemyb_01")
let enemyb2 = SKTexture(imageNamed: "enemyb_02")
let enemyb3 = SKTexture(imageNamed: "enemyb_03")
let enemyb4 = SKTexture(imageNamed: "enemyb_04")
let enemyb = SKAction.animate(with: [enemyb1,enemyb2,enemyb3,enemyb4], timePerFrame: 0.1)

let enemybig1 = SKTexture(imageNamed: "enemybig_01")
let enemybig2 = SKTexture(imageNamed: "enemybig_02")
let enemybig3 = SKTexture(imageNamed: "enemybig_03")
let enemybig4 = SKTexture(imageNamed: "enemybig_04")
let enemybig = SKAction.animate(with: [enemybig1,enemybig2,enemybig3,enemybig4], timePerFrame: 0.1)

let enemyblue1 = SKTexture(imageNamed: "enemyblue_01")
let enemyblue2 = SKTexture(imageNamed: "enemyblue_02")
let enemyblue3 = SKTexture(imageNamed: "enemyblue_03")
let enemyblue4 = SKTexture(imageNamed: "enemyblue_04")
let enemyblue = SKAction.animate(with: [enemyblue1,enemyblue2,enemyblue3,enemyblue4], timePerFrame: 0.1)

let enemystrong1 = SKTexture(imageNamed: "0")
let enemystrong2 = SKTexture(imageNamed: "1")
let enemystrong3 = SKTexture(imageNamed: "2")
let enemystrong4 = SKTexture(imageNamed: "3")
let enemystrong = SKAction.animate(with: [enemystrong1,enemystrong2,enemystrong3,enemystrong4], timePerFrame: 0.1)

let enemyfire1 = SKTexture(imageNamed: "enemyfire_01")
let enemyfire2 = SKTexture(imageNamed: "enemyfire_02")
let enemyfire3 = SKTexture(imageNamed: "enemyfire_03")
let enemyfire4 = SKTexture(imageNamed: "enemyfire_04")
let enemyfire5 = SKTexture(imageNamed: "enemyfire_05")
let enemyfire6 = SKTexture(imageNamed: "enemyfire_06")
let enemyfire7 = SKTexture(imageNamed: "enemyfire_07")
let enemyfire8 = SKTexture(imageNamed: "enemyfire_08")
let enemyfire = SKAction.animate(with: [enemyfire1,enemyfire2,enemyfire3,enemyfire4,enemyfire5,enemyfire6,enemyfire7,enemyfire8], timePerFrame: 0.05)

class status {
    var inboss = false
}
