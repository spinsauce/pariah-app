//
//  DishesTableViewController.swift
//  Pariah
//
//  Created by Erik Kovacic on 28/11/2018.
//  Copyright © 2018 rit. All rights reserved.
//

import UIKit

class DishesTableViewController: UITableViewController {
    
    var data: [Dish] = []

    private func getData(which: DishesEnum) {
        DishService.service.fetchDishesByDesignation(which: which, completionHandler: {
            success, dishes in
            if success {
                if let requestedDishes = dishes {
                    self.data = requestedDishes
                    self.tableView.reloadData()
                }
            } else {
                self.data = []
                self.tableView.reloadData()
            }
        })
    }
    
    @IBAction func segmentButtonTapped(_ sender: UISegmentedControl) {
        guard let segmentName = sender.titleForSegment(at: sender.selectedSegmentIndex) else {
            return
        }
        
        if let designation = DishesEnum(rawValue: segmentName.lowercased()) {
            getData(which: designation)
        } else {
            InfoHelper.showAlert(title: "Error", message: "No such category", view: self, buttonTitle: "Ok")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(which: DishesEnum.all)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getData(which: DishesEnum.all)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DishCell", for: indexPath)
        
        let dish = data[indexPath.row]
        cell.textLabel?.text = dish.name
        cell.detailTextLabel?.text = String(format: "Price: $%.2f", dish.price)
        
        return cell
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dishDetailVC = segue.destination as? DishDetailTableViewController, let row = tableView.indexPathForSelectedRow?.row {
            let dish = data[row]
            dishDetailVC.dish = dish            
        }
    }
}
