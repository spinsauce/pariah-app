//
//  User.swift
//  Pariah
//
//  Created by Erik Kovacic on 17/11/2018.
//  Copyright © 2018 rit. All rights reserved.
//

import Foundation

struct User: CustomStringConvertible, Codable {
    var description: String {
        return "userId: \(userId) username: \(username)"
    }
    
    var userId: Int
    var username: String
}
