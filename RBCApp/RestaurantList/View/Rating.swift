//
//  Rating.swift
//  RBCApp
//
//  Created by Visha Shanghvi on 2019-08-02.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import UIKit

class Rating: UIView {

    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star1: UIImageView!
    let fullStarImage:  UIImage = UIImage(named: "starFull.png")!
    let halfStarImage:  UIImage = UIImage(named: "starHalf.png")!
    let emptyStarImage: UIImage = UIImage(named: "starEmpty.png")!
    
    static func create(ratingValue: Double) -> Rating {
        let rating = Rating.loadFromNib()
        rating.configure(ratingValue: ratingValue)
        return rating
    }
    
    private func configure(ratingValue: Double) {
        for (index, imageView) in [star1, star2, star3, star4, star5].enumerated() {
            imageView?.image = getStarImage(starNumber: Double(index + 1), forRating: ratingValue)
        }
    }
    
    private func getStarImage(starNumber: Double, forRating rating: Double) -> UIImage {
        if rating >= starNumber {
            return fullStarImage
        } else if rating + 0.5 == starNumber {
            return halfStarImage
        } else {
            return emptyStarImage
        }
    }
}
