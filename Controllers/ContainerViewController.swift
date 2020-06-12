//
//  ContainerViewController.swift
//  Pariah
//
//  Created by Erik Kovacic on 26/10/2018.
//  Copyright © 2018 rit. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBOutlet weak var sideMenuConstrain: NSLayoutConstraint!
    var sideMenuOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(toggleSideMenu),
                                               name: NSNotification.Name("ToggleSideMenu"),
                                               object: nil)
    }
    
    // Setting to @objc so that the NotificationCenter can access it.
    @objc func toggleSideMenu() {
        if sideMenuOpen {
            sideMenuOpen = false
            sideMenuConstrain.constant = -250 // Moving the side menu view out of view
        } else {
            sideMenuOpen = true
            sideMenuConstrain.constant = 0 // Moving the side menu inside the screen
        }
        // Put slide animation from left
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
