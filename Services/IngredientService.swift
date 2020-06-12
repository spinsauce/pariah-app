//
//  IngredientService.swift
//  Pariah
//
//  Created by Bernard Radocaj (RIT Student) on 11/21/18.
//  Copyright © 2018 rit. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class IngredientService {
    
    static let service = IngredientService()
    
    func fetchIngredientTypes(completionHandler: @escaping (Bool, [String]?) -> Void) {
        let ingredientUrl = "\(SessionConfig.basePath)ingredient/types"
        SessionConfig.session.request(ingredientUrl, method: .get)
            .validate(statusCode: 200..<300)
            .responseJSON() {
            response in
            switch response.result {
            case .success(let value):
                let listOfIngredientTypes = JSON(value)["payload"].arrayValue.map({$0.stringValue})
                completionHandler(true, listOfIngredientTypes)
            case .failure( _):
                completionHandler(false, [])
            }
        }
    }
    
    func searchIngredients(searchTerm: String, type: String = "all", completionHandler: @escaping (Bool, [Ingredient]?) -> Void) {
        let ingredientUrl = "\(SessionConfig.basePath)ingredient/search?type=\(type)&name=\(searchTerm)"
        SessionConfig.session.request(ingredientUrl, method: .get)
            .validate(statusCode: 200..<300)
            .responseJSON() {
            response in
            switch response.result {
            case .success(let value):
                do {
                    let data = try JSON(value)["payload"].rawData()
                    let ingredients = try JSONDecoder().decode([Ingredient].self, from: data)
                    completionHandler(true, ingredients)
                } catch {
                    print(error)
                    completionHandler(false, [])
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //fetches random ingredients from the db 
    func fetchRandomIngredients(ingredientAmount: Int = 5, completionHandler: @escaping (Bool, [Ingredient]?) -> Void) {
        let ingredientUrl = "\(SessionConfig.basePath)ingredient/random?ingredientAmount=\(ingredientAmount)"
        SessionConfig.session.request(ingredientUrl, method: .get)
            .validate(statusCode: 200..<300)
            .responseJSON() {
            response in
            switch response.result {
            case .success(let value):
                do {
                    let data = try JSON(value)["payload"].rawData()
                    let ingredients = try JSONDecoder().decode([Ingredient].self, from: data)
                    completionHandler(true, ingredients)
                } catch {
                    print(error)
                    completionHandler(false, [])
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

