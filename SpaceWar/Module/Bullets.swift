//
//  Bullets.swift
//  SpaceWar
//
//  Created by 黃健偉 on 2018/2/6.
//  Copyright © 2018年 黃健偉. All rights reserved.
//

import SpriteKit

class ShineBullet: SKNode {
    var bullet: SKShapeNode
    var x: CGFloat = 0
    var y: CGFloat = 0
    var width: CGFloat = 0
    var height: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        bullet = SKShapeNode.init(rectOf: CGSize.init(width: width, height: height), cornerRadius: width * 0.3)

        super.init()
        
        bullet.position = CGPoint(x: x, y: y)
        bullet.fillColor = UIColor.random()
        bullet.glowWidth = width * 0.3
        bullet.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 0.5)))
        addChild(bullet)
    }    
}

class ClassicBullet: SKNode {
    var bullet: SKSpriteNode
    var x: CGFloat = 0
    var y: CGFloat = 0
    var width: CGFloat = 0
    var height: CGFloat = 0
    var bulletName: String = "ClassicBulletLv1"

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(level: Int, x: CGFloat, y: CGFloat) {
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
        
        bullet.size = CGSize(width: width, height: height)
        bullet.position = CGPoint(x: x, y: y)
        addChild(bullet)
    }
}

class LaserBullet: SKNode {
    var bullet: SKShapeNode
    var x: CGFloat = 0
    var y: CGFloat = 0
    var maxY: CGFloat = 0
    var laserColor: UIColor = UIColor(red: 204/255, green: 255/255, blue: 255/255, alpha:0.8)

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(x: CGFloat, y: CGFloat, maxY: CGFloat) {
        bullet = SKShapeNode()

        super.init()
        
        bullet.lineWidth = 1
        bullet.glowWidth = 5
        bullet.strokeColor = laserColor

        let path = CGMutablePath()
        let rayEnd = CGPoint(x: x, y: y)
        let rayStart = CGPoint(x: x, y: maxY)

        path.move(to: rayStart)
        path.addLine(to: rayEnd)
        bullet.path = path
        
    
        addChild(bullet)
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}

