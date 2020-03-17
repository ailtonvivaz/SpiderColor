//
//  LevelViewController.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 16/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import UIKit

class LevelViewController: UIViewController {
    private var indexOfCellBeforeDragging = 0
    private var page = 0

    @IBOutlet var collectionView: UICollectionView!

    private let spacing: CGFloat = 20

    private let horizontalMargin: CGFloat = 20
    private var collectionWidth: CGFloat { collectionView.frame.width }
    private let gridCols: CGFloat = 3
    private var cardWidth: CGFloat { (collectionWidth - 2 * horizontalMargin - (gridCols - 1) * spacing) / gridCols }

    private let verticalMargin: CGFloat = 40
    private var collectionHeight: CGFloat { collectionView.frame.height }
    private let gridRows: CGFloat = 3
    private var cardHeight: CGFloat { (collectionHeight - 2 * verticalMargin - (gridRows - 1) * spacing) / gridRows }

    var numberOfItems: Int { collectionView.numberOfItems(inSection: 0) }
    var itemsPerPage: CGFloat { gridCols * gridRows }
    var numberOfPages: Int { Int(ceil(CGFloat(numberOfItems) / itemsPerPage)) }

    private var collectionViewFlowLayout: UICollectionViewFlowLayout {
        return collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerFromNib(LevelCardCollectionViewCell.self)
    }

    private func indexOfMajorCell() -> Int {
        var proportionalOffset = collectionView!.contentOffset.x / collectionWidth
        if proportionalOffset < CGFloat(indexOfCellBeforeDragging) {
            proportionalOffset -= 0.2
//            index = Int(floor(proportionalOffset))
        } else {
            proportionalOffset += 0.2
//            index = Int(ceil(proportionalOffset))
        }
        let index: Int = Int(round(proportionalOffset))

        let safeIndex = max(0, min(numberOfPages - 1, index))
        print("safe", proportionalOffset, safeIndex, indexOfCellBeforeDragging)
        return safeIndex
    }

    private func firstCenterItemFor(page: Int) -> Int {
        page * Int(itemsPerPage) + Int(gridRows)
    }

    private func goTo(page: Int) {
        // calculate where scrollView should snap to:
        let indexOfMajorCell = firstCenterItemFor(page: page)
        let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
        print(indexPath)
        collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        self.page = page
    }

    @IBAction func onTapPrevious(_ sender: Any) {
        if page > 0 {
            goTo(page: page - 1)
        }
    }

    @IBAction func onTapNext(_ sender: Any) {
        goTo(page: page + 1)
    }
}

// MARK: - UICollectionViewDelegate

extension LevelViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        indexOfCellBeforeDragging = indexOfMajorCell()
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // Stop scrollView sliding:
        targetContentOffset.pointee = scrollView.contentOffset

        goTo(page: indexOfMajorCell())
    }
}

// MARK: - UICollectionViewDataSource

extension LevelViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        54
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCellFromNib(LevelCardCollectionViewCell.self, for: indexPath) ?? UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension LevelViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: cardWidth, height: cardHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: verticalMargin, left: horizontalMargin, bottom: verticalMargin, right: horizontalMargin)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        spacing
    }
}
