//
//  SignInVC.swift
//  Pariah
//
//  Created by Erik Kovacic on 13/11/2018.
//  Copyright © 2018 rit. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {
    
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    @IBAction func signInTapped(_ sender: UIButton) {
        
        guard let username = usernameLabel.text, let password = passwordLabel.text else {
            return
        }
        self.login(username: username, password: password)
    }
    
    func login(username: String, password: String) {
        UserService.service.login(username: username, password: password, completionHandler: {
            success, description in
            if success {
                let credentials: [String: String] = ["username": username, "password": password]
                UserDefaults.standard.set(credentials, forKey: "credentials")
                self.performSegue(withIdentifier: "ShowHome", sender: self)
            } else {
                print(description)
                InfoHelper.showAlert(title: "Warning", message: "Your username or password is incorrect.\nPlease try again.", view: self, buttonTitle: "Close")
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        if let existingUser = UserDefaults.standard.object(forKey: "credentials") as? [String : String] {
            guard let username = existingUser["username"], let password = existingUser["password"] else {
                return
            }
            self.login(username: username, password: password)
        }
    }
}

// Kuray Ogun tutorial on how to dismiss the keyboard when tapped anywhere on screen
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

