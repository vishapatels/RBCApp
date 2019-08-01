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
    let fullStarImage:  UIImage = UIImage(named: "starFull.png")!
    let halfStarImage:  UIImage = UIImage(named: "starHalf.png")!
   // let emptyStarImage: UIImage = UIImage(named: "starEmpty.png")!
    private var restaurantList : [RestaurantListDataProvider]?
    
    var numberOfRows: Int {
        return restaurantList?.count ?? 0
    }
    
    func restaurantAtIndex(atIndex index: Int) -> RestaurantListDataProvider? {
        return restaurantList?[index]
    }
    
    func sortAsc(sortValue: String?) {
         sortValue == "Ascending" ? restaurantList?.sort(by: { $0.name.lowercased() < $1.name.lowercased() }) :
        restaurantList?.sort(by: { $0.name.lowercased() > $1.name.lowercased() })
    
    }
    func getStarImage(starNumber: Double, forRating rating: Double) -> UIImage {
        if rating >= starNumber {
            return fullStarImage
        } else if rating + 0.5 == starNumber {
            return halfStarImage
        } else {
            return halfStarImage
        }
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
