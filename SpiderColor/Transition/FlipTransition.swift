//
//  FlipTransition.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 12/04/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import UIKit

class FlipTransition: NSObject, UIViewControllerAnimatedTransitioning {
    enum TransitionType {
        case presenting
        case dismissing
    }

    private let transitionType: TransitionType

    init(transitionType: TransitionType) {
        self.transitionType = transitionType
        super.init()
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        containerView.isUserInteractionEnabled = transitionType != .presenting

        let toView = transitionContext.viewController(forKey: .to)?.view
        let fromView = transitionContext.viewController(forKey: .from)?.view

        var animationTransitionOptions: UIView.AnimationOptions {
            if transitionType == .presenting {
                return containerView.isRTL ? .transitionFlipFromLeft : .transitionFlipFromRight
            } else {
                return containerView.isRTL ? .transitionFlipFromRight : .transitionFlipFromLeft
            }
        }

        UIView.transition(from: fromView!, to: toView!, duration: transitionDuration(using: transitionContext), options: animationTransitionOptions.union(.curveEaseInOut)) { _ in
            transitionContext.completeTransition(true)
        }
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
}
