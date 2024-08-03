//
//  UIView+ext.swift
//  ToDo List
//
//  Created by Nebula on 03.08.24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
