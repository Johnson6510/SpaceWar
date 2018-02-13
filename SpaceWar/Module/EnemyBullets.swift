//
//  Bullets.swift
//  SpaceWar
//
//  Created by 黃健偉 on 2018/2/6.
//  Copyright © 2018年 黃健偉. All rights reserved.
//

import SpriteKit

class EnemyLinnerBullet: SKNode {
    var bullet: SKSpriteNode
    var width: CGFloat = 0
    var height: CGFloat = 0
    var moveSpeed: CGFloat = 1.0
    var bulletName: String = "ClassicBulletLv1"

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(parent: SKScene, level: Int, x: CGFloat, y: CGFloat) {
        if level == 1 {
            width = 9
            height = 12
        } else if level == 2 {
            width = 10
            height = 16
        } else if level == 3 {
            width = 10
            height = 19.5
        } else if level == 4 {
            width = 11
            height = 21
        }
        bulletName = "ClassicBulletLv" + String(level)
        bullet = SKSpriteNode.init(imageNamed: bulletName)
        
        super.init()
        self.name = "Classic"
        if level == 1 {
            self.attack = 10
        } else if level == 2 {
            self.attack = 20
        } else if level == 3 {
            self.attack = 30
        } else if level == 4 {
            self.attack = 40
        }

        bullet.size = CGSize(width: width, height: height)
        bullet.position = CGPoint(x: x, y: y)
        addChild(bullet)

        let frameHeight = -parent.frame.size.height
        let moveAction = SKAction.moveTo(y: frameHeight, duration: TimeInterval(moveSpeed / frameHeight * (frameHeight - y)))
        bullet.run(SKAction.sequence([moveAction, SKAction.removeFromParent()]))
    }
}




