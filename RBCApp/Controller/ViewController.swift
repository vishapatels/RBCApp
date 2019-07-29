//
//  ViewController.swift
//  RBCApp
//
//  Created by Visha Shanghvi on 2019-07-27.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var model = RestaurantListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.getRestaurantListData(completion: { [weak self] (result) in
            switch result {
            case .success:
               self?.tableView.reloadData()
            case .failure(let err):
                print(err)
            }
        })
        
//        models.getRestaurantDetailData(id: "LiY0vRXMWrjUrXQr2Z_D4A", completion: { [weak self] (result) in
//            switch result {
//            case .success(let restaurantList):
//                print(restaurantList)
//            case .failure(let err):
//                print(err)
//            }
//        })
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantList", for: indexPath) as! RestaurantListCell
        cell.name.text = model.restaurantAtIndex(atIndex: indexPath.row)?.name
        if let url = URL(string: model.restaurantAtIndex(atIndex: indexPath.row)?.imageURL ?? "NA") {
            cell.restaurantImage.kf.setImage(with: url)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailList: RestaurantDetailViewController
        detailList  = storyboard?.instantiateViewController(withIdentifier: "DetailList") as! RestaurantDetailViewController
        detailList.id = model.restaurantAtIndex(atIndex: indexPath.row)?.id ?? 0
        navigationController?.pushViewController(detailList, animated: true)
    }
}

