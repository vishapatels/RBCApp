//
//  RestaurantListModel.swift
//  RBCApp
//
//  Created by Visha Shanghvi on 2019-07-27.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation
struct RestaurantDetailModel: CoreServiceCodable {
    var id, alias, name: String?
    var imageURL: String?
    var isClaimed, isClosed: Bool?
    var url: String?
    var phone, displayPhone: String?
    var reviewCount: Int?
    var categories: [Category]?
    var rating: Double?
    var location: Location?
    var coordinates: Coordinates?
    var photos: [String]?
    var price: String?
    var hours: [Hour]?
    var transactions: [String]?
    var messaging: Messaging?
    var specialHours: [SpecialHour]?
    
    enum CodingKeys: String, CodingKey {
        case id, alias, name
        case imageURL = "image_url"
        case isClaimed = "is_claimed"
        case isClosed = "is_closed"
        case url, phone
        case displayPhone = "display_phone"
        case reviewCount = "review_count"
        case categories, rating, location, coordinates, photos, price, hours, transactions, messaging
        case specialHours = "special_hours"
    }
}

struct Category: CoreServiceCodable {
    var alias, title: String?
}

struct Coordinates: CoreServiceCodable {
    var latitude, longitude: Double?
}

struct Hour: CoreServiceCodable {
    var hourOpen: [Open]?
    var hoursType: String?
    var isOpenNow: Bool?
    
    enum CodingKeys: String, CodingKey {
        case hourOpen = "open"
        case hoursType = "hours_type"
        case isOpenNow = "is_open_now"
    }
}

struct Open: CoreServiceCodable {
    var isOvernight: Bool?
    var start, end: String?
    var day: Int?
    
    enum CodingKeys: String, CodingKey {
        case isOvernight = "is_overnight"
        case start, end, day
    }
}


struct Location: CoreServiceCodable {
    var address1, address2, address3, city: String?
    var zipCode, country, state: String?
    var displayAddress: [String]?
    var crossStreets: String?
    
    enum CodingKeys: String, CodingKey {
        case address1, address2, address3, city
        case zipCode = "zip_code"
        case country, state
        case displayAddress = "display_address"
        case crossStreets = "cross_streets"
    }
}

struct SpecialHour: Codable {
    let date: String?
    let isClosed: Bool?
    let start, end, isOvernight: JSONNull?
    
    enum CodingKeys: String, CodingKey {
        case date
        case isClosed = "is_closed"
        case start, end
        case isOvernight = "is_overnight"
    }
}

struct Messaging: CoreServiceCodable {
    let url: String?
    let useCaseText: String?
    
    enum CodingKeys: String, CodingKey {
        case url
        case useCaseText = "use_case_text"
    }
}
