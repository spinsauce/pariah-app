//
//  ResponseDto.swift
//  Pariah
//
//  Created by hi on 11/22/18.
//  Copyright © 2018 rit. All rights reserved.
//

import Foundation

struct ResponseDto: CustomStringConvertible, Codable {
    
    var description: String {
        return "Message: \(message)"
    }
    
    var message: String
}
