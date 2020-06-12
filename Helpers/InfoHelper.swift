//
//  InfoHelper.swift
//  Pariah
//
//  Created by Erik Kovacic on 06/12/2018.
//  Copyright © 2018 rit. All rights reserved.
//

import Foundation
import UIKit

class InfoHelper {
    
    static func showAlert(title: String, message: String, view: UIViewController, buttonTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        view.present(alert, animated: true)
    }
}
