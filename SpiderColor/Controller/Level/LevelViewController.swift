//
//  LevelViewController.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 16/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import UIKit

class LevelViewController: UIViewController {
    //MARK: - Outlets

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageLabel: UILabel!

    //MARK: - Variables

    private var page = 0
    private var indexOfCellBeforeDragging = 0
    private let gridCols: CGFloat = 3
    private let gridRows: CGFloat = 3
    private let spacing: CGFloat = 30
    private var levels: [Level] { Model.shared.levels }

    private var numberOfItems: Int { collectionView.numberOfItems(inSection: 0) }
    private var itemsPerPage: CGFloat { gridCols * gridRows }
    private var numberOfPages: Int { Int(ceil(CGFloat(numberOfItems) / itemsPerPage)) }

    //MARK: - Collection View variables

    private let horizontalMargin: CGFloat = 30
    private var collectionWidth: CGFloat { collectionView.frame.width }
    private var cardWidth: CGFloat { (collectionWidth - 2 * horizontalMargin - (gridCols - 1) * spacing) / gridCols }

    private var collectionHeight: CGFloat { collectionView.frame.height }
    private var cardHeight: CGFloat { cardWidth * 1.3 }
    private var verticalMargin: CGFloat { (collectionHeight - (gridRows * cardHeight) - (gridRows - 1) * spacing) / 2 }

    private var collectionViewFlowLayout: UICollectionViewFlowLayout {
        return collectionView.collectionViewLayout as! UICollectionViewFlowLayout
    }

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerFromNib(LevelCardCollectionViewCell.self)

        goTo(page: 0)
    }

    override var prefersStatusBarHidden: Bool { true }

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
        pageLabel.text = "page \(self.page + 1)"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? GameViewController, let level = sender as? Level {
            vc.level = level
            vc.gameDelegate = self
        }
    }

    //MARK: - Actions

    @IBAction func onTapHome(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onTapPrevious(_ sender: Any) {
        if page > 0 {
            goTo(page: page - 1)
        }
    }

    @IBAction func onTapNext(_ sender: Any) {
        if page < numberOfPages - 1 {
            goTo(page: page + 1)
        }
    }
}

//MARK: - GameDelegate

extension LevelViewController: GameDelegate {
    func complete(level: Level) {
        if let index = levels.firstIndex(where: { level.value == $0.value }) {
            Model.shared.levels[index].completed = true
            let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as! LevelCardCollectionViewCell
            cell.complete()

            if index < levels.count - 1 {
                Model.shared.levels[index + 1].isAvailable = true
                let nextCell = collectionView.cellForItem(at: IndexPath(item: index + 1, section: 0)) as! LevelCardCollectionViewCell
                nextCell.reveal()
            }
//            collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
        }
    }
}

// MARK: - UICollectionViewDelegate

extension LevelViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let level = levels[indexPath.row]
        if level.isAvailable {
            performSegue(withIdentifier: "startGame", sender: level)
        }
    }

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
        levels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellFromNib(LevelCardCollectionViewCell.self, for: indexPath) {
            cell.level = levels[indexPath.row]
            return cell
        }

        return UICollectionViewCell()
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
