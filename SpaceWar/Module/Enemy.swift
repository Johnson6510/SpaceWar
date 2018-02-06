//
//  Enemy.swift
//  SpaceWar
//
//  Created by 黃健偉 on 2018/2/6.
//  Copyright © 2018年 黃健偉. All rights reserved.
//

import SpriteKit

class Enemy: SKNode {
    var enemy: SKSpriteNode

    var x: CGFloat = 0
    var y: CGFloat = 0
    var width: CGFloat = 40
    var height: CGFloat = 40
    var enemyName: String = "alien01"

    private var move: CGPoint?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(x: CGFloat, y: CGFloat) {
        enemy = SKSpriteNode.init(imageNamed: enemyName)
        
        super.init()
        self.name = "Enemy_01"
        
        enemy.size = CGSize(width: width, height: height)
        enemy.position = CGPoint(x: x, y: y)
        addChild(enemy)
    }
}
