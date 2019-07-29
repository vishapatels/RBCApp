//
//  RestaurantDetailManager.swift
//  RBCApp
//
//  Created by Visha Shanghvi on 2019-07-28.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation
protocol RestaurantDetailManagerProtocol {
    func getRestaurantDetail(id: String,completionHandler complete: @escaping(ServiceResult<RestaurantDetailModel>) -> Void)
}

final class RestaurantsDetailManager: RestaurantDetailManagerProtocol {
    
    func getRestaurantDetail(id: String , completionHandler complete: @escaping(ServiceResult<RestaurantDetailModel>) -> Void) {
        DispatchQueue.restuarantManager.async {
            APIService.shared.performRequest(router: .getRestaurantDetail(id: id), completionHandler: { result in
                switch result {
                case .success(let data):
                    if let data = data, let restaurantList: RestaurantDetailModel = RestaurantDetailModel.from(data: data) {
                        DispatchQueue.main.async {
                            complete(.success(restaurantList))
                        }
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        complete(.failure(error))
                    }
                }
            })
        }
    }
}

