//
//  SplashViewController.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 11/04/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    let transition = HueCardTransition()

    @IBOutlet var logoImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.logoImageView.rotate(duration: 2.0, repeatCount: 1) {
                let vc = LevelViewController.loadFromNib()
                vc.transitioningDelegate = self
                vc.modalPresentationStyle = .custom

                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension SplashViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.logoImageView = logoImageView
        return transition
    }

//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {}
}
