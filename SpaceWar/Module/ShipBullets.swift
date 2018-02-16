//
//  Bullets.swift
//  SpaceWar
//
//  Created by 黃健偉 on 2018/2/6.
//  Copyright © 2018年 黃健偉. All rights reserved.
//

import SpriteKit

class ShineBullet: SKNode {
    var width: CGFloat = 0
    var moveSpeed: CGFloat = 1.0

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var bgHeight:CGFloat = 0
    
    init(parent: SKScene, layer: SKNode, level: Int, x: CGFloat, y: CGFloat) {
        if level == 1 {
            width = 7
        } else if level == 2 {
            width = 9
        } else if level == 3 {
            width = 11
        } else if level == 4 {
            width = 13
        }
        let bullet1 = SKShapeNode.init(rectOf: CGSize.init(width: width, height: width), cornerRadius: width * 0.3)
        let bullet2 = SKShapeNode.init(rectOf: CGSize.init(width: width, height: width), cornerRadius: width * 0.3)

        super.init()
        self.name = "ShineBullet"
        if level == 1 {
            self.attack = 50
        } else if level == 2 {
            self.attack = 60
        } else if level == 3 {
            self.attack = 70
        } else if level == 4 {
            self.attack = 80
        }

        bullet1.position = CGPoint(x: x - width, y: y)
        bullet1.fillColor = UIColor.random()
        bullet1.glowWidth = width * 0.3
        bullet1.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(2 * Double.pi), duration: 0.5)))
        addChild(bullet1)

        bullet2.position = CGPoint(x: x + width, y: y)
        bullet2.fillColor = UIColor.random()
        bullet2.glowWidth = width * 0.3
        bullet2.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(2 * Double.pi), duration: 0.5)))
        addChild(bullet2)
        
        layer.addChild(self)
        
        let frameHeight = parent.frame.size.height
        let moveAction = SKAction.moveTo(y: frameHeight, duration: TimeInterval(moveSpeed / frameHeight * (frameHeight - y)))
        bullet1.run(SKAction.sequence([moveAction, SKAction.removeFromParent()]))
        bullet2.run(SKAction.sequence([moveAction, SKAction.removeFromParent()]))
        self.run(SKAction.wait(forDuration: TimeInterval(moveSpeed)), completion: {
            self.removeFromParent()
        })
    }
}

class Missile: SKNode {
    var width: CGFloat = 8
    var height: CGFloat = 16
    var moveSpeed: CGFloat = 0.5
    var bulletName: String = "missile"

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var bgHeight:CGFloat = 0
    
    init(parent: SKScene, layer: SKNode, level: Int, x: CGFloat, y: CGFloat) {
        let bullet1 = SKSpriteNode.init(imageNamed: bulletName)
        let bullet2 = SKSpriteNode.init(imageNamed: bulletName)

        super.init()
        self.name = "Missile"
        if level == 1 {
            self.attack = 100
            width = 8
            height = 16
        } else if level == 2 {
            self.attack = 150
            width = 10
            height = 20
        } else if level == 3 {
            self.attack = 200
            width = 12
            height = 24
        } else if level == 4 {
            self.attack = 250
            width = 14
            height = 28
        }
        
        bullet1.position = CGPoint(x: x - 25, y: y)
        bullet1.size = CGSize(width: width, height: height)
        addChild(bullet1)
        
        bullet2.position = CGPoint(x: x + 25, y: y)
        bullet2.size = CGSize(width: width, height: height)
        addChild(bullet2)
        
        layer.addChild(self)
        
        let frameHeight = parent.frame.size.height
        let moveAction = SKAction.moveTo(y: frameHeight, duration: TimeInterval(moveSpeed / frameHeight * (frameHeight - y)))
        bullet1.run(SKAction.sequence([moveAction, SKAction.removeFromParent()]))
        bullet2.run(SKAction.sequence([moveAction, SKAction.removeFromParent()]))
        self.run(SKAction.wait(forDuration: TimeInterval(moveSpeed)), completion: {
            self.removeFromParent()
        })
    }
}

class ClassicBullet: SKNode {
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
        self.name = "ClassicBullet"
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

        let frameHeight = parent.frame.size.height
        let moveAction = SKAction.moveTo(y: frameHeight, duration: TimeInterval(moveSpeed / frameHeight * (frameHeight - y)))
        bullet.run(SKAction.sequence([moveAction, SKAction.removeFromParent()]))
        self.run(SKAction.wait(forDuration: TimeInterval(moveSpeed)), completion: {
            self.removeFromParent()
        })
    }
}

class WaveBullet: SKNode {
    var width: CGFloat = 10
    var height: CGFloat = 10
    var moveSpeed: CGFloat = 1.0
    var amplitude: CGFloat = 0
    var bulletName: String = "GreenBullet"
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(parent: SKScene, layer: SKNode, level: Int, x: CGFloat, y: CGFloat) {
        if level == 1 {
            amplitude = 20
        } else if level == 2 {
            amplitude = 40
        } else if level == 3 {
            amplitude = 60
        } else if level == 4 {
            amplitude = 80
        }
        let bullet1 = SKSpriteNode.init(imageNamed: bulletName)
        let bullet2 = SKSpriteNode.init(imageNamed: bulletName)
        let bullet3 = SKSpriteNode.init(imageNamed: bulletName)

        super.init()
        self.name = "WaveBullet"
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

        layer.addChild(self)
        
        let oscillate1 = SKAction.oscillation1(amplitude: amplitude,
                                               timePeriod: Double(moveSpeed),
                                             midPoint: bullet1.position)
        let oscillate2 = SKAction.oscillation2(amplitude: amplitude,
                                               timePeriod: Double(moveSpeed),
                                               midPoint: bullet2.position)
        let frameHeight = parent.frame.size.height
        let moveAction = SKAction.moveTo(y: frameHeight, duration: TimeInterval(moveSpeed / frameHeight * (frameHeight - y)))

        bullet1.run(SKAction.sequence([SKAction.group([oscillate1, moveAction]), SKAction.removeFromParent()]))
        bullet2.run(SKAction.sequence([SKAction.group([oscillate2, moveAction]), SKAction.removeFromParent()]))
        bullet3.run(SKAction.sequence([SKAction.group([moveAction]), SKAction.removeFromParent()]))
        self.run(SKAction.wait(forDuration: TimeInterval(moveSpeed)), completion: {
            self.removeFromParent()
        })
    }
}

class ThreeWayBullet: SKNode {
    var width: CGFloat = 6
    var height: CGFloat = 0
    var moveSpeed: CGFloat = 1.0
    var bulletName: String = "ThreeWayLv1"
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(parent: SKScene, layer: SKNode, level: Int, x: CGFloat, y: CGFloat) {
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
        let bullet1 = SKSpriteNode.init(imageNamed: bulletName)
        let bullet2 = SKSpriteNode.init(imageNamed: bulletName)
        let bullet3 = SKSpriteNode.init(imageNamed: bulletName)

        super.init()
        self.name = "ThreeWayBullet"
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
        bullet1.zRotation = degreeToRadian(degree: 15)
        addChild(bullet1)
        
        //center
        bullet2.size = CGSize(width: width, height: height)
        bullet2.position = CGPoint(x: x, y: y)
        addChild(bullet2)

        //right
        bullet3.size = CGSize(width: width, height: height)
        bullet3.position = CGPoint(x: x, y: y)
        bullet3.zRotation = degreeToRadian(degree: -15)
        addChild(bullet3)

        layer.addChild(self)
        
        let frameSize = parent.frame.size
        let duration = TimeInterval(moveSpeed / frameSize.height * (frameSize.height - y))
        let degree = CGFloat.pi * 15 / 180
        let moveAction1 = SKAction.move(to: CGPoint(x: -degree * frameSize.width + x, y: frameSize.height + y), duration: duration)
        let moveAction2 = SKAction.moveTo(y: frameSize.height + y, duration: duration)
        let moveAction3 = SKAction.move(to: CGPoint(x: degree * frameSize.width + x, y: frameSize.height + y), duration: duration)
        bullet1.run(SKAction.sequence([moveAction1, SKAction.removeFromParent()]))
        bullet2.run(SKAction.sequence([moveAction2, SKAction.removeFromParent()]))
        bullet3.run(SKAction.sequence([moveAction3, SKAction.removeFromParent()]))
        self.run(SKAction.wait(forDuration: TimeInterval(moveSpeed)), completion: {
            self.removeFromParent()
        })
    }
}

class SevenWayBullet: SKNode {
    var bullet = [SKSpriteNode]()
    var width: CGFloat = 8
    var height: CGFloat = 8
    var moveSpeed: CGFloat = 1.0
    var bulletName: String = "FiveWayBullet"
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(parent: SKScene, layer: SKNode, level: Int, x: CGFloat, y: CGFloat) {
        for _ in 0...(level * 2 - 1) {
            bullet.append(SKSpriteNode.init(imageNamed: bulletName))
        }
        super.init()
        self.name = "SevenWayBullet"
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

            let frameSize = parent.frame.size
            let duration = TimeInterval(moveSpeed / frameSize.height * (frameSize.height - y))
            var moveAction = SKAction()
            if i == 0 { // 0
                moveAction = SKAction.moveTo(y: frameSize.height + y, duration: duration)
            } else if i % 2 == 1 { // 1, 3, 5
                let degree = -CGFloat.pi * CGFloat((i + 1) / 2) / 30
                moveAction = SKAction.move(to: CGPoint(x: degree * frameSize.width + x, y: frameSize.height + y), duration: duration)
            } else if i % 2 == 0 { // 2, 4, 6
                let degree = CGFloat.pi * CGFloat(i / 2) / 30
                moveAction = SKAction.move(to: CGPoint(x: degree * frameSize.width + x, y: frameSize.height + y), duration: duration)
            }
            bullet[i].run(SKAction.sequence([moveAction, SKAction.removeFromParent()]))
        }
        
        layer.addChild(self)
        self.run(SKAction.wait(forDuration: TimeInterval(moveSpeed)), completion: {
            self.removeFromParent()
        })
    }
}

class SequenceBullet: SKNode {
    var width: CGFloat = 9
    var height: CGFloat = 54
    var moveSpeed: CGFloat = 1.0
    var bulletName: String = "laserBlue01"
    var sequenceCount: Int = 0
    var frameHeight: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(parent: SKScene, layer: SKNode) {
        super.init()
        self.name = "SequenceBullet"
        layer.addChild(self)
        frameHeight = parent.frame.size.height
    }
    
    func shoot(level: Int, x: CGFloat, y: CGFloat) {
        if level == 1 {
            self.attack = 15
        } else if level == 2 {
            self.attack = 30
        } else if level == 3 {
            self.attack = 45
        } else if level == 4 {
            self.attack = 60
        }
        
        var shift: CGFloat = 0
        if sequenceCount == 0 || sequenceCount == 6 {
            shift = 45
        } else if sequenceCount == 1 || sequenceCount == 5 || sequenceCount == 7 || sequenceCount == 11 {
            shift = 30
        } else if sequenceCount == 2 || sequenceCount == 4 || sequenceCount == 8 || sequenceCount == 10 {
            shift = 15
        } else if sequenceCount == 3 || sequenceCount == 9 {
            shift = 0
        }
        if sequenceCount < 3 || sequenceCount > 9 {
            shift = -shift
        }
        let bullet = SKSpriteNode.init(imageNamed: bulletName)
        bullet.alpha = 0.8
        bullet.position = CGPoint(x: x + shift, y: y)
        addChild(bullet)

        let moveAction = SKAction.moveTo(y: frameHeight, duration: TimeInterval(moveSpeed))
        bullet.run(SKAction.sequence([moveAction, SKAction.removeFromParent()]))

        sequenceCount += 1
        if sequenceCount == 12 {
            sequenceCount = 0
        }
    }

}

class MatrixBullet: SKNode {
    var bullet = [SKSpriteNode]()
    var width: CGFloat = 4.5
    var height: CGFloat = 28.5
    var moveSpeed: CGFloat = 0.8
    var bulletName: String = "laserRed13"
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(parent: SKScene, layer: SKNode, level: Int, x: CGFloat, y: CGFloat) {
        for _ in 0...(level * 2 - 1) {
            bullet.append(SKSpriteNode.init(imageNamed: bulletName))
        }
        super.init()
        self.name = "MatrixBullet"
        if level == 1 {
            self.attack = 20
        } else if level == 2 {
            self.attack = 30
        } else if level == 3 {
            self.attack = 40
        } else if level == 4 {
            self.attack = 50
        }
        for i in 0..<(level * 2 - 1) {
            bullet[i].size = CGSize(width: width, height: height)
            let offsetX = CGFloat((i + 1) * 10 - level *  10)
            var offserY: CGFloat = 0
            offserY = CGFloat(-5 * max(i - (level - 1), (level - 1) - i))
            bullet[i].position = CGPoint(x: x + offsetX, y: y + offserY)
            addChild(bullet[i])
            
            let frameSize = parent.frame.size
            let moveAction = SKAction.move(to: CGPoint(x: x + offsetX, y: frameSize.height + offserY), duration: TimeInterval(moveSpeed))
            bullet[i].run(SKAction.sequence([moveAction, SKAction.removeFromParent()]))
        }
        
        layer.addChild(self)
        self.run(SKAction.wait(forDuration: TimeInterval(moveSpeed)), completion: {
            self.removeFromParent()
        })
    }
}

class LaserBullet: SKNode {
    var maxY: CGFloat = 0
    var laserColor: UIColor = UIColor(red: 204/255, green: 255/255, blue: 255/255, alpha:0.8)

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(parent: SKScene, level: Int) {
        let bullet = SKShapeNode()

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

        let frameHeight = parent.frame.size.height
        let path = CGMutablePath()
        let rayEnd = CGPoint(x: 0, y: 0)
        let rayStart = CGPoint(x: 0, y: frameHeight)

        path.move(to: rayStart)
        path.addLine(to: rayEnd)
        bullet.path = path
    
        addChild(bullet)
    }
}



