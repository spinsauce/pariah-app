//
//  ServiceHelper.swift
//  Pariah
//
//  Created by hi on 11/25/18.
//  Copyright © 2018 rit. All rights reserved.
//

import Foundation
import SwiftyJSON

class ServiceHelper {
    
    // marshalls a encodable (codable) entity into a string any dictionary
    static func marshaller<T: Encodable>(object: T) -> [String:Any] {
        var dict: [String: Any] = [:]
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(object)
            let dictionary = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)
            if let dictionary = dictionary as? [String: Any] {
                dict = dictionary
            }
        }catch {
            print(error)
        }
        return dict
    }
}
