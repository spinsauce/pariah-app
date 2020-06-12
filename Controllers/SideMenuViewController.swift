//
//  SideMenuView.swift
//  Pariah
//
//  Created by Erik Kovacic on 26/10/2018.
//  Copyright © 2018 rit. All rights reserved.
//

import UIKit

class SideMenuViewController: UITableViewController {
    
    // Delete user info from the app
    func removeUserSession() {}
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Push side menu back whenever we click an item
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
        
        // Probably should remove home
        switch indexPath.row {
            case 0 :
                return
            case 1:
                NotificationCenter.default.post(name: NSNotification.Name("ShowDishes"), object: nil)
            case 2:
                NotificationCenter.default.post(name: NSNotification.Name("ShowCreateDish"), object: nil)
            case 3:
                NotificationCenter.default.post(name: NSNotification.Name("ShowCart"), object: nil)
            case 4:
                removeUserSession()
                self.performSegue(withIdentifier: "ShowSignIn", sender: self)
            default:
                break
        }
    }
}
