//
//  CommentsService.swift
//  Pariah
//
//  Created by Erik Kovacic on 08/12/2018.
//  Copyright © 2018 rit. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CommentsService {
    
    static var service = CommentsService()
    
    func fetchComments(dishId: Int, completionHandler: @escaping (Bool, [Comment]) -> Void) {
        let commentsUrl = "\(SessionConfig.basePath)comment?dishId=\(dishId)"
        SessionConfig.session.request(commentsUrl, method: .get)
            .validate(statusCode: 200..<300)
            .responseJSON() {
                response in
                switch response.result {
                case .success(let value):
                    do {
                        let data = try JSON(value)["payload"].rawData()
                        let comments = try JSONDecoder().decode([Comment].self, from: data)
                        completionHandler(true, comments)
                    } catch {
                        print(error)
                        completionHandler(false, [])
                    }
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    func submitComment(dict: [String: Any], completionHandler: @escaping (Bool, Comment) -> Void) {
        let commentUrl = "\(SessionConfig.basePath)comment/submit"
        SessionConfig.session.request(commentUrl, method: .post, parameters: dict, encoding: JSONEncoding.default, headers: [:])
            .validate(statusCode: 200..<300)
            .responseJSON() {
                response in
                switch response.result {
                case .success(let value):
                    do {
                        let data = try JSON(value)["payload"].rawData()
                        let comment = try JSONDecoder().decode(Comment.self, from: data)
                        completionHandler(true, comment)
                    } catch {
                        print(error)
                        completionHandler(false, Comment())
                    }
                    break
                case .failure(let error):
                    print(error)
                    break
                }
        }
    }
}
