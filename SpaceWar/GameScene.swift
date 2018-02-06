//
//  GameScene.swift
//  SpaceWar
//
//  Created by 黃健偉 on 2018/1/25.
//  Copyright © 2018年 黃健偉. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var starfield: SKEmitterNode!

    let gameLayer = SKNode()
    let planeLayer = SKNode()
    let enemyLayer = SKNode()
    let bulletLayer = SKNode()

    private var myShip: SKSpriteNode!
    private var laserBeam: SKNode?
    private var myShipPosition = CGPoint(x: 0, y: 0)
    
    var shipWidth: CGFloat = 70
    var shipHeight: CGFloat = 80
    
    private var move: CGPoint?

    weak var timer: Timer?

    private var bulletMoveSpeed: CGFloat = 1.0
    private var bulletReloadSpeed: TimeInterval = 0.01

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(size: CGSize) {
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0.5, y: 0.5)

        let background = SKSpriteNode(imageNamed: "background")
        background.size = size
        background.zPosition = -1
        addChild(background)

        addChild(gameLayer)
        
        let layerPosition = CGPoint(x: 0, y: 0)
        
        planeLayer.position = layerPosition
        gameLayer.addChild(planeLayer)
        
        enemyLayer.position = layerPosition
        gameLayer.addChild(enemyLayer)
        
        myShip = SKSpriteNode(imageNamed: "Spaceship")
        myShip.size = CGSize(width: shipWidth, height: shipHeight)
        myShip.position.y = self.frame.size.height * -0.3
        myShip.zPosition = 100
        myShip.physicsBody?.isDynamic = true
        myShip.physicsBody?.affectedByGravity = false
        myShip.physicsBody?.mass = 0.2
        myShipPosition = myShip.position
        planeLayer.addChild(myShip!)
        
        let propeller = SKSpriteNode(imageNamed: "PropellerFire")
        propeller.size = CGSize(width: 10, height: 30)
        propeller.position.y -= shipHeight * 0.65
        propeller.zPosition = -1
        propeller.run(SKAction.repeatForever(SKAction.sequence([SKAction.move(by: CGVector(dx: 0, dy: 5), duration: 2), SKAction.move(by: CGVector(dx: 0, dy: -5), duration: 0.5)])))
        myShip.addChild(propeller)

        planeLayer.position = layerPosition
        gameLayer.addChild(bulletLayer)

        addEnemys(x: 0, y: 0)
        addEnemys(x: 100, y: 0)
        addEnemys(x: -100, y: 0)
        
        //view -+- background
        //      +- gameLayer -+- planeLayer -+- myShip
        //                    |
        //                    +- bulletLayer -+- (shineBullets)
        //                    |               +- (classicBullets)
        //                    |               +- (laserBeam)
        //                    |
        //                    +- enemyLayer
        //                    |
        //                    +- Starfield.sks
        //                    +- Explosion.sks
        //                    +-


    }
    
    override func didMove(to view: SKView) {
        starfield = SKEmitterNode(fileNamed: "Starfield")
        starfield.position = CGPoint(x: 0, y: 1472)
        starfield.advanceSimulationTime(10)
        gameLayer.addChild(starfield)
        
        starfield.zPosition = 0
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        collisionDetection()

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        move = touches.first?.location(in: self)
        timer = Timer.scheduledTimer(timeInterval: bulletReloadSpeed, target: self, selector: #selector(shootBullets), userInfo: nil, repeats: true)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            var moveX = myShipPosition.x - ((move?.x)! - t.location(in: self).x)
            var moveY = myShipPosition.y - ((move?.y)! - t.location(in: self).y)
            
            moveX = clamp(moveX, (self.frame.size.width - shipWidth) * -0.5, (self.frame.size.width - shipWidth) * 0.5)
            moveY = clamp(moveY, (self.frame.size.height - shipHeight) * -0.5, (self.frame.size.height - shipHeight) * 0.5)

            myShipPosition = CGPoint(x: moveX, y: moveY)
            myShip.position = myShipPosition
            move = t.location(in: self)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        move = nil
        timer?.invalidate()
        
        laserBeam?.removeFromParent()
        laserBeam = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }
    
    @objc func shootBullets() {
        //shootShineBullets()
        //shootClassicBullets(level: 2)
        //shootThreeWayBullets(level: 1)
        shootSevenWayBullets(level: 2)
        //shootLaserBeam(level: 3)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
    }
    

    func shootShineBullets() {
        let width = shipWidth * 0.1
        let bullet = ShineBullet(x: myShipPosition.x, y: myShipPosition.y, width: width, height: width, frameHeight: self.frame.size.height, offset: width * 3)
        bulletLayer.addChild(bullet)
    }

    // level = 1~4
    func shootClassicBullets(level: Int) {
        let bullet = ClassicBullet(level: level, x: myShipPosition.x, y: myShipPosition.y, frameHeight: self.frame.size.height)
        bulletLayer.addChild(bullet)
    }
    
    // level = 1~4
    func shootThreeWayBullets(level: Int) {
        let bullet = ThreeWayBullet(level: level, x: myShipPosition.x, y: myShipPosition.y, frameHeight: self.frame.size.height)
        bulletLayer.addChild(bullet)
    }

    // level = 1~4
    func shootSevenWayBullets(level: Int) {
        let bullet = SevenWayBullet(level: level, x: myShipPosition.x, y: myShipPosition.y, frameHeight:  self.frame.size.height)
        bulletLayer.addChild(bullet)
    }
    
    // level = 1~4
    func shootLaserBeam(level: Int) {
        if laserBeam == nil {
            laserBeam = LaserBullet(level: level, frameHeight: self.frame.size.height)
            laserBeam?.position = myShipPosition
            bulletLayer.addChild(laserBeam!)
        } else {
            laserBeam?.position = myShipPosition
        }
    }
    
    func addEnemys(x: CGFloat, y: CGFloat) {
        let enemy = Enemy(x: x, y: y)
        enemyLayer.addChild(enemy)
    }

    func collisionDetection() {
        for enemy in enemyLayer.children {
            for bullets in bulletLayer.children {
                for bullet in bullets.children {
                    if !enemy.children.isEmpty {
                        if (bullet.intersects(enemy.children.first!)) {
                            let explosion = SKEmitterNode(fileNamed: "Explosion")!
                            explosion.position = enemy.children.first!.position
                            gameLayer.addChild(explosion)
                            gameLayer.run(SKAction.wait(forDuration: 1)) {
                                explosion.removeFromParent()
                            }
                            enemy.removeFromParent()
                            if bullet.parent?.name != "Laser" {
                                bullet.removeFromParent()
                            }
                        }
                    }
                }
            }
        }
    }

}

func clamp<T: Comparable>(_ value: T, _ lower: T, _ upper: T) -> T {
    return min(max(value, lower), upper)
}
