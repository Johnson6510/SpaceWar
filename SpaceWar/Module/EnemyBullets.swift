//
//  Bullets.swift
//  SpaceWar
//
//  Created by 黃健偉 on 2018/2/6.
//  Copyright © 2018年 黃健偉. All rights reserved.
//

import SpriteKit

class EnemyLinnerBullet: SKNode {
    var width: CGFloat = 0
    var height: CGFloat = 0
    var moveSpeed: CGFloat = 1.0
    var bulletName: String = "ClassicBulletLv1"

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(parent: SKScene, layer: SKNode, level: Int, x: CGFloat, y: CGFloat) {
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
        let bullet = SKSpriteNode.init(imageNamed: bulletName)
        
        super.init()
        self.name = "EnemyLinnerBullet"
        if level == 1 {
            self.attack = 10
        } else if level == 2 {
            self.attack = 20
        } else if level == 3 {
            self.attack = 30
        } else if level == 4 {
            self.attack = 40
        }

        bullet.zRotation = CGFloat.pi
        bullet.size = CGSize(width: width, height: height)
        bullet.position = CGPoint(x: x, y: y)
        addChild(bullet)
        layer.addChild(self)
        self.zPosition = -1

        let frameHeight = -parent.frame.size.height
        let moveAction = SKAction.moveTo(y: frameHeight, duration: TimeInterval(moveSpeed / frameHeight * (frameHeight - y)))
        bullet.run(SKAction.sequence([moveAction, SKAction.removeFromParent()]))
        self.run(SKAction.wait(forDuration: TimeInterval(moveSpeed)), completion: {
            self.removeFromParent()
        })
    }
}

//Up, Down, Left, Right
class EnemyFourBullet1: SKNode {
    var bullet = [SKSpriteNode]()
    var width: CGFloat = 16
    var height: CGFloat = 16
    var moveSpeed: CGFloat = 3.0
    var bulletName: String = "GreenBullet"
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(parent: SKScene, layer: SKNode, level: Int, x: CGFloat, y: CGFloat) {
        for _ in 0...3 {
            bullet.append(SKSpriteNode.init(imageNamed: bulletName))
        }
        super.init()
        self.name = "EnemyEightWayBullet"
        if level == 1 {
            self.attack = 1
        } else if level == 2 {
            self.attack = 2
        } else if level == 3 {
            self.attack = 3
        } else if level == 4 {
            self.attack = 4
        }
        
        for i in 0...3 {
            bullet[i].size = CGSize(width: width, height: height)
            bullet[i].position = CGPoint(x: x, y: y)
            addChild(bullet[i])
            
            let frameSize = parent.frame.size
            let duration = TimeInterval(moveSpeed / frameSize.height * (frameSize.height - y))
            
            let degreeX = sin(2 * CGFloat.pi / 4 * CGFloat(i))
            let degreeY = cos(2 * CGFloat.pi / 4 * CGFloat(i))
            let moveAction = SKAction.move(to: CGPoint(x: degreeX * frameSize.width + x, y: degreeY * frameSize.height + y), duration: duration)
            
            bullet[i].run(SKAction.sequence([moveAction, SKAction.removeFromParent()]))
        }
        
        layer.addChild(self)
        self.zPosition = -1

        self.run(SKAction.wait(forDuration: TimeInterval(moveSpeed)), completion: {
            self.removeFromParent()
        })
    }
}


class EnemyEightWayBullet: SKNode {
    var bullet = [SKSpriteNode]()
    var width: CGFloat = 8
    var height: CGFloat = 8
    var moveSpeed: CGFloat = 3.0
    var bulletName: String = "FiveWayBullet"
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(parent: SKScene, layer: SKNode, level: Int, x: CGFloat, y: CGFloat) {
        for _ in 0...7 {
            bullet.append(SKSpriteNode.init(imageNamed: bulletName))
        }
        super.init()
        self.name = "EnemyEightWayBullet"
        if level == 1 {
            self.attack = 1
        } else if level == 2 {
            self.attack = 2
        } else if level == 3 {
            self.attack = 3
        } else if level == 4 {
            self.attack = 4
        }
        
        for i in 0...7 {
            bullet[i].size = CGSize(width: width, height: height)
            bullet[i].position = CGPoint(x: x, y: y)
            addChild(bullet[i])
            
            let frameSize = parent.frame.size
            let duration = TimeInterval(moveSpeed / frameSize.height * (frameSize.height - y))
            
            let degreeX = sin(2 * CGFloat.pi / 8 * CGFloat(i))
            let degreeY = cos(2 * CGFloat.pi / 8 * CGFloat(i))
            let moveAction = SKAction.move(to: CGPoint(x: degreeX * frameSize.width + x, y: degreeY * frameSize.height + y), duration: duration)
            
            bullet[i].run(SKAction.sequence([moveAction, SKAction.removeFromParent()]))
        }
        
        layer.addChild(self)
        self.zPosition = -1

        self.run(SKAction.wait(forDuration: TimeInterval(moveSpeed)), completion: {
            self.removeFromParent()
        })
    }
}

class EnemySnipeBullet: SKNode {
    var width: CGFloat = 20
    var height: CGFloat = 20
    var moveSpeed: CGFloat = 1.0
    var bulletName: String = "OscBullet"
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(parent: SKScene, layer: SKNode, target: CGPoint, level: Int, x: CGFloat, y: CGFloat) {
        let bullet = SKSpriteNode.init(imageNamed: bulletName)
        
        super.init()
        self.name = "EnemySnipeBullet"
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
        layer.addChild(self)
        self.zPosition = -1
        
        //target
        let moveAction = SKAction.move(to: target, duration: TimeInterval(moveSpeed))
        moveAction.timingMode = .easeOut
        let rotateAction = SKAction.rotate(toAngle: 8 * CGFloat.pi, duration: TimeInterval(moveSpeed))
        let action = SKAction.group([moveAction, rotateAction])
        bullet.run(SKAction.sequence([action, SKAction.removeFromParent()]))
        self.run(SKAction.wait(forDuration: TimeInterval(moveSpeed)), completion: {
            self.removeFromParent()
        })
    }
}


