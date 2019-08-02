//
//  RestaurantDetailViewModel.swift
//  RBCApp
//
//  Created by Visha Shanghvi on 2019-07-28.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation
import UIKit

struct RestaurantDetailDataProvider {
    
    var name: String
    var imageURL: String
    var id: String
    var rating: Double
    var phone, displayPhone: String?
    var location: Location
    var category: String
    var hourType: String
    var photos:[String]
    var hours: [OpenHours]
    var isOpen: Bool
    
    init(name: String, imageURL: String, id:String, rating: Double, phone:String, displayPhone:String, location: Location, category:String, hourType:String, photos:[String], hours: [OpenHours], isOpen: Bool) {
        self.name = name
        self.imageURL = imageURL
        self.id = id
        self.rating = rating
        self.phone = phone
        self.displayPhone = displayPhone
        self.location = location
        self.category = category
        self.hourType = hourType
        self.photos = photos
        self.hours = hours
        self.isOpen = isOpen
    }
}

final class RestaurantDetailViewModel {
    
    var restaurantDetailModel: RestaurantDetailModel?
    
    var coordinates: Coordinates? {
        return restaurantDetailModel?.coordinates
    }
    
    var resInfo: RestaurantDetailDataProvider {
        
        return (RestaurantDetailDataProvider(name: restaurantDetailModel?.name ?? "", imageURL: restaurantDetailModel?.imageURL ?? "", id: restaurantDetailModel?.id ?? "", rating: restaurantDetailModel?.rating ?? 0, phone: restaurantDetailModel?.phone ?? "", displayPhone: restaurantDetailModel?.displayPhone ?? "0", location: (restaurantDetailModel?.location)!, category: restaurantDetailModel?.category ?? "", hourType: restaurantDetailModel?.hourType ?? "",photos: restaurantDetailModel?.photos ?? [""], hours: (restaurantDetailModel?.openHours)!, isOpen: restaurantDetailModel?.isOpenNow ?? false))
    }
    
}

extension RestaurantDetailViewModel:ManagerInjected {
    
    func getRestaurantDetailData(id:String, completion complete: @escaping(ServiceResult<RestaurantDetailModel>) -> Void) {
        restaurantDetailManager.getRestaurantDetail(id: id) {  [weak self] result in
            switch result {
            case .success(let restaurantDetails):
                self?.restaurantDetailModel = restaurantDetails
                complete(.success(restaurantDetails))
            case .failure(let error):
                complete(.failure(.invalidResponse))
            }
        }
    }
}
