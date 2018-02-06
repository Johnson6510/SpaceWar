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
    
    //private var spinnyNode: SKShapeNode?
    private var starfield: SKEmitterNode!

    let gameLayer = SKNode()
    let planeLayer = SKNode()
    let enemyLayer = SKNode()
    let bulletLayer = SKNode()

    private var myShip: SKSpriteNode!
    private var myShipPosition = CGPoint(x: 0, y: 0)
    
    var shipWidth: CGFloat = 70
    var shipHeight: CGFloat = 80
    
    private var move: CGPoint?

    weak var timer: Timer?
    var isTouch: Bool = false

    private var bulletMoveSpeed: CGFloat = 10
    private var bulletReloadSpeed: TimeInterval = 0.1

    var laserBeam: LaserBullet!
    var isLaserBeamEnable: Bool = true

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
        myShipPosition = myShip.position
        planeLayer.addChild(myShip!)
        
        let propeller = SKSpriteNode(imageNamed: "PropellerFire")
        propeller.size = CGSize(width: 10, height: 30)
        propeller.position.y -= shipHeight * 0.65
        propeller.zPosition = -1
        propeller.run(SKAction.repeatForever(SKAction.sequence([SKAction.move(by: CGVector(dx: 0, dy: 5), duration: 2), SKAction.move(by: CGVector(dx: 0, dy: -5), duration: 0.5)])))
        myShip.addChild(propeller)
        /*
        var points = [CGPoint(x: shipHeight * -0.07, y: shipHeight * 0.1), CGPoint(x: 0.0, y: shipHeight * -0.1), CGPoint(x: shipHeight * 0.07, y: shipHeight * 0.1)]
        let propeller = SKShapeNode(points: &points, count: points.count)
        propeller.fillColor = UIColor(red: 255/255, green: 209/255, blue: 163/255, alpha:0.8)
        propeller.position.y -= shipHeight * 0.5
        propeller.alpha = 0.8
        propeller.zPosition = -5
        myShip.addChild(propeller)

        var points2 = [CGPoint(x: shipHeight * -0.15, y: shipHeight * 0.25), CGPoint(x: 0.0, y: shipHeight * -0.25), CGPoint(x: shipHeight * 0.15, y: shipHeight * 0.25)]
        let propeller2 = SKShapeNode(points: &points2, count: points2.count)
        propeller2.fillColor = UIColor(red: 205/255, green: 255/255, blue: 255/255, alpha:0.8)
        propeller2.position.y -= shipHeight * 0.45
        propeller2.alpha = 0.5
        propeller.zPosition = -10
        myShip.addChild(propeller2)
        */

        planeLayer.position = layerPosition
        gameLayer.addChild(bulletLayer)

        timer = Timer.scheduledTimer(timeInterval: bulletReloadSpeed, target: self, selector: #selector(shootBullets), userInfo: nil, repeats: true)

        createLaserBullets()
        
        //view -+- background
        //      +- gameLayer -+- planeLayer -+- myShip
        //                    |
        //                    +- bulletLayer -+-  -+-
        //                    |             +-  -+-
        //                    |
        //                    +-
        //                    +-
        //                    |
        //                    +-
        //                    +-
        //                    +-  -+-


    }
    
    override func didMove(to view: SKView) {
        starfield = SKEmitterNode(fileNamed: "Starfield")
        starfield.position = CGPoint(x: 0, y: 1472)
        starfield.advanceSimulationTime(10)
        self.addChild(starfield)
        
        starfield.zPosition = 0
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        for bullet in bulletLayer.children {
            if bullet != laserBeam {
                if bullet.position.y < self.frame.size.height {
                    bullet.position = CGPoint(x: bullet.position.x, y: bullet.position.y + bulletMoveSpeed)
                } else {
                    bullet.removeFromParent()
                }
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        move = touches.first?.location(in: self)
        isTouch = true
        if isLaserBeamEnable {
            laserBeam.position = myShipPosition
            laserBeam.isHidden = false
        }
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
            if isLaserBeamEnable {
                laserBeam.position = myShipPosition
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        move = nil
        isTouch = false
        if isLaserBeamEnable {
            laserBeam.isHidden = true
        }

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }
    
    @objc func shootBullets() {
        if isTouch {
            //shootShineBullets()
            //shootClassicBullets(level: 2)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
    }
    

    func shootShineBullets() {
        let w = shipWidth * 0.1
        let bullet1 = ShineBullet(x: myShipPosition.x-shipWidth*0.3, y: myShipPosition.y, width: w, height: w)
        let bullet2 = ShineBullet(x: myShipPosition.x+shipWidth*0.3, y: myShipPosition.y, width: w, height: w)
        bulletLayer.addChild(bullet1)
        bulletLayer.addChild(bullet2)
    }

    func shootClassicBullets(level: Int) {
        let bullet = ClassicBullet(level: level, x: myShipPosition.x, y: myShipPosition.y)
        bulletLayer.addChild(bullet)
    }

    func createLaserBullets() {
        laserBeam = LaserBullet(x: myShipPosition.x, y: 0, maxY: CGFloat(self.frame.size.height))
        bulletLayer.addChild(laserBeam)
        laserBeam.isHidden = true
    }
    
}

func clamp<T: Comparable>(_ value: T, _ lower: T, _ upper: T) -> T {
    return min(max(value, lower), upper)
}
