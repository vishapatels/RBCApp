//
//  RestaurantDetailViewController.swift
//  RBCApp
//
//  Created by Visha Shanghvi on 2019-07-29.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import UIKit
import Foundation

class RestaurantDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    var id: String = ""
    var model = RestaurantDetailViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInsetAdjustmentBehavior = .never
        model.getRestaurantDetailData(id: id, completion: { [weak self] (result) in
           switch result {
            case .success(let restaurantList):
               print(restaurantList)
                self?.configureStackView()
           case .failure(let err):
                print(err)
            }
        })
    }
}
extension RestaurantDetailViewController {
    
    private func configureStackView() {
        addMapView(lat: model.coordinates?.latitude ?? 0, long: model.coordinates?.longitude ?? 0, name: model.resInfo.name)
        addInfoView(info: model.resInfo )
    }
    
    private func addMapView(lat: Double, long: Double, name: String) {
        let mapView = MapView.createMapView(lat: lat, long: long, name: name)
        stackView.addArrangedSubview(UIView.createView(withSubview: mapView))
    }
    
    private func addInfoView(info: RestaurantDetailDataProvider) {
        let infoView: RestaurantInfo = RestaurantInfo.createInfoView(info: info) as! RestaurantInfo
        infoView.didTapCallButton = { [unowned self] in
            self.makeAPhoneCall(number: info.phone ?? "")
        }
        stackView.addArrangedSubview(UIView.createView(withSubview: infoView))
    }
    
    private func makeAPhoneCall(number: String)  {
        guard let url = URL(string: "tel://\(number)") else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
