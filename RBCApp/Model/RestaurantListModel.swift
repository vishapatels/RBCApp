//
//  RestaurantListModel.swift
//  RBCApp
//
//  Created by Visha Shanghvi on 2019-07-27.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation

struct RestaurantListModel: CoreServiceCodable {
    let businesses: [Business]?
    let total: Int?
    let region: Region?
}

struct Business: CoreServiceCodable {
    var id, alias, name: String?
    var imageURL: String?
    var isClosed: Bool?
    var url: String?
    var reviewCount: Int?
    var categories: [Categories]?
    var rating: Double?
    var coordinates: Center?
    var transactions: [String]?
    var price: String?
    var location: Locations?
    var phone, displayPhone: String?
    var distance: Double?
    
    enum CodingKeys: String, CodingKey {
        case id, alias, name
        case imageURL = "image_url"
        case isClosed = "is_closed"
        case url
        case reviewCount = "review_count"
        case categories, rating, coordinates, transactions, price, location, phone
        case displayPhone = "display_phone"
        case distance
    }
}

struct Categories: CoreServiceCodable {
    var alias, title: String?
}

struct Center: CoreServiceCodable {
    var latitude, longitude: Double?
}

struct Locations: CoreServiceCodable {
    var address1: String?
    var address2, address3: String?
    var city: String?
    var zipCode: String?
    var country: String?
    var state: String?
    var displayAddress: [String]?
    
    enum CodingKeys: String, CodingKey {
        case address1, address2, address3, city
        case zipCode = "zip_code"
        case country, state
        case displayAddress = "display_address"
    }
}

struct Region: CoreServiceCodable {
    var center: Center?
}
