//
//  HomeViewController.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 16/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var prefersStatusBarHidden: Bool { true }

    //MARK: - Actions

    @IBAction func onTapStart(_ sender: Any) {
        performSegue(withIdentifier: "showLevel", sender: nil)
    }
}
