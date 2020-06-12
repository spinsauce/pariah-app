//
//  CommentsTableViewController.swift
//  Pariah
//
//  Created by Erik Kovacic on 08/12/2018.
//  Copyright © 2018 rit. All rights reserved.
//

import UIKit

class CommentsTableViewController: UITableViewController {

    @IBOutlet weak var inputComment: UITextField!
    
    var dishId: Int = 0
    var comments: [Comment] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // request comments by id, store into comments var
        CommentsService.service.fetchComments(dishId: dishId, completionHandler: {
            success, comments in
            if success {
                self.comments = comments
                self.tableView.reloadData()
           
            } else {
                InfoHelper.showAlert(title: "Alert", message: "There are no comments for this dish, sry for taking you here.", view: self, buttonTitle: "uhh")
            }
        })
    }
    
    @IBAction func postCommentTapped(_ sender: UIButton) {
        guard let comment = inputComment.text else {
            return
        }
        
        let dict: [String: Any] = ["dishId": dishId, "comment": comment]
        
        CommentsService.service.submitComment(dict: dict, completionHandler: {
            success, comment in
            if success {
                InfoHelper.showAlert(title: "Success", message: "You comment has been added!", view: self, buttonTitle: "Ok")
                self.comments.append(comment)
                self.tableView.reloadData()
                self.inputComment.text = ""
            } else {
                InfoHelper.showAlert(title: "Error", message: "Something went wrong with adding your comment", view: self, buttonTitle: "Ok")
            }
        })
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath)

        let comment = comments[indexPath.row]
        
        cell.textLabel?.text = String(format: "'%@'", comment.content)
        
        guard let username = comment.user?.username else {
            return UITableViewCell()
        }
        
        cell.detailTextLabel?.text = "By \(username)"
        
        return cell
    }
}
