//
//  Date+Extensions.swift
//  RBCApp
//
//  Created by Visha Shanghvi on 2019-07-31.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation

enum DateStyleType {
    case short //6/10/13
    case medium //Jun 10, 2013
    case long //June 10, 2013
    case time
}

enum DateFormat: String {
    case billingCycle = "dMMM"
    case displayHours = "hh:mm a"
    case serverHours = "HHmm"
}

enum DateComponentType {
    case day
    case month
}

enum TimeZoneType: String {
    case est = "EST"
}

enum LocaleType: String {
    case en_us_posix = "en_US_POSIX"
}

extension Date {
    
    private static let dateFormatter: DateFormatter = {
        let instance = DateFormatter()
        instance.locale = Locale.current
        return instance
    }()
    
    static func from(timeString: String?) -> Date? {
        guard let timeString = timeString else { return nil }
        Date.dateFormatter.dateFormat = DateFormat.serverHours.rawValue
        return Date.dateFormatter.date(from: timeString)
    }
    
    private func toFormattedString(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        Date.dateFormatter.dateStyle = dateStyle
        Date.dateFormatter.timeStyle = timeStyle
        return Date.dateFormatter.string(from: self)
    }
    
    var day: Int {
        let cal = Calendar.current
        return cal.component(.day, from: self)
    }
    
    var month: Int {
        let cal = Calendar.current
        return cal.component(.month, from: self)
    }
    
    var year: Int {
        let cal = Calendar.current
        return cal.component(.year, from: self)
    }
    
    static func dayName(for day:Int) -> String {
        return DateFormatter().weekdaySymbols[day]
    }
    
    func beginningOfMonth(monthOffSet: Int) -> Date {
        return (adjustComponent(.month, offset: -monthOffSet)?.adjustComponent(.day, offset: -(self.day - 1))) ?? self
    }
    
    func adjustComponent(_ component: DateComponentType, offset: Int) -> Date? {
        var dateComp = DateComponents()
        switch component {
        case .day:
            dateComp.day = offset
        case .month:
            dateComp.month = offset
        }
        return Calendar.current.date(byAdding: dateComp, to: self)
    }
    
    func toFormattedString(style: DateStyleType) -> String {
        switch style {
        case .short:
            return toFormattedString(dateStyle: .short, timeStyle: .none)
        case .medium:
            return toFormattedString(dateStyle: .medium, timeStyle: .none)
        case .long:
            return toFormattedString(dateStyle: .long, timeStyle: .none)
        case .time:
            return toFormattedString(dateStyle: .none, timeStyle: .short)
        }
    }
    
    func toFormattedString(format: DateFormat) -> String {
        let dateFormatter = Date.dateFormatter
        dateFormatter.setLocalizedDateFormatFromTemplate(format.rawValue)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.string(from: self)
    }
    
    func toFormattedDateAndTimeString(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        return toFormattedString(dateStyle: dateStyle, timeStyle: timeStyle)
    }
    
    func daysSinceReference(_ timeInterval: TimeInterval) -> Int {
        let startDate = Date(timeIntervalSinceReferenceDate: timeInterval)
        let components: Set<Calendar.Component> = [.day]
        return Calendar.current.dateComponents(components, from: startDate, to: self).day ?? 0
    }
    
    func daysSince(startDate: Date) -> Int? {
        return Calendar.current.dateComponents([.day], from: startDate, to: self).day
    }
}
