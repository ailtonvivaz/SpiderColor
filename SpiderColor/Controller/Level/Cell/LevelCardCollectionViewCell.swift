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
            levelLabel.text = String(format: "%02d", level.value)
            gradientView.colors = level.colors
            levelCompletedImageView.isHidden = !level.completed

            backCardView.isHidden = level.isAvailable
            gradientView.isHidden = !level.isAvailable
        }
    }

    var enabled: Bool = false
    private var revealed: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()

        backCardView.isHidden = false
        gradientView.isHidden = true
        
        reveal()
    }

    func reveal() {
        if !revealed {
            let transitionOptions = UIView.AnimationOptions.transitionFlipFromLeft

            UIView.transition(with: contentView, duration: 0.5, options: transitionOptions, animations: {
                self.backCardView.isHidden = true
                self.gradientView.isHidden = false

            }, completion: { _ in
                self.revealed = true
            })
        }
    }
}
