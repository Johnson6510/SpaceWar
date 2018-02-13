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
    let bulletLayer = SKNode()
    let enemyLayer = SKNode()
    let enemyBulletLayer = SKNode()

    private var myShip: SKNode!
    private var laserBeam: SKNode?
    private var myShipPosition = CGPoint(x: 0, y: 0)

    private var enemy = [SKNode]()
    private var enemyNo = 0
    private var enemyMove = EnemyMove()

    var shipWidth: CGFloat = 70
    var shipHeight: CGFloat = 80
    
    private var move: CGPoint?

    let timerManager = TimerManager()
    var planeTimer: Int?
    var enemyTimer: Int?

    private var bulletReloadSpeed: TimeInterval = 0.01
    private var enemyInterval: TimeInterval = 1.0

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
        myShipPosition = CGPoint(x: 0, y: self.frame.size.height * -0.3)
        let shipSize = CGSize(width: shipWidth, height: shipHeight)
        myShip = SpaceShip(position: myShipPosition, size: shipSize)
        planeLayer.addChild(myShip!)
        
        planeLayer.position = layerPosition
        gameLayer.addChild(bulletLayer)
        gameLayer.addChild(enemyBulletLayer)
        
        addEnemys()
        enemyTimer = timerManager.startTimer(interval: enemyInterval, target: self, selector: #selector(enemyMoveAtcion))
        

        addEnemys()
        addEnemys()

        //view -+- background
        //      +- gameLayer -+- planeLayer -+- myShip
        //                    |
        //                    +- bulletLayer -+- (shineBullets)
        //                    |               +- (classicBullets)
        //                    |               +- (laserBeam)
        //                    |
        //                    +- enemyLayer -+- enemy(random 1~14)
        //                    |
        //                    +- enemyBulletLayer -+- enemy(random 1~14)
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
        planeTimer = timerManager.startTimer(interval: bulletReloadSpeed, target: self, selector: #selector(shootBullets))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            var moveX = myShipPosition.x - ((move?.x)! - t.location(in: self).x)
            var moveY = myShipPosition.y - ((move?.y)! - t.location(in: self).y)
            
            moveX = clamp(moveX, self.frame.size.width * -0.5, self.frame.size.width * 0.5)
            moveY = clamp(moveY, self.frame.size.height * -0.5, self.frame.size.height * 0.5)

            myShipPosition = CGPoint(x: moveX, y: moveY)
            myShip.position = myShipPosition
            move = t.location(in: self)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        move = nil
        timerManager.stopTimer(id: planeTimer!)
        
        laserBeam?.removeFromParent()
        laserBeam = nil
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }
    
    @objc func shootBullets() {
        //shootShineBullets(level: 4)
        //shootClassicBullets(level: 2)
        shootThreeWayBullets(level: 1)
        //shootSevenWayBullets(level: 4)
        //shootLaserBeam(level: 3)
        //shootWaveBullets(level: 4)
    }
    
    func shootShineBullets(level: Int) {
        let bullet = ShineBullet(parent: self, level: level, x: myShipPosition.x, y: myShipPosition.y)
        bulletLayer.addChild(bullet)
    }

    // level = 1~4
    func shootClassicBullets(level: Int) {
        let bullet = ClassicBullet(parent: self, level: level, x: myShipPosition.x, y: myShipPosition.y)
        bulletLayer.addChild(bullet)
    }
    
    // level = 1~4
    func shootWaveBullets(level: Int) {
        let bullet = WaveBullet(parent: self, level: level, x: myShipPosition.x, y: myShipPosition.y)
        bulletLayer.addChild(bullet)
    }

    // level = 1~4
    func shootThreeWayBullets(level: Int) {
        let bullet = ThreeWayBullet(parent: self, level: level, x: myShipPosition.x, y: myShipPosition.y)
        bulletLayer.addChild(bullet)
    }

    // level = 1~4
    func shootSevenWayBullets(level: Int) {
        let bullet = SevenWayBullet(parent: self, level: level, x: myShipPosition.x, y: myShipPosition.y)
        bulletLayer.addChild(bullet)
    }
    
    // level = 1~4
    func shootLaserBeam(level: Int) {
        if laserBeam == nil {
            laserBeam = LaserBullet(parent: self, level: level)
            laserBeam?.position = myShipPosition
            bulletLayer.addChild(laserBeam!)
        } else {
            laserBeam?.position = myShipPosition
        }
    }
    
    func addEnemys() {
        let tempEnemy = Enemy()
        randomPosition(node: tempEnemy)
        enemy.append(tempEnemy)
        enemy[enemyNo].serialNumber = enemyNo
        enemyLayer.addChild(enemy[enemyNo])
        enemyNo += 1
    }
    
    func randomPosition(node: SKNode) {
        var isOverlape = false
        repeat {
            isOverlape = false
            node.position = CGPoint(x: CGFloat(arc4random_uniform(UInt32(size.width/2))) - size.width/2, y: size.height/2)
            for enemy in enemyLayer.children {
                if !enemy.children.isEmpty {
                    if (enemy.children.first?.intersects(node.children.first!))! {
                        isOverlape = true
                    }
                }
            }
        } while isOverlape
    }
    
    @objc func enemyMoveAtcion(_ sender: SKNode) {
        for enemy in enemyLayer.children {
            if !enemy.children.isEmpty {
                switch(enemy.moveMode) {
                case .down?:
                    enemyMoveDown(enemy: enemy)
                case .unstable?:
                    enemyMoveRandom(enemy: enemy)
                case .wave?:
                    enemyMoveWave(enemy: enemy)
                default:
                    break
                }
                shootEnemyLinnerBullets(enemy: enemy, level: 1)
            }
        }
    }
    
    func enemyMoveDown(enemy: SKNode) {
        enemy.run(enemyMove.moveDown(interval: enemyInterval, detial: 50))
    }
    
    func enemyMoveRandom(enemy: SKNode) {
        var (action, dx, dy) = (SKAction(), CGFloat(), CGFloat())
        repeat {
            (action, dx, dy) = enemyMove.moveRandom(interval: enemyInterval, detial: 100)
        } while enemy.position.x + dx > size.width / 2 || enemy.position.x + dx < size.width / -2 || enemy.position.y + dy > size.height / 2 || enemy.position.y + dy < size.height / -2
        enemy.run(action)
    }
    
    func enemyMoveWave(enemy: SKNode) {
        enemy.run(enemyMove.moveWave(interval: enemyInterval, detial: 3, amplitude: 10))
    }
    
    // level = 1~4
    func shootEnemyLinnerBullets(enemy: SKNode, level: Int) {
        let bullet = EnemyLinnerBullet(parent: self, level: level, x: enemy.position.x, y: enemy.position.y)
        bullet.zPosition = -1
        enemyBulletLayer.addChild(bullet)
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
                            } else {
                                if bullet.parent?.name != "Laser" {
                                    bullet.removeFromParent()
                                }
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
        
        let fillColor = UIColor(red: CGFloat(maxHp - hp) / CGFloat(maxHp), green: CGFloat(hp) / CGFloat(maxHp), blue: 0.0/255, alpha: 1)
        let borderColor = UIColor(red: 35.0/255, green: 28.0/255, blue: 40.0/255, alpha: 1)
        
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
        
        let showAction = SKAction.fadeOut(withDuration: 1.0)
        node.run(SKAction.sequence([showAction, SKAction.removeFromParent()]))
    }


}



