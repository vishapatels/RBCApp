//
//  RestaurantDetailViewModel.swift
//  RBCApp
//
//  Created by Visha Shanghvi on 2019-07-28.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation
class RestaurantDetailViewModel: ManagerInjected {
    
    func getRestaurantDetailData(id:String, completion complete: @escaping(ServiceResult<RestaurantDetailModel>) -> Void) {
        restaurantDetailManager.getRestaurantDetail(id: id) {  result in
            switch result {
            case .success(let restaurantList):
                complete(.success(restaurantList))
            case .failure(let error):
                complete(.failure(.invalidResponse))
            }
        }
    }
}
