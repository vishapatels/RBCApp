//
//  RestuarantListViewModel.swift
//  RBCApp
//
//  Created by Visha Shanghvi on 2019-07-27.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation


struct RestaurantListDataProvider {
    
    var name: String
    var imageURL: String
    var id: String
    var rating: Double
    
    init(name: String, imageURL: String, id:String, rating: Double ) {
        self.name = name
        self.imageURL = imageURL
        self.id = id
        self.rating = rating
    }
}

class RestaurantListViewModel {
    private var restaurantList : [RestaurantListDataProvider]?
    
    var numberOfRows: Int {
        return restaurantList?.count ?? 0
    }
    
    func restaurantAtIndex(atIndex index: Int) -> RestaurantListDataProvider? {
        return restaurantList?[index]
    }
    
}

extension RestaurantListViewModel: ManagerInjected {
    
    func getRestaurantListData(completion complete: @escaping(ServiceResult<Bool>) -> Void) {
        restaurantListManager.getRestaurantList { result in
            switch result {
            case .success(let restaurantList):
                self.restaurantList = restaurantList
                complete(.success(true))
            case .failure(let error):
                complete(.failure(.invalidResponse))
            }
        }
    }
}
