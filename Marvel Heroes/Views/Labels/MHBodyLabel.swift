//
//  MHBodyLabel.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 14/2/21.
//  Copyright © 2021 Álvaro Gutiérrez Jácome. All rights reserved.
//

import UIKit

class MHBodyLabel: UILabel {
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
        self.font = .preferredFont(forTextStyle: .body)
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.6
        lineBreakMode = .byTruncatingTail
    }
}
