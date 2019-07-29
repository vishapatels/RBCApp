//
//  Collection+Extension.swift
//  RBCApp
//
//  Created by Visha Shanghvi on 2019-07-27.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation

extension Collection where Element == Business {
    
    var restaurantListProviders: [RestaurantListDataProvider] {
        return compactMap { result in
            RestaurantListDataProvider(name: result.name!, imageURL: result.imageURL!, id: result.id!, rating: result.rating!)
        }
    }
}


