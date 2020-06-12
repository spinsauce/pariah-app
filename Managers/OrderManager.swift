//
//  OrderManager.swift
//  Pariah
//
//  Created by Erik Kovacic on 29/11/2018.
//  Copyright © 2018 rit. All rights reserved.
//

import Foundation

class OrderManager {
    
    static var instance = OrderManager()
    
    var dishIds: [Int] = []
    var dishes: [Dish] = []
    
    var totalPrice: Double {
        var sum: Double = 0.0
        for dish in dishes {
            sum += dish.price
        }
        return sum
    }
    
}
