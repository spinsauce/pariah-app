//
//  SessionManager.swift
//  Pariah
//
//  Created by Bernard Radocaj (RIT Student) on 11/21/18.
//  Copyright © 2018 rit. All rights reserved.
//

import Foundation
import Alamofire

struct SessionConfig {
//    campus ip.
    static let ip: String = "10.0.23.11"
    
//    what do you think
//    static let ip: String = "localhost"
    
    static let port: String = "14822"
    
    static let basePath: String = "http://\(SessionConfig.ip):\(SessionConfig.port)/"
    
    static let session = Alamofire.SessionManager.default
}
