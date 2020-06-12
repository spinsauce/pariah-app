//
//  OrderService.swift
//  Pariah
//
//  Created by Bernard Radocaj (RIT Student) on 11/26/18.
//  Copyright © 2018 rit. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class OrderService {
    
    static var service = OrderService()
    
    func submitOrder(dict: [String: Any], completionHandler: @escaping (Bool, Order) -> Void) {
        let orderUrl = "\(SessionConfig.basePath)order/submit"
        SessionConfig.session.request(orderUrl, method: .post, parameters: dict, encoding: JSONEncoding.default, headers: [:])
            .validate(statusCode: 200..<300)
            .responseJSON() {
                response in
                switch response.result {
                case .success(let value):
                    do {
                        let data = try JSON(value)["payload"].rawData()
                        let order = try JSONDecoder().decode(Order.self, from: data)
                        completionHandler(true, order)
                    } catch {
                        print(error)
                        completionHandler(false, Order())
                    }
                    break
                case .failure(let error):
                    print(error)
                    completionHandler(false, Order())
                    break
                }
        }
    }
}
