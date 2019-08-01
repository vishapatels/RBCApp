//
//  RestaurantDetailModel+Extensions.swift
//  RBCApp
//
//  Created by Smitesh Patel on 2019-07-31.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation
import Contacts

typealias OpenHours = (day: String?, start: String?, end: String?)
extension RestaurantDetailModel {
    
    var coordinate: (Double?, Double?) {
        return (coordinates?.latitude, coordinates?.longitude)
    }
    
    var category: String? {
        return categories?.compactMap { $0.title }.joined(separator: ",")
    }
    
    var hourType: String? {
        return hours?.compactMap {$0.hoursType}.joined(separator: ",")
    }
    
    var isOpenNow: Bool {
        return hours?.regularHours?.first?.isOpenNow ?? false
    }
    
    var openHours: [OpenHours]? {
        return hours?.regularHours?.first?.hourOpen?.compactMap {
            return (Date.dayName(for: $0.day ?? 0), $0.formattedStart, $0.formattedEnd)
        }
    }
}

extension Open {
    
    var formattedStart: String {
        return Date.from(timeString: start)?.toFormattedString(format: DateFormat.displayHours) ?? ""
    }
    
    var formattedEnd: String {
        return Date.from(timeString: end)?.toFormattedString(format: DateFormat.displayHours) ?? ""
    }
}

extension Collection where Element == Hour {
    
    var regularHours: [Hour]? {
        return filter { $0.hoursType == "REGULAR"}
    }
}
