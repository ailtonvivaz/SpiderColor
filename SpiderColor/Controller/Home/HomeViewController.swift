//
//  HomeViewController.swift
//  SpiderColor
//
//  Created by Ailton Vieira Pinto Filho on 16/03/20.
//  Copyright © 2020 Veevaz. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var logoTopView: UIImageView!
    @IBOutlet weak var logoBottomView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        UIView.ani
    }

    override var prefersStatusBarHidden: Bool { true }

    //MARK: - Actions
 
    @IBAction func onTapStart(_ sender: Any) {
//        UIView.animate(withDuration: 0.2) {
//            self.logoTopView.transform = CGAffineTransform(rotationAngle: .pi)
//        }
        
        AnalyticsUtils.tapButton("start")
        performSegue(withIdentifier: "showLevel", sender: nil)
    }
}
