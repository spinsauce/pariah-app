//
//  DishDetailTableViewController.swift
//  Pariah
//
//  Created by Erik Kovacic on 28/11/2018.
//  Copyright © 2018 rit. All rights reserved.
//

import UIKit

class DishDetailTableViewController: UITableViewController {

    var dish: Dish?
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var dishImage: UIImageView!
    @IBOutlet weak var dishIngredientsLabel: UILabel!
    @IBOutlet weak var dishPriceLabel: UILabel!
    
    @IBOutlet weak var listOfCommentsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        populateTableView()
    }
    

    // Setting values for labels in a seperate function because tableView.reloadData() does not work
    // Because they aren't dynamic cells
    func populateTableView() {
        
        guard let dish = self.dish else {
            return
        }
        
        dishNameLabel.text = dish.name
        dishImage.image = UIImage(named: "food-placeholder.png")
        dishIngredientsLabel.text = String(format: "List of ingredients: %@", dish.listOfIngredients)
        dishPriceLabel.text = String(format: "Price: $%.2f", dish.price)
        likeButton.setTitle(String(format: "Like\t (%d)", dish.likes), for: .normal)
    }
    
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        
        guard let dish = self.dish else {
            return
        }
        
        DishService.service.submitDishLike(dishId: dish.dishId, completionHandler: {
            success, dish in
            if success {
                if let returnDish = dish {
                    self.dish = returnDish
                    self.populateTableView()
                    InfoHelper.showAlert(title: "Success", message: "Dish liked!", view: self, buttonTitle: "Ok")
                }
            } else {
                InfoHelper.showAlert(title: "Alert", message: "You have already liked this dish! ", view: self, buttonTitle: "Ok")
            }
        })
    }
    
    @IBAction func orderButtonTapped(_ sender: UIButton) {
        
        guard let item = self.dish else {
            return
        }
        
        OrderManager.instance.dishIds.append(item.dishId)
        OrderManager.instance.dishes.append(item)
        
        InfoHelper.showAlert(title: "Success", message: "You have successfully added \(item.name) to your cart.", view: self, buttonTitle: "Ok")
    }
    
    @IBAction func commentsTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ShowComments", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let commentsVC = segue.destination as? CommentsTableViewController {
            if let dishId = self.dish?.dishId {
                commentsVC.dishId = dishId
            }
        }
    }
}
