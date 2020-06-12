//
//  CreateDishViewController.swift
//  Pariah
//
//  Created by Erik Kovacic on 29/11/2018.
//  Copyright © 2018 rit. All rights reserved.
//

import UIKit

class CreateDishViewController: UIViewController {
    
    var ingredients: [Ingredient] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func randomizeDishTapped(_ sender: UIButton) {
        
            var dish = Dish()
            dish.name = "MyRandomDish" // Will be changed to some generator (wishlist)
        
            IngredientService.service.fetchRandomIngredients(ingredientAmount: 5, completionHandler: {
                success, ingredients in
                if success {
                    if let randomIngredients = ingredients {
                        self.ingredients = randomIngredients
                        dish.ingredients = ingredients
                        DishService.service.submitDish(dish: dish, completionHandler: {success,dish in
                            if success {
                                InfoHelper.showAlert(title: "Success", message: "Your random dish has been created.", view: self, buttonTitle: "Yay!")
                            } else {
                                InfoHelper.showAlert(title: "Failure", message: "Something went wrong with dish creation.", view: self, buttonTitle: "Ugh")
                            }
                        })
                    }
                }
            })
    }
}
