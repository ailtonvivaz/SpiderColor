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
    @IBOutlet var sceneView: SKView!
    @IBOutlet var topView: UIView!
    @IBOutlet var bottomView: UIView!

    var level: Level!

    private var scene: GameScene!

    override func viewDidLoad() {
        super.viewDidLoad()

        scene = GameScene(level: level, size: view.frame.size, top: topView.frame.maxY, bottom: view.frame.height - bottomView.frame.minY)
        scene.scaleMode = .resizeFill

        // Present the scene
        sceneView.presentScene(scene)
        sceneView.allowsTransparency = true

//        sceneView.ignoresSiblingOrder = true
//
//        sceneView.showsFPS = true
//        sceneView.showsNodeCount = true
//        sceneView.showsFields = true
    }

    override var prefersStatusBarHidden: Bool { true }

    @IBAction func onTapUndo(_ sender: Any) {
        scene.undoMovement()
    }
    
    @IBAction func onTapPause(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
