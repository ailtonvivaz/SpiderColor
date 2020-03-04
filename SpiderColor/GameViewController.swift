//
//  GameViewController.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 04/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import GameplayKit
import SpriteKit
import UIKit

class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let scene = GameScene(size: view.frame.size)

//        let sceneNode = scene.rootNode

        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill

        // Present the scene
        if let view = self.view as! SKView? {
            view.presentScene(scene)

            view.ignoresSiblingOrder = true

            view.showsFPS = true
            view.showsNodeCount = true
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

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
