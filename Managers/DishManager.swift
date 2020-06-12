//
//  DishManager.swift
//  Pariah
//
//  Created by Erik Kovacic on 06/12/2018.
//  Copyright © 2018 rit. All rights reserved.
//

import Foundation

class DishManager {
    
    static var instance = DishManager()
    
    var dish: Dish = Dish()
    
    /**
     * This function will be used to add an ingredient to the dish object
     */
    func addIngredient(ingredient: Ingredient) {

        if var ingredients = dish.ingredients {
            ingredients.append(ingredient)
            dish.ingredients = ingredients
            print(dish)
        } else {
            var ingredients: [Ingredient] = [ingredient]
            dish.ingredients = ingredients
        }
    }
    
    /**
     * This function will be used to remove ingredients from the dish.
     */
    func removeIngredient(ingredient: Ingredient) {
        
        if var ingredients = dish.ingredients {
            if let index = ingredients.index(where: {$0.ingredientId == ingredient.ingredientId}) {
                print(index)
                ingredients.remove(at: index)
                dish.ingredients = ingredients
            }
        }
    }
    
    func setDishName(name: String) {
        dish.name = name
    }
    
}
