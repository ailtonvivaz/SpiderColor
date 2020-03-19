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

    var level: Level!
    var gameDelegate: GameDelegate!
    private var startTime = DispatchTime.nowInSeconds
    private var elapsedTime: UInt = 0

    private var scene: GameScene!

    override func viewDidLoad() {
        super.viewDidLoad()

        scene = GameScene(level: level, size: view.frame.size, top: topView.frame.maxY, bottom: view.safeAreaInsets.bottom)
        scene.scaleMode = .resizeFill
        scene.gameDelegate = self

        // Present the scene
        sceneView.presentScene(scene)
        sceneView.allowsTransparency = true
//        sceneView.showsFPS = true
//        sceneView.showsNodeCount = true

        AnalyticsUtils.startLevel(level.value)

        // add notification observers
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }

    @objc func didBecomeActive() {
        startTime = DispatchTime.nowInSeconds
    }

    @objc func willResignActive() {
        elapsedTime = DispatchTime.nowInSeconds - startTime
    }

    override var prefersStatusBarHidden: Bool { true }

    //MARK: - Actions

    @IBAction func onTapUndo(_ sender: Any) {
        scene.undoMovement()
    }

    @IBAction func onTapPause(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - GameDelegate

extension GameViewController: GameDelegate {
    func complete(level: Level) {
        let time = elapsedTime + (DispatchTime.nowInSeconds - startTime)
        AnalyticsUtils.endLevel(level.value, time: time)
        dismiss(animated: true) {
            self.gameDelegate.complete(level: level)
        }
    }
}