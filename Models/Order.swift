//
//  Order.swift
//  Pariah
//
//  Created by Erik Kovacic on 17/11/2018.
//  Copyright © 2018 rit. All rights reserved.
//

import Foundation

struct Order: CustomStringConvertible, Codable{
    
    var description: String {
        guard let user = user else {
            return "orderId: \(orderId) address: \(deliveryAddress)"
        }
        return "orderId: \(orderId) address: \(deliveryAddress) user: \(user)"
    }
    

    
    
    var orderId: Int = 0
    var dateTime: String = ""
    var user: User?
    var deliveryAddress: String = ""
    var dishes: [Dish]?
}
