//
//  Comment.swift
//  Pariah
//
//  Created by Erik Kovacic on 17/11/2018.
//  Copyright © 2018 rit. All rights reserved.
//

import Foundation

struct Comment: Codable {
    
    var commentId: Int = 0
    var user: User?
    var content: String = ""
    var dish: Dish?
}
