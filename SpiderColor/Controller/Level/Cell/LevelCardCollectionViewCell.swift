//
//  LevelCardCollectionViewCell.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 16/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import UIKit

class LevelCardCollectionViewCell: UICollectionViewCell {
    @IBOutlet var gradientView: GradientView!
    @IBOutlet var backCardView: UIView!

    @IBOutlet var levelLabel: UILabel!
    @IBOutlet var levelCompletedImageView: UIImageView!

    var level: Level! {
        didSet {
            levelLabel.text = String(format: "%03d", level.value)
            gradientView.colors = level.colors
            levelCompletedImageView.isHidden = !level.completed

            backCardView.isHidden = level.isAvailable
            gradientView.isHidden = !level.isAvailable

            shadowed = level.focused
        }
    }

    var enabled: Bool = false
    private var shadowed: Bool = false {
        didSet { self.gradientView.layer.shadowOpacity = shadowed ? 0.5 : 0.1 }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        backCardView.isHidden = false
        backCardView.layer.shadowColor = UIColor.white.cgColor
        backCardView.layer.shadowOffset = .zero
        backCardView.layer.shadowRadius = 10
        backCardView.layer.shadowOpacity = 0.1

        layer.masksToBounds = false
        
        gradientView.isHidden = true
        gradientView.layer.shadowColor = UIColor.white.cgColor
        gradientView.layer.shadowOffset = .zero
        gradientView.layer.shadowRadius = 10

        shadowed = false
    }

    func complete(completion: @escaping () -> Void = {}) {
        level.completed = true
        UIView.animate(withDuration: 0.1) {
            self.levelCompletedImageView.isHidden = !self.level.completed
        }

        UIView.animate(withDuration: 0.25, animations: {
            self.shadowed = false
        }, completion: { _ in
            completion()
        })
    }

    func reveal(completion: @escaping () -> Void = {}) {
        if !level.isAvailable {
            let transitionOptions = UIView.AnimationOptions.transitionFlipFromRight

            UIView.transition(with: contentView, duration: 0.5, options: transitionOptions, animations: {
                self.backCardView.isHidden = true
                self.gradientView.isHidden = false

            }, completion: { _ in
                self.level.isAvailable = true
                completion()

                UIView.animate(withDuration: 0.25) {
                    self.shadowed = true
                }

            })
        }
    }
}
