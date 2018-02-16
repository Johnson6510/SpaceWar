//
//  EnemyMove.swift
//  SpaceWar
//
//  Created by 黃健偉 on 2018/2/12.
//  Copyright © 2018年 黃健偉. All rights reserved.
//

import SpriteKit

//extension SKNode {
class EnemyMove: SKAction {
    func moveDown(interval: TimeInterval, detial y: CGFloat) -> SKAction {
        let detial = CGVector(dx: 0, dy: -y)
        let action = SKAction.move(by: detial, duration: interval)
        action.timingMode = .linear
        return action
    }
    
    func moveRandom(interval: TimeInterval, detial y: CGFloat) -> (SKAction, CGFloat, CGFloat)  {
        let directX = clamp(CGFloat(arc4random_uniform(UInt32.max)) - CGFloat(UInt32.max / 2), -1, 1)
        let directY = clamp(CGFloat(arc4random_uniform(UInt32.max)) - CGFloat(UInt32.max / 2), -1, 1)
        let dy = CGFloat(arc4random_uniform(UInt32(y)) + 1) * directY
        let dx = sqrt(y * y - dy * dy) * directX
        let detial = CGVector(dx: dx, dy: dy)
        let action = SKAction.move(by: detial, duration: interval)
        action.timingMode = .easeInEaseOut
        return (action, dx, dy)
    }
    
    func moveWave(interval t: TimeInterval, detial y: CGFloat, amplitude a: CGFloat) -> SKAction {
        let action = SKAction.customAction(withDuration: t) { node, currentTime in
            let displacement = a * sin(2 * CGFloat.pi * currentTime / CGFloat(t))
            node.position.x = node.position.x + displacement
            node.position.y = node.position.y - y / CGFloat(t) * currentTime
        }
        return action
    }

    func moveSlope(interval: TimeInterval, detialX x: CGFloat, detialY y: CGFloat) -> SKAction {
        let detial = CGVector(dx: x, dy: -y)
        let angle = atan2(x, y)
        let actionRotate = SKAction.rotate(toAngle: angle, duration: 0)
        let actionMove = SKAction.move(by: detial, duration: interval)
        actionMove.timingMode = .linear
        return SKAction.sequence([actionRotate, actionMove])
    }

}

