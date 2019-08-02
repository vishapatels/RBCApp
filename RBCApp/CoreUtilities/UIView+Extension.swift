//
//  UIView+Extension.swift
//  RBCApp
//
//  Created by Visha Shanghvi on 2019-07-29.
//  Copyright © 2019 Visha Shanghvi. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    
    public func addConstraintSubview(_ view: UIView, edgeInset: UIEdgeInsets = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        view.topAnchor.constraint(equalTo: topAnchor, constant: edgeInset.top).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: edgeInset.bottom).isActive = true
        view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: edgeInset.left).isActive = true
        view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: edgeInset.right).isActive = true
    }

    static func autolayoutView<T>() -> T where T: UIView {
        let view = T()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    static func createView(withSubview view: UIView, edgeInsets: UIEdgeInsets = .zero, backgroundColor: UIColor = .white) -> UIView {
        let newView = autolayoutView()
        newView.backgroundColor = backgroundColor
        newView.addConstraintSubview(view, edgeInset: edgeInsets)
        return newView
    }
    
}

