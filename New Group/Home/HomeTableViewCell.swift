//
//  HomeTableViewCell.swift
//  Pariah
//
//  Created by Erik Kovacic on 17/11/2018.
//  Copyright © 2018 rit. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var dishUserLabel: UILabel!
    @IBOutlet weak var dishPriceLabel: UILabel!
    @IBOutlet weak var dishLikesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
