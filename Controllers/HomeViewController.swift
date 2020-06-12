//
//  HomeViewController.swift
//  Pariah
//
//  Created by Erik Kovacic on 26/10/2018.
//  Copyright © 2018 rit. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // When menu button is clicked, toggle/show side menu
    @IBAction func browseMenu() {
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showHome),
                                               name: NSNotification.Name("ShowHome"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showDishes),
                                               name: NSNotification.Name("ShowDishes"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showCreateDish),
                                               name: NSNotification.Name("ShowCreateDish"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showCart),
                                               name: NSNotification.Name("ShowCart"),
                                               object: nil)
    }
    
    
    // Refactor to reduce repetition
    
    
    @objc func showHome() {
        performSegue(withIdentifier: "ShowHome", sender: nil)
    }
    @objc func showDishes() {
        performSegue(withIdentifier: "ShowDishes", sender: nil)
    }
    @objc func showCreateDish() {
        performSegue(withIdentifier: "ShowCreateDish", sender: nil)
    }
    @objc func showCart() {
        performSegue(withIdentifier: "ShowCart", sender: nil)
    }
    
}
