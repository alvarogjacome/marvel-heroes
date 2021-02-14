//
//  MHCharacterImageView.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 12/2/21.
//  Copyright © 2021 Álvaro Gutiérrez Jácome. All rights reserved.
//

import UIKit

class MHCharacterImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    private func configure() {
        clipsToBounds = true
        image = UIImage()
        contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
    }
}
