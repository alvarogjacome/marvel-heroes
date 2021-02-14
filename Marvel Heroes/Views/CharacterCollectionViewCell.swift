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

    private lazy var characterImageView = MHCharacterImageView(frame: .zero)
    private lazy var characterNameLabel = MHHeaderLabel(textAlignment: .center)
    private lazy var blurredView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let view = UIVisualEffectView(effect: blurEffect)
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

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
        characterImageView.sd_setImage(with: character.thumbnail.url, placeholderImage: UIImage(.verticalLogo))
    }

    private func configure() {
        [characterImageView, blurredView, characterNameLabel].forEach(addSubview(_:))

        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            characterImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])

        NSLayoutConstraint.activate([
            blurredView.topAnchor.constraint(equalTo: characterNameLabel.topAnchor, constant: -10),
            blurredView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            blurredView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            blurredView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            characterNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            characterNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            characterNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)

        ])

        layer.masksToBounds = true
        layer.cornerRadius = 10
    }
}
