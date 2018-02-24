//
//  SpaceShip.swift
//  SpaceWar
//
//  Created by 黃健偉 on 2018/2/8.
//  Copyright © 2018年 黃健偉. All rights reserved.
//

import SpriteKit

class SpaceShip: SKNode {
    var ship: SKSpriteNode
    var propeller: SKSpriteNode
    var smoke: SKEmitterNode

    var shipName: String = "Spaceship"
    var propellerName: String = "fire"
    var shipMaxHp = 1000

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(position: CGPoint, size: CGSize) {
        ship = SKSpriteNode.init(imageNamed: shipName)
        propeller = SKSpriteNode(imageNamed: propellerName)
        smoke = SKEmitterNode(fileNamed: "Smoke")!
        super.init()
        self.name = "Ship"
        self.hp = shipMaxHp
        self.maxHp = shipMaxHp
        self.position = position
        self.defense = 100

        ship.size = size
        ship.zPosition = 100
        ship.physicsBody?.isDynamic = true
        ship.physicsBody?.affectedByGravity = false
        ship.physicsBody?.mass = 0.2
        addChild(ship)
        
        propeller.size = CGSize(width: 10, height: 30)
        propeller.position.y -= size.height * 0.63
        propeller.zPosition = -1
        propeller.run(SKAction.repeatForever(SKAction.sequence([SKAction.move(by: CGVector(dx: 0, dy: 5), duration: 2), SKAction.move(by: CGVector(dx: 0, dy: -5), duration: 0.5)])))
        ship.addChild(propeller)
        
        smoke.position = CGPoint(x: 0, y: -size.height * 0.75)
        ship.addChild(smoke)
        smoke.zPosition = -2
    }
}


