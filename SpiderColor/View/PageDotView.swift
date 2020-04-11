//
//  PageDotView.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 11/04/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import UIKit

class PageDotView: UIView {
    private let numberOfDots = 7
    
    private var adjustment: Int {
        -3 + currentPage
    }
    
    var numberOfPages: Int = 0
    private var currentPage: Int = 0
    
    private var collectionView: UICollectionView!
    private var flowLayout = UICollectionViewFlowLayout()
    private var collectionLeadingConstraint: NSLayoutConstraint!
    
    private let spacing: CGFloat = 10
    private var cellSize: CGFloat {
        min((frame.width - (CGFloat(numberOfDots - 1) * spacing)) / CGFloat(numberOfDots), frame.height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(collectionView)
        
        collectionLeadingConstraint = collectionView.leadingAnchor.constraint(equalTo: leadingAnchor)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionLeadingConstraint,
            collectionView.widthAnchor.constraint(equalTo: widthAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        collectionView.backgroundColor = .clear
        collectionView.register(PageDotCell.self, forCellWithReuseIdentifier: "cell")
        
        flowLayout.minimumInteritemSpacing = spacing
        flowLayout.itemSize = CGSize(width: cellSize, height: cellSize)
    }
    
    func factor(of index: Int, offset: Int = 0) -> CGFloat {
        let index = index + adjustment
        print("factor", index)
        if index < offset { return 0.01 }
        if index > numberOfPages + offset - 1 { return 0.01 }
        
        let mod = abs(currentPage - index)
        if mod > 2 { return 0.01 }
        
        return (CGFloat(1) - CGFloat(mod) / 4)
    }
    
    func setInitial(page: Int) {
        self.currentPage = page
        collectionView.reloadData()
    }
    
    private func go(to page: Int) {
        UIView.animate(withDuration: 0.25, animations: {
            for i in 0..<self.numberOfDots {
                if let cell = self.collectionView.cellForItem(at: IndexPath(row: i, section: 0)) as? PageDotCell {
                    cell.factor = self.factor(of: i - page, offset: -page)
                }
            }
            
            self.collectionLeadingConstraint.constant = CGFloat(-page) * (self.cellSize + self.spacing)
            self.layoutIfNeeded()
        }) { _ in
            self.currentPage += page
            self.collectionView.reloadData()
            self.collectionLeadingConstraint.constant = 0
        }
    }
    
    func previous() { go(to: -1) }
    
    func next() { go(to: +1) }
}

//MARK: UICollectionViewDataSource

extension PageDotView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { numberOfDots }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PageDotCell {
            cell.factor = factor(of: indexPath.row)
            return cell
        }
        
        return UICollectionViewCell()
    }
}

class PageDotCell: UICollectionViewCell {
    private let dotView = UIView()
    
    var factor: CGFloat = 1.0 {
        didSet {
            self.dotView.alpha = self.factor
            self.dotView.transform = CGAffineTransform(scaleX: self.factor, y: self.factor)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func getWidthConstraint(multiplier: CGFloat) -> NSLayoutConstraint {
        dotView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: multiplier)
    }
    
    private func setup() {
        dotView.translatesAutoresizingMaskIntoConstraints = false
        dotView.backgroundColor = .white
        dotView.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        addSubview(dotView)
        
        NSLayoutConstraint.activate([
            dotView.widthAnchor.constraint(equalTo: widthAnchor),
            dotView.heightAnchor.constraint(equalTo: dotView.widthAnchor),
            dotView.centerXAnchor.constraint(equalTo: centerXAnchor),
            dotView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    override func layoutSubviews() {
        dotView.layer.cornerRadius = frame.width / 2
    }
}
