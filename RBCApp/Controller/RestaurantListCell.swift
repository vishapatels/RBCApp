//
//  RestaurantListCell.swift
//  RBCApp
//
//  Created by Visha Shanghvi on 2019-07-28.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import UIKit

class RestaurantListCell: UITableViewCell {

    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        restaurantImage.layer.masksToBounds = true
        restaurantImage.layer.cornerRadius = 10
    }
}
