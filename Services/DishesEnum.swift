//
//  DishesEnum.swift
//  Pariah
//
//  Created by Bernard Radocaj (RIT Student) on 11/28/18.
//  Copyright © 2018 rit. All rights reserved.
//

import Foundation

enum DishesEnum: String {
    case all, pariah, mine, fav
    
    var value: String {
        switch self {
        case .all:
            return "all"
        case .pariah:
            return "pariah"
        case .fav:
            return "favourites"
        case .mine:
            return "mine"
        }
    }
}
