//
//  UserService.swift
//  Pariah
//
//  Created by Bernard Radocaj (RIT Student) on 11/21/18.
//  Copyright © 2018 rit. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserService {
    
    static let service = UserService()
    
    func login(username: String, password: String, completionHandler: @escaping (Bool, String) -> Void) {
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let parameters = [
            "jusername": username,
            "jpassword": password
        ]
        let pariahUrl = "\(SessionConfig.basePath)api/login"
        SessionConfig.session.request(pariahUrl, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON {
            response in
            switch response.result {
            case .success:
//                dont forget to remove this
//                print(HTTPCookieStorage.shared.cookies!)
                completionHandler(true, response.description)
                break
            case .failure(let error):
                completionHandler(false, error.localizedDescription)
                break
            }
        }
    }
    
    
    // TODO: Logout function
    
    
    func register(username: String, password: String) {
        let urlString = "\(SessionConfig.basePath)api/user/register"
//        let param: [String: String] = ["username" : "hayyah", "password" : "heyyah123"]
        let param: [String: String] = ["username" : username, "password" : password]
        SessionConfig.session.request(urlString, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil)
            .validate(statusCode: 200..<300)
            .responseJSON {
                    response in
                    switch response.result {
                    case .success:
                        print(response)
                        break
                    case .failure(let error):
                        print(error)
                    }
                }
    }
}
