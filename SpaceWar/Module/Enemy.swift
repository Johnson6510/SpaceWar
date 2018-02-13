//
//  Enemy.swift
//  SpaceWar
//
//  Created by 黃健偉 on 2018/2/6.
//  Copyright © 2018年 黃健偉. All rights reserved.
//

import SpriteKit

let maxEnemies = 14
enum enemyType: Int, CustomStringConvertible {
    var description: String {
        return enemyName
    }
    
    case enemy01 = 1
    case enemy02 = 2
    case enemy03 = 3
    case enemy04 = 4
    case enemy05 = 5
    case enemy06 = 6
    case enemy07 = 7
    case enemy08 = 8
    case enemy09 = 9
    case enemy10 = 10
    case enemy11 = 11
    case enemy12 = 12
    case enemy13 = 13
    case enemy14 = 14
    
    var enemyName: String {
        let enemyName = [
            "alien01",
            "alien02",
            "alien03",
            "alien04",
            "alien05",
            "alien06",
            "alien07",
            "alien08",
            "alien09",
            "alien10",
            "alien11",
            "alien12",
            "alien13",
            "alien14"]
        return enemyName[rawValue - 1]
    }

    static func random(_ dice: Int) -> enemyType {
        return enemyType(rawValue: Int(arc4random_uniform(UInt32(dice))) + 1)!
    }
}

let maxMode = 3
enum enemyMode: Int, CustomStringConvertible {
    var description: String {
        return modeName
    }
    
    case down = 1
    case unstable = 2
    case wave = 3
    
    var modeName: String {
        let modeName = [
            "Down",
            "Random",
            "Wave"]
        return modeName[rawValue - 1]
    }
    
    static func random(_ dice: Int) -> enemyMode {
        return enemyMode(rawValue: Int(arc4random_uniform(UInt32(dice))) + 1)!
    }
}

let maxType = 3
enum bulletType: Int, CustomStringConvertible {
    var description: String {
        return modeName
    }
    
    case linner = 1
    case eightWay = 2
    case threeWat = 3
    
    var modeName: String {
        let modeName = [
            "Down",
            "Random",
            "Wave"]
        return modeName[rawValue - 1]
    }
    
    static func random(_ dice: Int) -> bulletType {
        return bulletType(rawValue: Int(arc4random_uniform(UInt32(dice))) + 1)!
    }
}

class Enemy: SKNode {
    var enemy: SKSpriteNode

    var width: CGFloat = 40
    var height: CGFloat = 40
    var enemyName: String = "alien01"
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        enemyName = String(describing: enemyType.random(maxEnemies))
        enemy = SKSpriteNode.init(imageNamed: enemyName)
        
        super.init()
        self.name = enemyName
        self.hp = 1000
        self.maxHp = 1000
        self.defense = 10
        self.moveMode = enemyMode.random(maxMode)
        
        enemy.size = CGSize(width: width, height: height)
        addChild(enemy)
    }
}

