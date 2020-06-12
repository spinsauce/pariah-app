//
//  CartViewController.swift
//  Pariah
//
//  Created by Erik Kovacic on 29/11/2018.
//  Copyright © 2018 rit. All rights reserved.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var data: [Dish] {
        return OrderManager.instance.dishes
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        totalPriceLabel.text = String(format: "Total: $%.2f", OrderManager.instance.totalPrice)
        
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DishCell", for: indexPath)
        
        let dish = data[indexPath.row]
        
        cell.textLabel?.text = dish.name
        cell.detailTextLabel?.text = String(format: "Price: %.2f", dish.price)
        
        return cell
    }
    
    func updatePrice() {
        totalPriceLabel.text = String(format: "Total: $%.2f", OrderManager.instance.totalPrice)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.updatePrice()
        self.tableView.reloadData()
    }
    
    @IBAction func clearItemsTapped(_ sender: UIButton) {
        OrderManager.instance.dishes = []
        OrderManager.instance.dishIds = []
        self.updatePrice()
        tableView.reloadData()
    }
    
    @IBAction func placeOrderTapped(_ sender: UIButton) {
        var orderDict: [String: Any] = [:]
        
        guard let address = addressTextField.text else {
            return
        }

        if !address.isEmpty {
            orderDict["deliveryAddress"] = address
            orderDict["dishes"] = OrderManager.instance.dishIds
            
            OrderService.service.submitOrder(dict: orderDict, completionHandler: {
                success, order in
                if success {
                    InfoHelper.showAlert(title: "Success", message: String(format: "You have successfully placed your order with a total of $%.2f", OrderManager.instance.totalPrice), view: self, buttonTitle: "Ok")
                } else {
                    InfoHelper.showAlert(title: "Failed", message: String(format: "Something went wrong with placing your order. There aren't any dishes.", OrderManager.instance.totalPrice), view: self, buttonTitle: "Ok")
                }
            })
        } else {
            InfoHelper.showAlert(title: "Alert", message: "You must provide an address!", view: self, buttonTitle: "Ok")
        }
    }
}
