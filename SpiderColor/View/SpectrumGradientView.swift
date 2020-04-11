//
//  SpectrumGradientView.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 10/04/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import UIKit

class SpectrumGradientView: UIView {
    let stackView = UIStackView()
    private var level: Level?
    private var cardViews: [UIView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        clipsToBounds = true
        layer.cornerRadius = 0.25 * frame.height
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalTo: heightAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
    }
    
    func set(level: Level) {
        self.level = level
        self.cardViews = []
        stackView.arrangedSubviews.forEach { stackView.removeArrangedSubview($0) }
        
        for color in level.cards.map(\.color) {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = color
            stackView.addArrangedSubview(view)
            view.alpha = 0.25
            
            view.heightAnchor.constraint(equalTo: stackView.heightAnchor).isActive = true
            cardViews.append(view)
        }
    }
    
    func setCompleted(cards: [Card]) {
        UIView.animate(withDuration: 0.25) {
            for card in cards {
                self.cardViews[card.value].alpha = 1.0
            }
        }
    }
}
