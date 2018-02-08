//
//  Bullets.swift
//  SpaceWar
//
//  Created by 黃健偉 on 2018/2/6.
//  Copyright © 2018年 黃健偉. All rights reserved.
//

import SpriteKit

func degreeToRadian(degree: Double!) -> CGFloat {
    return CGFloat(degree) / CGFloat(180.0 * CGFloat.pi)
}

class ShineBullet: SKNode {
    var bullet1: SKShapeNode
    var bullet2: SKShapeNode
    var x: CGFloat = 0
    var y: CGFloat = 0
    var width: CGFloat = 0
    var height: CGFloat = 0
    var moveSpeed: CGFloat = 1.0

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, frameHeight: CGFloat, offset: CGFloat) {
        bullet1 = SKShapeNode.init(rectOf: CGSize.init(width: width, height: height), cornerRadius: width * 0.3)
        bullet2 = SKShapeNode.init(rectOf: CGSize.init(width: width, height: height), cornerRadius: width * 0.3)

        super.init()
        self.name = "Shine"
        self.attack = 1

        bullet1.position = CGPoint(x: x - offset, y: y)
        bullet1.fillColor = UIColor.random()
        bullet1.glowWidth = width * 0.3
        bullet1.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 0.5)))
        addChild(bullet1)

        bullet2.position = CGPoint(x: x + offset, y: y)
        bullet2.fillColor = UIColor.random()
        bullet2.glowWidth = width * 0.3
        bullet2.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 0.5)))
        addChild(bullet2)
        
        let moveAction = SKAction.moveTo(y: frameHeight, duration: TimeInterval(moveSpeed / frameHeight * (frameHeight - y)))
        bullet1.run(SKAction.sequence([moveAction, SKAction.removeFromParent()]))
        bullet2.run(SKAction.sequence([moveAction, SKAction.removeFromParent()]))
    }    
}

class ClassicBullet: SKNode {
    var bullet: SKSpriteNode
    var x: CGFloat = 0
    var y: CGFloat = 0
    var width: CGFloat = 0
    var height: CGFloat = 0
    var moveSpeed: CGFloat = 1.0
    var bulletName: String = "ClassicBulletLv1"

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(level: Int, x: CGFloat, y: CGFloat, frameHeight: CGFloat) {
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

        let moveAction = SKAction.moveTo(y: frameHeight, duration: TimeInterval(moveSpeed / frameHeight * (frameHeight - y)))
        bullet.run(SKAction.sequence([moveAction, SKAction.removeFromParent()]))
    }
}

class WaveBullet: SKNode {
    var bullet1: SKSpriteNode
    var bullet2: SKSpriteNode
    var bullet3: SKSpriteNode
    var x: CGFloat = 0
    var y: CGFloat = 0
    var width: CGFloat = 10
    var height: CGFloat = 10
    var moveSpeed: CGFloat = 1.0
    var amplitude: CGFloat = 0
    var bulletName: String = "GreenBullet"
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(level: Int, x: CGFloat, y: CGFloat, frameHeight: CGFloat) {
        if level == 1 {
            amplitude = 20
        } else if level == 2 {
            amplitude = 40
        } else if level == 3 {
            amplitude = 60
        } else if level == 4 {
            amplitude = 80
        }
        bullet1 = SKSpriteNode.init(imageNamed: bulletName)
        bullet2 = SKSpriteNode.init(imageNamed: bulletName)
        bullet3 = SKSpriteNode.init(imageNamed: bulletName)

        super.init()
        self.name = "Wave"
        if level == 1 {
            self.attack = 3
        } else if level == 2 {
            self.attack = 6
        } else if level == 3 {
            self.attack = 9
        } else if level == 4 {
            self.attack = 12
        }

        bullet1.size = CGSize(width: width, height: height)
        bullet2.size = CGSize(width: width, height: height)
        bullet3.size = CGSize(width: width, height: height)
        bullet1.position = CGPoint(x: x, y: y)
        bullet2.position = CGPoint(x: x, y: y)
        bullet3.position = CGPoint(x: x, y: y)
        addChild(bullet1)
        addChild(bullet2)
        addChild(bullet3)

        let oscillate1 = SKAction.oscillation1(amplitude: amplitude,
                                               timePeriod: Double(moveSpeed),
                                             midPoint: bullet1.position)
        let oscillate2 = SKAction.oscillation2(amplitude: amplitude,
                                               timePeriod: Double(moveSpeed),
                                               midPoint: bullet2.position)
        let moveAction = SKAction.moveTo(y: frameHeight, duration: TimeInterval(moveSpeed / frameHeight * (frameHeight - y)))

        bullet1.run(SKAction.sequence([SKAction.group([oscillate1, moveAction]), SKAction.removeFromParent()]))
        bullet2.run(SKAction.sequence([SKAction.group([oscillate2, moveAction]), SKAction.removeFromParent()]))
        bullet3.run(SKAction.sequence([SKAction.group([moveAction]), SKAction.removeFromParent()]))
    }
}

class ThreeWayBullet: SKNode {
    var bullet1: SKSpriteNode
    var bullet2: SKSpriteNode
    var bullet3: SKSpriteNode
    var x: CGFloat = 0
    var y: CGFloat = 0
    var width: CGFloat = 6
    var height: CGFloat = 0
    var moveSpeed: CGFloat = 1.0
    var bulletName: String = "ThreeWayLv1"
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(level: Int, x: CGFloat, y: CGFloat, frameHeight: CGFloat) {
        if level == 1 {
            height = 10
        } else if level == 2 {
            height = 13.75
        } else if level == 3 {
            height = 17.5
        } else if level == 4 {
            height = 21.25
        }
        bulletName = "ThreeWayLv" + String(level)
        bullet1 = SKSpriteNode.init(imageNamed: bulletName)
        bullet2 = SKSpriteNode.init(imageNamed: bulletName)
        bullet3 = SKSpriteNode.init(imageNamed: bulletName)

        super.init()
        self.name = "ThreeWay"
        if level == 1 {
            self.attack = 2
        } else if level == 2 {
            self.attack = 4
        } else if level == 3 {
            self.attack = 6
        } else if level == 4 {
            self.attack = 8
        }

        //left
        bullet1.size = CGSize(width: width, height: height)
        bullet1.position = CGPoint(x: x, y: y)
        bullet1.zRotation = degreeToRadian(degree: 60)
        addChild(bullet1)
        
        //center
        bullet2.size = CGSize(width: width, height: height)
        bullet2.position = CGPoint(x: x, y: y)
        addChild(bullet2)

        //right
        bullet3.size = CGSize(width: width, height: height)
        bullet3.position = CGPoint(x: x, y: y)
        bullet3.zRotation = degreeToRadian(degree: -60)
        addChild(bullet3)
        
        let moveAction1 = SKAction.move(to: CGPoint(x: tan(-60) * frameHeight, y: frameHeight), duration: TimeInterval(moveSpeed / frameHeight * (frameHeight - y)))
        let moveAction2 = SKAction.moveTo(y: frameHeight, duration: TimeInterval(moveSpeed / frameHeight * (frameHeight - y)))
        let moveAction3 = SKAction.move(to: CGPoint(x: tan(60) * frameHeight, y: frameHeight), duration: TimeInterval(moveSpeed / frameHeight * (frameHeight - y)))
        bullet1.run(SKAction.sequence([moveAction1, SKAction.removeFromParent()]))
        bullet2.run(SKAction.sequence([moveAction2, SKAction.removeFromParent()]))
        bullet3.run(SKAction.sequence([moveAction3, SKAction.removeFromParent()]))
    }
}

class SevenWayBullet: SKNode {
    var bullet = [SKSpriteNode]()
    var x: CGFloat = 0
    var y: CGFloat = 0
    var width: CGFloat = 8
    var height: CGFloat = 8
    var moveSpeed: CGFloat = 1.0
    var bulletName: String = "FiveWayBullet"
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(level: Int, x: CGFloat, y: CGFloat, frameHeight: CGFloat) {
        for _ in 0...(level * 2 - 1) {
            bullet.append(SKSpriteNode.init(imageNamed: bulletName))
        }
        super.init()
        self.name = "SevenWay"
        if level == 1 {
            self.attack = 1
        } else if level == 2 {
            self.attack = 2
        } else if level == 3 {
            self.attack = 3
        } else if level == 4 {
            self.attack = 4
        }

        for i in 0..<(level * 2 - 1) {
            bullet[i].size = CGSize(width: width, height: height)
            bullet[i].position = CGPoint(x: x, y: y)
            addChild(bullet[i])

            var moveAction = SKAction()
            if i == 0 { // 0
                moveAction = SKAction.moveTo(y: frameHeight, duration: TimeInterval(moveSpeed / frameHeight * (frameHeight - y)))
            } else if i % 2 == 1 { // 1, 3, 5
                let degree = Double((i / 2 + 1) * 6)
                moveAction = SKAction.move(to: CGPoint(x: CGFloat(tan(degree)) * frameHeight, y: frameHeight), duration: TimeInterval(moveSpeed / frameHeight * (frameHeight - y)))
            } else if i % 2 == 0 { // 2, 4, 6
                let degree = Double((i / 2) * 6)
                moveAction = SKAction.move(to: CGPoint(x: CGFloat(tan(degree * -1)) * frameHeight, y: frameHeight), duration: TimeInterval(moveSpeed / frameHeight * (frameHeight - y)))
            }
            bullet[i].run(SKAction.sequence([moveAction, SKAction.removeFromParent()]))
        }
    }
}

class LaserBullet: SKNode {
    var bullet: SKShapeNode
    var maxY: CGFloat = 0
    var laserColor: UIColor = UIColor(red: 204/255, green: 255/255, blue: 255/255, alpha:0.8)

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(level: Int, frameHeight: CGFloat) {
        bullet = SKShapeNode()

        super.init()
        self.name = "Laser"
        if level == 1 {
            self.attack = 20
        } else if level == 2 {
            self.attack = 40
        } else if level == 3 {
            self.attack = 60
        } else if level == 4 {
            self.attack = 80
        }

        bullet.lineWidth = 1
        bullet.glowWidth = CGFloat(level * 2)
        bullet.strokeColor = laserColor

        let path = CGMutablePath()
        let rayEnd = CGPoint(x: 0, y: 0)
        let rayStart = CGPoint(x: 0, y: frameHeight)

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

extension SKAction {
    // amplitude  - the amount the height will vary by, set this to 200 in your case.
    // timePeriod - the time it takes for one complete cycle
    // midPoint   - the point around which the oscillation occurs.
    static func oscillation1(amplitude a: CGFloat, timePeriod t: Double, midPoint: CGPoint) -> SKAction {
        let action = SKAction.customAction(withDuration: t) { node, currentTime in
            let displacement = a * sin(3 * CGFloat.pi * currentTime / CGFloat(t))
            node.position.x = midPoint.x + displacement
        }
        return action
    }
    
    static func oscillation2(amplitude a: CGFloat, timePeriod t: Double, midPoint: CGPoint) -> SKAction {
        let action = SKAction.customAction(withDuration: t) { node, currentTime in
            let displacement = a * sin(3 * CGFloat.pi * currentTime / CGFloat(t))
            node.position.x = midPoint.x - displacement
        }
        return action
    }

}


