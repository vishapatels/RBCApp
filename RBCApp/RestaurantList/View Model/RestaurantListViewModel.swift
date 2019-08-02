//
//  RestuarantListViewModel.swift
//  RBCApp
//
//  Created by Visha Shanghvi on 2019-07-27.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation
import UIKit

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
    
    var searchRestaurant = [String]()
    private var restaurantList : [RestaurantListDataProvider] = []
    private var restaurantListArray :[RestaurantListDataProvider] = []
   
   
    var numberOfRows: Int {
        return restaurantListArray.count
    }
    
    func restaurantAtIndex(atIndex index: Int) -> RestaurantListDataProvider? {
        return restaurantListArray[index]
    }
    
    func sortRestaurantList(sortValue: String?) {
         sortValue == sortType.ascending.rawValue ? restaurantListArray.sort(by: { $0.name.lowercased() < $1.name.lowercased() }) :
        restaurantListArray.sort(by: { $0.name.lowercased() > $1.name.lowercased() })
        
    }
    
    func sortRestaurantListbyRating() {
        restaurantListArray.sort(by: { $0.rating > $1.rating } )
    }
    
    func searchRestaurantList(text: String) {
        restaurantListArray =  !text.isEmpty ? restaurantList.search(text: text) : restaurantList
    }
    
    
}

extension RestaurantListViewModel: ManagerInjected {
    
    func getRestaurantListData(offset:String, completion complete: @escaping(ServiceResult<Bool>) -> Void) {
        restaurantListManager.getRestaurantList(offset: offset) { result in
            switch result {
            case .success(let restaurantList):
                self.restaurantList.append(contentsOf: restaurantList)
                self.restaurantListArray  = self.restaurantList
                complete(.success(true))
            case .failure(let error):
                complete(.failure(.invalidResponse))
            }
        }
    }
}

extension Collection where Element == RestaurantListDataProvider {
    
    func search(text: String) -> [RestaurantListDataProvider] {
        return filter { restaurantData in
            return restaurantData.name.lowercased().contains(text.lowercased())
        }
    }
}
