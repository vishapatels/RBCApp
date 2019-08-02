//
//  RestaurantInfo.swift
//  RBCApp
//
//  Created by Visha Shanghvi on 2019-07-30.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import UIKit

final class RestaurantInfo: UIView {
    
    @IBOutlet var ratingViewContainer: UIView!
    @IBOutlet var hoursOfOperationStackView: UIStackView!
    @IBOutlet var callButton: UIButton!
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var resZip: UILabel!
    @IBOutlet var resCity: UILabel!
    @IBOutlet var resAddress: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var category: UILabel!
    @IBOutlet var phone: UILabel!
    var phoneNumber: String?
    var didTapCallButton: (() -> Void)?
    
    @IBAction func callButtonAction(_ sender: Any) {
        didTapCallButton?()
    }
    
    static func createInfoView(info: RestaurantDetailDataProvider) -> UIView {
        let infoView: RestaurantInfo = RestaurantInfo.loadFromNib()
        infoView.configureView(info: info)
        return infoView
    }
    
    private var hoursLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private func configureView(info: RestaurantDetailDataProvider) {
        name.text = info.name
        resAddress.text = info.location?.address1
        resCity.text = info.location?.city
        resZip.text = info.location?.zipCode
        category.text = info.category
        callButton.setTitle(info.displayPhone ?? "", for: .normal)
        callButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
        phoneNumber = info.displayPhone
        let ratingView = Rating.create(ratingValue: info.rating)
        ratingViewContainer.addConstraintSubview(ratingView)
        
        info.photos.forEach { str in
            if let url = URL(string: str) {
                let imageView = UIImageView()
                imageView.kf.setImage(with: url)
                imageView.layer.masksToBounds = true
                imageView.layer.cornerRadius = 10
                imageView.contentMode = .scaleAspectFill
                stackView.addArrangedSubview(imageView)
                stackView.translatesAutoresizingMaskIntoConstraints = false
                stackView.distribution = .fillEqually
                stackView.axis = .horizontal
                stackView.spacing = 20
            }
        }
        
        if info.hours.isEmpty {
            let label = UILabel()
            label.text = "Information Not Available"
            label.textAlignment = .center
            hoursOfOperationStackView.addArrangedSubview(label)
        }
        else {
            info.hours.forEach { hours in
                let hoursView = HoursView.create(day: hours.day ?? "", open: hours.start ?? "", close: hours.end ?? "")
                hoursOfOperationStackView.addArrangedSubview(UIView.createView(withSubview: hoursView))
            }
        }
    }
}
