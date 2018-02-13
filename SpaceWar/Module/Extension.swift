//
//  Extension.swift
//  SpaceWar
//
//  Created by 黃健偉 on 2018/2/14.
//  Copyright © 2018年 黃健偉. All rights reserved.
//

import SpriteKit

func clamp<T: Comparable>(_ value: T, _ lower: T, _ upper: T) -> T {
    return min(max(value, lower), upper)
}

// for bullet's degree
func degreeToRadian(degree: Double!) -> CGFloat {
    return CGFloat(degree) / CGFloat(90.0 * CGFloat.pi)
}

// for ship, enemy, bullets
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
    var moveMode: enemyMode? {
        get {
            return userData?.value(forKey: "mode") as? enemyMode
        }
        set(newValue) {
            if userData == nil {
                userData = NSMutableDictionary()
            }
            userData?.setValue(newValue, forKey: "mode")
        }
    }
    var bulletType: Int? {
        get {
            return userData?.value(forKey: "bullet") as? Int
        }
        set(newValue) {
            if userData == nil {
                userData = NSMutableDictionary()
            }
            userData?.setValue(newValue, forKey: "bullet")
        }
    }
}

// for random color
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

// for random color
extension UIColor {
    static func random() -> UIColor {
        return UIColor(red: .random(), green: .random(), blue:  .random(), alpha: 1.0)
    }
}

// for ramp bullets
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


