//
//  RBCAppTests.swift
//  RBCAppTests
//
//  Created by Smitesh Patel on 2019-07-31.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import XCTest

@testable import RBCApp

class RBCAppTests: XCTestCase {

    func testOpen() {
        var open = Open()
        open.day = 0
        var text = Date.dayName(for: open.day ?? 0)
        XCTAssertEqual("Sunday", text)
        open.day = 1
        text = Date.dayName(for: open.day ?? 0)
        XCTAssertEqual("Monday", text)
        open.day = 2
        text = Date.dayName(for: open.day ?? 0)
        XCTAssertEqual("Tuesday", text)
        open.day = 3
        text = Date.dayName(for: open.day ?? 0)
        XCTAssertEqual("Wednesday", text)
        open.day = 4
        text = Date.dayName(for: open.day ?? 0)
        XCTAssertEqual("Thursday", text)
        open.day = 5
        text = Date.dayName(for: open.day ?? 0)
        XCTAssertEqual("Friday", text)
        open.day = 6
        text = Date.dayName(for: open.day ?? 0)
        XCTAssertEqual("Saturday", text)
        
        open.start = "1000"
        text = open.formattedStart
        XCTAssertEqual("10:00 AM", text)
        
        open.end = "1730"
        text = open.formattedEnd
        XCTAssertEqual("5:30 PM", text)
        
        open.end = "2200"
        text = open.formattedEnd
        XCTAssertEqual("10:00 PM", text)
    }

}
