//
//  Ingredient.swift
//  Pariah
//
//  Created by Erik Kovacic on 17/11/2018.
//  Copyright © 2018 rit. All rights reserved.
//

import Foundation

struct Ingredient: CustomStringConvertible, Codable {
    
    var description: String {
        return "ingredientId: \(ingredientId)"
    }
    
    var ingredientId: Int = 0
    var name: String = ""
    var type: String = ""
    var price: Double = 0.0
}
