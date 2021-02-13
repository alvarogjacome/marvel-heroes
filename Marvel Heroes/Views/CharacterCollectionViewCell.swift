//
//  CharacterCollectionViewCell.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 12/2/21.
//  Copyright © 2021 Álvaro Gutiérrez Jácome. All rights reserved.
//

import SDWebImage
import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "CharacterCell"

    private let characterImageView = MHCharacterImageView(frame: .zero)
    private let characterNameLabel = MHHeaderLabel(textAlignment: .center)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    func set(character: Character) {
        characterNameLabel.text = character.name
        characterImageView.contentMode = .scaleAspectFill
        characterImageView.sd_setImage(with: character.thumbnail.url, placeholderImage: UIImage(named: "verticalLogo"))
    }

    private func configure() {
        addSubview(characterImageView)

        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            characterImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])

        layer.masksToBounds = true
        layer.cornerRadius = 10
        layer.borderWidth = 0.2
        layer.borderColor = UIColor.systemGray.cgColor
    }
}
