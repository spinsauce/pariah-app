//
//  HomeTableViewController.swift
//  Pariah
//
//  Created by Erik Kovacic on 17/11/2018.
//  Copyright © 2018 rit. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var data: [Dish] = []

    // Remove user credentials from UserDefaults and navigate to login screen when the logout is tapped
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        UserDefaults.standard.removeObject(forKey: "credentials")
        if let root = self.storyboard?.instantiateViewController(withIdentifier: "root") as? SignInVC {
            self.show(root, sender: self)
        }
    }
    
    private func getData() {
        DishService.service.fetchTopDishes(completionHandler: {
            success, dishes in
            if success {
                if let topDishes = dishes {
                    self.data = topDishes
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getData()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DishCustomCell", for: indexPath) as? HomeTableViewCell else {
            print("Custom Cell Dish is not available, error:4538")
            InfoHelper.showAlert(title: "Error", message: "Whoopsie! Something went wrong.", view: self, buttonTitle: "Ok")
            return UITableViewCell()
        }
       
        let dish = data[indexPath.row]
        cell.dishNameLabel?.text = dish.name
        cell.dishUserLabel?.text = String(format: "Created by %@", dish.user?.username ?? "Not available")
        cell.dishPriceLabel?.text = String(format: "Price: $%.2f", dish.price)
        cell.dishLikesLabel.text = String(format: "Likes: %d", dish.likes)

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dishDetailVC = segue.destination as? DishDetailTableViewController, let row = tableView.indexPathForSelectedRow?.row {
            let dish = data[row]
            dishDetailVC.dish = dish
        }
    }
}
