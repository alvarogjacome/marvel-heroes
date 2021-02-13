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
        let padding: CGFloat = 5
        let sidePadding = padding * CGFloat(columns)
        let availableSpace = viewWidth - (sidePadding * CGFloat(columns + 1))
        let itemWidth = availableSpace / CGFloat(columns)

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: sidePadding, bottom: sidePadding, right: sidePadding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.8)

        return flowLayout
    }
}
