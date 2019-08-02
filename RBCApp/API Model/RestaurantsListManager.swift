//
//  RestaurantsListManager.swift
//  RBCApp
//
//  Created by Visha Shanghvi on 2019-07-27.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation

extension DispatchQueue {
    static let network = DispatchQueue(label: "com.rbc.network")
    static let restuarantManager = DispatchQueue(label: "com.rbc.restaurantManager", attributes: .concurrent, target: .network)
}

protocol RestaurantListManagerProtocol {
    func getRestaurantList(offset: String ,completionHandler complete: @escaping(ServiceResult<[RestaurantListDataProvider]>) -> Void)
}

final class RestaurantsListManager: RestaurantListManagerProtocol {
    
    func getRestaurantList(offset:String, completionHandler complete: @escaping(ServiceResult<[RestaurantListDataProvider]>) -> Void) {
        DispatchQueue.restuarantManager.async {
            APIService.shared.performRequest(router: .getRestaurantsList(term: "delis",location: "toronto",limit: "10",offset: offset), completionHandler: { result in
                switch result {
                case .success(let data):
                    if let data = data, let restaurantList: RestaurantListModel = RestaurantListModel.from(data: data) {
                        DispatchQueue.main.async {
                            complete(.success(restaurantList.businesses!.restaurantListProviders))
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

