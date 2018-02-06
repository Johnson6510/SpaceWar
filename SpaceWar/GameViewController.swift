//
//  GameViewController.swift
//  SpaceWar
//
//  Created by 黃健偉 on 2018/1/25.
//  Copyright © 2018年 黃健偉. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

var gameScene: SKScene!

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.isMultipleTouchEnabled = false
        
        if let view = self.view as! SKView? {
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true

            gameScene = GameScene(size: view.bounds.size)
            gameScene.scaleMode = .aspectFill
            view.presentScene(gameScene)
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
