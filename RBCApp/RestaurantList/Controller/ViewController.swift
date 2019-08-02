//
//  ViewController.swift
//  RBCApp
//
//  Created by Visha Shanghvi on 2019-07-27.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import UIKit
import Kingfisher

enum SortType: String {

    case ascending = "Ascending"
    case descending = "Descending"
    case rating
}

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var pickerData: [String] = [String]()
    var model = RestaurantListViewModel()
    var sortValue: String?
    var rating: Double = 0.0
    var offset:String = "1"
    var pageIndex: Int = 1
    var isSearching: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        showLoadingView()
        model.getRestaurantListData(offset: offset , completion: { [weak self] (result) in
            self?.removeLoadingView()
            switch result {
            case .success:
               self?.tableView.reloadData()
            case .failure(let err):
                print(err)
            }
        })
    }
    
    @IBAction func sortButtonTapped(_ sender: Any) {
        
       let optionMenu = UIAlertController(title: nil, message: "Choose Sorting Option", preferredStyle: .actionSheet)
        let ascendingAction = UIAlertAction(title: "Ascending", style: .default){ action -> Void in
            self.model.sortRestaurantList(sortValue: .ascending)
            self.tableView.reloadData()
        }
        
        let descendingAction = UIAlertAction(title: "Descending", style: .default){ action -> Void in
            self.model.sortRestaurantList(sortValue: .descending)
            self.tableView.reloadData()
        }
        
        let ratingAction = UIAlertAction(title: "By Ratings", style: .default){ action -> Void in
            self.model.sortRestaurantList(sortValue: .rating)
            self.tableView.reloadData()
        }
        
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        optionMenu.addAction(ascendingAction)
        optionMenu.addAction(descendingAction)
        optionMenu.addAction(ratingAction)
        optionMenu.addAction(cancelAction)
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantList", for: indexPath) as! RestaurantListCell
        cell.name.text = model.restaurantAtIndex(atIndex: indexPath.row)?.name
        cell.configureRating(ratingValue: model.restaurantAtIndex(atIndex: indexPath.row)?.rating ?? 0.0)
        if let url = URL(string: model.restaurantAtIndex(atIndex: indexPath.row)?.imageURL ?? "NA") {
            cell.restaurantImage.kf.setImage(with: url)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailList: RestaurantDetailViewController
        detailList  = storyboard?.instantiateViewController(withIdentifier: "DetailList") as! RestaurantDetailViewController
        detailList.id = model.restaurantAtIndex(atIndex: indexPath.row)?.id ?? ""
        navigationController?.pushViewController(detailList, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if maximumOffset - currentOffset <= 10.0 {
            pageIndex = pageIndex + 1 * 10
            showLoadingView()
            model.getRestaurantListData(offset: String(pageIndex) ,completion: { [weak self] (result) in
                self?.removeLoadingView()
                switch result {
                case .success:
                    self?.tableView.reloadData()
                    self?.pageIndex += 1
                case .failure(let err):
                    print(err)
                }
            })
        }
    }
    
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        model.searchRestaurantList(text: searchText)
        tableView.reloadData()
    }
   
}

extension ViewController {
    func showStars() {
        
    }
}


