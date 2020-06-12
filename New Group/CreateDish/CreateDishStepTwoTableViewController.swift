//
//  CreateDishStepTwoTableViewController.swift
//  Pariah
//
//  Created by Erik Kovacic on 06/12/2018.
//  Copyright © 2018 rit. All rights reserved.
//

import UIKit

class CreateDishStepTwoTableViewController: UITableViewController {
    
    var ingredients: [Ingredient] {
        guard let ingredients = DishManager.instance.dish.ingredients else {
            return []
        }
        return ingredients
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    @IBOutlet weak var dishNameTextField: UITextField!
    
    @IBAction func doneCreatingTapped(_ sender: UIButton) {
        
        guard let dishName = dishNameTextField.text else {
            return
        }
        
        if dishName.isEmpty {
            InfoHelper.showAlert(title: "Alert", message: "You must provide a name for your dish!", view: self, buttonTitle: "Ok")
        } else {
            DishManager.instance.setDishName(name: dishName)
            
            DishService.service.submitDish(dish: DishManager.instance.dish, completionHandler: {
                success, dish in
                if success {
                    InfoHelper.showAlert(title: "Success", message: "You have successfully created your dish", view: self, buttonTitle: "Ok")
                } else {
                    InfoHelper.showAlert(title: "Error", message: "Something went wrong,", view: self, buttonTitle: "Ok")
                }
            })
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientsCell", for: indexPath)
        
        let ingredient = ingredients[indexPath.row]
        cell.textLabel?.text = ingredient.name
        cell.detailTextLabel?.text = String(format: "Price %.2f", ingredient.price)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ingredient: Ingredient = ingredients[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        DishManager.instance.removeIngredient(ingredient: ingredient)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
}
