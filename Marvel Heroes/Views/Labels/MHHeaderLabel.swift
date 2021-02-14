//
//  MHHeaderLabel.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 12/2/21.
//  Copyright © 2021 Álvaro Gutiérrez Jácome. All rights reserved.
//

import UIKit

class MHHeaderLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = .preferredFont(forTextStyle: .title3)
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .label
        adjustsFontSizeToFitWidth = true
        numberOfLines = 3
        lineBreakMode = .byTruncatingTail
    }
}
