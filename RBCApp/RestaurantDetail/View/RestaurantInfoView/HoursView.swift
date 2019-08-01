//
//  HoursView.swift
//  RBCApp
//
//  Created by Smitesh Patel on 2019-08-01.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation
import UIKit

final class HoursView: UIView {

    @IBOutlet weak var dailyHoursView: UIStackView!
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var closeLabel: UILabel!
    
    static func create(day: String, open: String, close: String) -> HoursView {
        let hoursView = HoursView.loadFromNib()
        hoursView.configure(day: day, open: open, close: close)
        return hoursView
    }
    
    private func configure(day: String, open: String, close: String) {
        dayLabel.text = day + ":" 
        openLabel.text = open
        closeLabel.text = close
    }
}
