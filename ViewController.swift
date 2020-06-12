//
//  ViewController.swift
//  Pariah
//
//  Created by Bernard Radocaj (RIT Student) on 10/22/18.
//  Copyright © 2018 rit. All rights reserved.
//

import UIKit
import Foundation
import CoreGraphics

class SignInViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView! // No need to touch this
    
    @IBOutlet weak var usernameTextField: UITextField!

    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signInButton(_ sender: UIButton) {
        
        // Take user input (username, password)
        // Send input to server
        // if credentials are correct
        // performSegue to home screen
        
//        self.performSegue(withIdentifier: "GoToHomeScreen", sender: self)
    }
    
    // Make this label clickable, make it navigate to a registration form (IF TIME)
    @IBOutlet weak var registerLabel: UILabel!
    
    @IBOutlet weak var signInButton: UIButton!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        // Stylize user image
        userImage.layer.cornerRadius = 25
        userImage.layer.borderColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor
        userImage.layer.borderWidth = 5
        userImage.clipsToBounds = true
        
        
    }


}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
