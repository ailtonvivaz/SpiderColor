//
//  GameViewController.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 04/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import GameplayKit
import GoogleMobileAds
import SpriteKit
import UIKit

class GameViewController: UIViewController {
    @IBOutlet var sceneView: SKView!
    @IBOutlet var topView: UIView!
    @IBOutlet weak var spectrumGradientView: SpectrumGradientView!
    @IBOutlet var bannerView: GADBannerView!

    var interstitial: GADInterstitial!

    var level: Level!
    var gameDelegate: GameDelegate!
    private var startTime = DispatchTime.nowInSeconds
    private var elapsedTime: UInt = 0

    private var scene: GameScene!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        spectrumGradientView.set(level: level)

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

        // Game banner
        bannerView.adUnitID = Ads.gameBanner
        bannerView.rootViewController = self
        bannerView.load(GADRequest())

        // Game interstitial
        interstitial = GADInterstitial(adUnitID: Ads.interLevel)
        interstitial.delegate = self
        let request = GADRequest()
        interstitial.load(request)
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

    func dismiss() {
        dismiss(animated: true) {
            self.gameDelegate.complete(level: self.level)
        }
    }

    func finish() {
//        if level.value >= 5, interstitial.isReady {
//            interstitial.present(fromRootViewController: self)
//        } else {
            dismiss()
//        }
    }
}

//MARK: - GameDelegate

extension GameViewController: GameDelegate {
    func complete(level: Level) {
        let time = elapsedTime + (DispatchTime.nowInSeconds - startTime)
        AnalyticsUtils.endLevel(level.value, time: time)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.finish()
        }
    }
}

//MARK: GADInterstitialDelegate

extension GameViewController: GADInterstitialDelegate {
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        dismiss()
    }
}
