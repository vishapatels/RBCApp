//
//  ManagerInjected.swift
//  RBCApp
//
//  Created by Visha Shanghvi on 2019-07-27.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation

protocol ManagerInjected  {}

extension ManagerInjected {
    
    var restaurantListManager: RestaurantListManagerProtocol {
        return ManagerInjector.restaurantListManager
    }
    var restaurantDetailManager: RestaurantDetailManagerProtocol {
        return ManagerInjector.restaurantDetailManager
    }
    
}

struct ManagerInjector {
    static var restaurantListManager: RestaurantListManagerProtocol = RestaurantsListManager()
    static var restaurantDetailManager: RestaurantDetailManagerProtocol = RestaurantsDetailManager()
}
