//
//  ScrollBackground.swift
//  SpaceWar
//
//  Created by 黃健偉 on 2018/2/14.
//  Copyright © 2018年 黃健偉. All rights reserved.
//

import SpriteKit

class Background {
    var parent: SKScene?
    var bgHeight: CGFloat = 0
    
    init (parent: SKScene) {
        self.parent = parent
    }
    
    var scrollPos = 0
    func scrollBackground() {
        scrollPos += 1
        var restore = false
        if CGFloat(scrollPos) > bgHeight {
            scrollPos = 0
            restore = true
        }
        
        parent?.enumerateChildNodes(withName: "*") { node, stop in
            if let name = node.name {
                if name == "background" {
                    if restore {
                        node.position.y += self.bgHeight
                    }
                    else {
                        node.position.y -= 1
                    }
                }
            }
        }
    }
    
    func setupBackgroup() {
        for row in 0...2 {
            for col in 0...1 {
                let bg = SKSpriteNode(imageNamed: "background")
                //bg.xScale = 4.0
                //bg.yScale = 4.0
                bg.anchorPoint = CGPoint(x: 0.5, y: 0.5) //CGPoint.zero
                bg.position = CGPoint(x: CGFloat(col) * bg.size.width, y: CGFloat(row) * bg.size.height)
                bg.name = "background"
                bg.zPosition = -10
                bgHeight = bg.size.height
                parent?.addChild(bg)
            }
        }
    }
    
}

