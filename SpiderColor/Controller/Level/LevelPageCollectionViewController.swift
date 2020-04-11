//
//  LevelPageCollectionViewController.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 18/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import GoogleMobileAds
import UIKit

protocol LevelPageDelegate {
    func nextPage(revealFirst: Bool)
}

class LevelPageCollectionViewController: UICollectionViewController {
    let page: Int
    private let levels: [Level]
    private let parentVC: UIViewController
    var delegate: LevelPageDelegate?
    var gameDelegate: GameDelegate?
    var revealFirst: Bool = false

    //MARK: - Collection View variables

    private var flowLayout: UICollectionViewFlowLayout
    private let gridCols: CGFloat = 3
    private let gridRows: CGFloat = 3
    private let spacing: CGFloat = 30

    private let horizontalMargin: CGFloat = 30
    private var collectionWidth: CGFloat { collectionView.frame.width }
    private var cardWidth: CGFloat { (collectionWidth - 2 * horizontalMargin - (gridCols - 1) * spacing) / gridCols }

    private var collectionHeight: CGFloat { collectionView.frame.height }
    private var cardHeight: CGFloat { cardWidth * 1.3 }
    private var verticalMargin: CGFloat { (collectionHeight - (gridRows * cardHeight) - (gridRows - 1) * spacing) / 2 }

    init(page: Int, levels: [Level], parent: UIViewController) {
        self.page = page
        self.levels = levels
        self.parentVC = parent
        self.flowLayout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: flowLayout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView!.backgroundColor = .clear

        collectionView!.registerFromNib(LevelCardCollectionViewCell.self)
        collectionView.layoutIfNeeded()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if self.revealFirst, let firstCell = self.collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? LevelCardCollectionViewCell {
                firstCell.reveal()
                print("reveal")
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupFlowLayout()
    }

    func setupFlowLayout() {
        flowLayout.itemSize = CGSize(width: cardWidth, height: cardHeight)
        flowLayout.minimumInteritemSpacing = spacing
        flowLayout.minimumLineSpacing = spacing
        flowLayout.sectionInset = UIEdgeInsets(top: verticalMargin, left: horizontalMargin, bottom: verticalMargin, right: horizontalMargin)
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return levels.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellFromNib(LevelCardCollectionViewCell.self, for: indexPath) {
            cell.level = levels[indexPath.row]
            return cell
        }

        return UICollectionViewCell()
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let cell = collectionView.cellForItem(at: indexPath) as? LevelCardCollectionViewCell {
//            cell.reveal()
//        }

        let level = levels[indexPath.row]

        if level.isAvailable {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "gameVC") as! GameViewController
            vc.level = level
            vc.gameDelegate = self

            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .flipHorizontal
            parentVC.present(vc, animated: true, completion: nil)
        }
    }
}

//MARK: - GameDelegate

extension LevelPageCollectionViewController: GameDelegate {
    func complete(level: Level) {
        if let index = levels.firstIndex(where: { level.value == $0.value }) {
            let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as! LevelCardCollectionViewCell
            cell.complete {
                if index < self.levels.count - 1 {
                    let nextCell = self.collectionView.cellForItem(at: IndexPath(item: index + 1, section: 0)) as! LevelCardCollectionViewCell
                    nextCell.reveal()
                } else {
                    self.delegate?.nextPage(revealFirst: self.revealFirst)
                }

                GameManager.shared.complete(level: level)
                self.gameDelegate?.complete(level: level)
            }
        }
    }
}
