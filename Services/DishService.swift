//
//  DishService.swift
//  Pariah
//
//  Created by Bernard Radocaj (RIT Student) on 11/21/18.
//  Copyright © 2018 rit. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DishService {
    
    static let service = DishService()
    
    func fetchTopDishes(completionHandler: @escaping (Bool, [Dish]?) -> Void) {
        let dishUrl = "\(SessionConfig.basePath)dish/top"
        SessionConfig.session.request(dishUrl, method: .get)
            .validate(statusCode: 200..<300)
            .responseJSON() {
            response in
            switch response.result {
            case .success(let value):
                do {
                    let data = try JSON(value)["payload"].rawData()
                    let dishes = try JSONDecoder().decode([Dish].self, from: data)
                    completionHandler(true, dishes)
                } catch {
                    print(error)
                    completionHandler(false, [])
                }
                break
            case .failure(let error):
                print(error)
                completionHandler(false, [])
                break
            }
        }
    }
    
    func fetchDishesByDesignation(which: DishesEnum,  completionHandler: @escaping (Bool, [Dish]?) -> Void) {
        let dishUrl = "\(SessionConfig.basePath)dish/dishes/\(which.value)"
        SessionConfig.session.request(dishUrl, method: .get)
            .validate(statusCode: 200..<300)
            .responseJSON() {
            response in
            switch response.result {
            case .success(let value):
                do {
                    let data = try JSON(value)["payload"].rawData()
                    let dishes = try JSONDecoder().decode([Dish].self, from: data)
                    completionHandler(true, dishes)
                } catch {
                    print(error)
                    completionHandler(false, [])
                }
                break
            case .failure(let error):
                print(error)
                completionHandler(false, [])
                break
            }
        }
    }
    
    func submitDish(dish: Dish, completionHandler: @escaping (Bool, Dish?) -> Void) {
        let dishUrl = "\(SessionConfig.basePath)dish/submit"
        //marshall the dish object into a dictionary, so it could be encoded as JSON        
        let dict = ServiceHelper.marshaller(object: dish)
        SessionConfig.session.request(dishUrl, method: .post, parameters: dict, encoding: JSONEncoding.default, headers: [:])
            .validate(statusCode: 200..<300)
            .responseJSON() {
            response in
            switch response.result {
            case .success(let value):
                do {
                    let data = try JSON(value)["payload"].rawData()
                    let dish = try JSONDecoder().decode(Dish.self, from: data)
                    completionHandler(true, dish)
                } catch {
                    print(error)
                    completionHandler(false, Dish())
                }
                break
            case .failure(let error):
                print(error)
                completionHandler(false, Dish())
                break
            }
        }
    }
    
    func submitDishLike(dishId: Int, completionHandler: @escaping (Bool, Dish?) -> Void) {
        let dishUrl = "\(SessionConfig.basePath)dish/like/\(dishId)"
        SessionConfig.session.request(dishUrl, method: .put)
            .validate(statusCode: 200..<300)
            .responseJSON() {
                response in
                switch response.result {
                case .success(let value):
                    do {
                        let data = try JSON(value)["payload"].rawData()
                        let dish = try JSONDecoder().decode(Dish.self, from: data)
                        completionHandler(true, dish)
                    } catch {
                        print(error)
                        completionHandler(false, Dish())
                    }
                    break
                case .failure(let error):
                    print(error)
                    completionHandler(false, Dish())
                    break
                }
        }
    }
    
}
