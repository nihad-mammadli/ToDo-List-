//
//  UIHelper.swift
//  ToDo List
//
//  Created by Nebula on 14.07.24.
//

import UIKit

enum UIHelper {
    static func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 10, right: 15)
        layout.scrollDirection = .vertical
        return layout
    }
}
