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
    static let reuseID = "CharacterCell"

    private let avatarImageView = MHCharacterImageView(frame: .zero)
    private let userNameLabel = MHHeaderLabel(textAlignment: .center)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    func set(character: Character) {
        userNameLabel.text = character.name
        avatarImageView.sd_setImage(with: character.thumbnail.url, placeholderImage: UIImage(named: "placeholder"))
    }

    private func configure() {
        addSubview(avatarImageView)
        addSubview(userNameLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),

            userNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10),
            userNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            userNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            userNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
