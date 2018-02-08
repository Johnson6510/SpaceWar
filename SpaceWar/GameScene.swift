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

    private var myShip: SKNode!
    private var laserBeam: SKNode?
    private var myShipPosition = CGPoint(x: 0, y: 0)

    private var enemy = [SKNode]()
    private var enemyNo = 0

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
        
        // add space ship
        myShip = SpaceShip(x: 0, y: 0, width: shipWidth, height: shipHeight)
        myShip.position.y = self.frame.size.height * -0.3
        myShipPosition = myShip.position
        planeLayer.addChild(myShip!)
        
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
        //                    +- enemyLayer -+- enemy(random 1~14)
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
        //shootSevenWayBullets(level: 2)
        //shootLaserBeam(level: 3)
        
        shootWaveBullets(level: 4)
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
    func shootWaveBullets(level: Int) {
        let bullet = WaveBullet(level: level, x: myShipPosition.x, y: myShipPosition.y, frameHeight: self.frame.size.height)
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
        enemy.append(Enemy(x: 0, y: 0))
        enemy[enemyNo].position.x = x
        enemy[enemyNo].position.y = y
        enemy[enemyNo].serialNumber = enemyNo
        enemyLayer.addChild(enemy[enemyNo])
        enemyNo += 1
    }

    func collisionDetection() {
        for enemy in enemyLayer.children {
            for bullets in bulletLayer.children {
                for bullet in bullets.children {
                    if !enemy.children.isEmpty {
                        if (bullet.intersects(enemy.children.first!)) {
                            if enemy.defense! > (bullet.parent?.attack!)! {
                                enemy.hp! -= 1
                            } else {
                                enemy.hp! = max(0, enemy.hp! - (bullet.parent?.attack!)!)
                            }
                            if enemy.hp! == 0 {
                                let explosion = SKEmitterNode(fileNamed: "Explosion")!
                                explosion.position = enemy.position
                                gameLayer.addChild(explosion)
                                gameLayer.run(SKAction.wait(forDuration: 1)) {
                                    explosion.removeFromParent()
                                }
                                enemy.removeFromParent()
                                if bullet.parent?.name != "Laser" {
                                    bullet.removeFromParent()
                                }
                            } else {
                                let healthBar = SKSpriteNode()
                                updateHealthBar(node: healthBar, hp: enemy.hp!, maxHp: enemy.maxHp!)
                                healthBar.position.y -= (enemy.children.first?.frame.height)!
                                enemy.addChild(healthBar)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func updateHealthBar(node: SKSpriteNode, hp: Int, maxHp: Int) {
        let healthBarWidth: CGFloat = 40
        let healthBarHeight: CGFloat = 4
        let barSize = CGSize(width: healthBarWidth, height: healthBarHeight);
        
        let fillColor = UIColor(red: CGFloat(maxHp - hp) / CGFloat(maxHp), green: CGFloat(hp) / CGFloat(maxHp), blue: 0.0/255, alpha:1)
        let borderColor = UIColor(red: 35.0/255, green: 28.0/255, blue: 40.0/255, alpha:1)
        
        // create drawing context
        UIGraphicsBeginImageContextWithOptions(barSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        // draw the outline for the health bar
        borderColor.setStroke()
        let borderRect = CGRect(origin: .zero, size: barSize)
        context!.stroke(borderRect, width: 1)
        
        // draw the health bar with a colored rectangle
        fillColor.setFill()
        let barWidth = (barSize.width - 1) * CGFloat(hp) / CGFloat(maxHp)
        let barRect = CGRect(x: 0.5, y: 0.5, width: barWidth, height: barSize.height - 1)
        context!.fill(barRect)
        
        // extract image
        let spriteImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // set sprite texture and size
        node.texture = SKTexture(image: spriteImage!)
        node.size = barSize
        node.zPosition = 300
        
        let showAction = SKAction.fadeOut(withDuration: 0.5)
        node.run(SKAction.sequence([showAction, SKAction.removeFromParent()]))
    }


}

func clamp<T: Comparable>(_ value: T, _ lower: T, _ upper: T) -> T {
    return min(max(value, lower), upper)
}

extension SKNode {
    var hp: Int? {
        get {
            return userData?.value(forKey: "hp") as? Int
        }
        set(newValue) {
            if userData == nil {
                userData = NSMutableDictionary()
            }
            userData?.setValue(newValue, forKey: "hp")
        }
    }
    var maxHp: Int? {
        get {
            return userData?.value(forKey: "maxHp") as? Int
        }
        set(newValue) {
            if userData == nil {
                userData = NSMutableDictionary()
            }
            userData?.setValue(newValue, forKey: "maxHp")
        }
    }
    var attack: Int? {
        get {
            return userData?.value(forKey: "attack") as? Int
        }
        set(newValue) {
            if userData == nil {
                userData = NSMutableDictionary()
            }
            userData?.setValue(newValue, forKey: "attack")
        }
    }
    var defense: Int? {
        get {
            return userData?.value(forKey: "defense") as? Int
        }
        set(newValue) {
            if userData == nil {
                userData = NSMutableDictionary()
            }
            userData?.setValue(newValue, forKey: "defense")
        }
    }
    var serialNumber: Int? {
        get {
            return userData?.value(forKey: "serialNumber") as? Int
        }
        set(newValue) {
            if userData == nil {
                userData = NSMutableDictionary()
            }
            userData?.setValue(newValue, forKey: "serialNumber")
        }
    }
}


