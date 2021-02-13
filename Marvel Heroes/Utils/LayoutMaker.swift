//
//  LayoutMaker.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 12/2/21.
//

import UIKit

enum LayoutMaker {
    enum Section {
        case main
    }

    static func getLayout(in view: UIView, withColumns columns: Int) -> UICollectionViewFlowLayout {
        let viewWidth = view.bounds.width
        let padding: CGFloat = 6
        let availableSpace = viewWidth - (padding * 6)
        let itemWidth = availableSpace / CGFloat(columns)

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.2)

        return flowLayout
    }
}
