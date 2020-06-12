//
//  Dish.swift
//  Pariah
//
//  Created by Erik Kovacic on 17/11/2018.
//  Copyright © 2018 rit. All rights reserved.
//

import Foundation

struct Dish: CustomStringConvertible, Codable {
    
    var description: String {
        guard let ingredients = ingredients else {
            return "dishId: \(dishId) user: \(String(describing: user)) name: \(name) likes: \(likes)"
        }
        return "dishId: \(dishId) user: \(String(describing: user)) name: \(name) likes: \(likes) ingredients: \(ingredients.count)"
    }
    
    var listOfIngredients: String {
        var stringBuilder: String = ""
        if let ingredients = ingredients {
            for i in ingredients {
                stringBuilder += i.name + ", "
            }
        }
        return String(stringBuilder.dropLast(2))
    }
    
    var price: Double {
        var sum: Double = 0.0
        if let ingredients = ingredients {
            for i in ingredients {
                sum += i.price
            }
        }
        return sum
    }
    
    var dishId: Int = 0
    var user: User?
    var name: String = ""
    var likes: Int = 0
    var ingredients: [Ingredient]?
}
