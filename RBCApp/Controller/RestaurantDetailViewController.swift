//
//  RestaurantDetailViewController.swift
//  RBCApp
//
//  Created by Visha Shanghvi on 2019-07-29.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    var id: String = ""
    var model = RestaurantDetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        model.getRestaurantDetailData(id: id, completion: { [weak self] (result) in
           switch result {
            case .success(let restaurantList):
               print(restaurantList)
           case .failure(let err):
                print(err)
            }
        })
    }
}
