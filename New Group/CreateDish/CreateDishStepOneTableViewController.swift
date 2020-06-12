//
//  CreateDishStepOneTableViewController.swift
//  Pariah
//
//  Created by Erik Kovacic on 06/12/2018.
//  Copyright © 2018 rit. All rights reserved.
//

import UIKit

class CreateDishStepOneTableViewController: UITableViewController
//, UIPickerViewDelegate, UIPickerViewDataSource
{

    var ingredients: [Ingredient] = []
// later we will implemt pickBox for finer search options
//    @IBOutlet weak var pickerBox: UIPickerView!
    
    var pickerData: [String] = [String]()

   //sending request on every key stroke, because fluidity, and because we can afford it for the presentation, later version will be on return or dismiss keyboard
    @IBAction func searchChanged(_ sender: UITextField) {
        guard let searchTerm = sender.text else {
            return
        }
        self.searchIngredients(search: searchTerm)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchIngredients(search: "")
//        self.pickerBox.delegate = self
//        self.pickerBox.dataSource = self
//        pickerData = ["All", "item1", "item2"]
    }
    
    func searchIngredients(search: String, type: String = "all") {
        IngredientService.service.searchIngredients(searchTerm: search, completionHandler: {
            success, ingredients in
            if success {
                if let ingredients = ingredients {
                    self.ingredients = ingredients
                    self.tableView.reloadData()
                }
            }
        })
    }
    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return pickerData.count
//    }
//
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return pickerData[row]
//    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ingredients.count
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        
        // Change highlight color of the selected row, Paul Hudson tutorial
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.yellow
        cell.selectedBackgroundView = backgroundView

        let ingredient = ingredients[indexPath.row]
        cell.textLabel?.text = ingredient.name
        cell.detailTextLabel?.text = String(format: "Price: $%.2f", ingredient.price)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ingredient: Ingredient = ingredients[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        DishManager.instance.addIngredient(ingredient: ingredient)
        InfoHelper.showAlert(title: "Success", message: String(format: "Added %@ to your dish", ingredient.name), view: self, buttonTitle: "Ok")
    }
}
