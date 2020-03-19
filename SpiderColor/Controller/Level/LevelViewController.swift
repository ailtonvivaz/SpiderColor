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

    @IBOutlet var pageLabel: UILabel!
    @IBOutlet var previousPageButton: UIImageView!
    @IBOutlet var nextPageButton: UIImageView!
    @IBOutlet var containerPageView: UIView!

    //MARK: - Variables

    var pageViewController: UIPageViewController!

    private var indexPage = 0
    private var levels: [Level] { Model.shared.levels }

    private let gridCols: CGFloat = 3
    private let gridRows: CGFloat = 3
    private var numberOfItems: Int { levels.count }
    private var itemsPerPage: CGFloat { gridCols * gridRows }
    private var numberOfPages: Int { Int(ceil(CGFloat(numberOfItems) / itemsPerPage)) + 1 }

    private var page: UIViewController { page(from: indexPage)! }

    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        containerPageView.addSubview(pageViewController.view)
        pageViewController.view.frame = containerPageView.bounds
        pageViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pageViewController.didMove(toParent: self)
        pageViewController.view.subviews
            .compactMap { $0 as? UIScrollView }
            .forEach { $0.isScrollEnabled = false }

        goTo(indexPage: 0)
    }

    override var prefersStatusBarHidden: Bool { true }

    private func goTo(indexPage: Int) {
        if let page = page(from: indexPage) {
            pageViewController.setViewControllers([page], direction: indexPage > self.indexPage ? .forward : .reverse, animated: true, completion: nil)
            self.indexPage = indexPage
            pageLabel.text = "page \(indexPage + 1)"

            previousPageButton.isHidden = self.indexPage == 0
            nextPageButton.isHidden = self.indexPage == numberOfPages - 1
        }
    }

    private func page(from index: Int) -> UIViewController? {
        if index == numberOfPages - 1 {
            return LevelSoonViewController.loadFromNib()
        } else if index >= 0, index < numberOfPages - 1 {
            return LevelPageCollectionViewController(levels: Model.shared.levels, parent: self)
        }
        return nil
    }

    //MARK: - Actions

    @IBAction func onTapHome(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onTapPrevious(_ sender: Any) {
        if indexPage > 0 {
            goTo(indexPage: indexPage - 1)
        }
    }

    @IBAction func onTapNext(_ sender: Any) {
        if indexPage < numberOfPages - 1 {
            goTo(indexPage: indexPage + 1)
        }
    }
}

//MARK: - UIPageViewControllerDelegate

extension LevelViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        print("compelted")
    }
}

//MARK: - UIPageViewControllerDataSource

extension LevelViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        page(from: indexPage - 1)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        page(from: indexPage + 1)
    }
}
