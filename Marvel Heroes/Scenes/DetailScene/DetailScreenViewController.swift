//
//  DetailScreenViewController.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 13/2/21.
//  Copyright (c) 2021 Álvaro Gutiérrez Jácome. All rights reserved.
//

import SDWebImage
import UIKit

protocol DetailScreenDisplayLogic: class {
    func displaySomething()
}

class DetailScreenViewController: MHBaseViewController, DetailScreenDisplayLogic {
    private var interactor: DetailScreenBusinessLogic!
    private var router: DetailScreenRoutingLogic!
    private let character: Character

    // MARK: Components

    private lazy var presentationImageView: MHCharacterImageView = {
        let imageView = MHCharacterImageView(frame: .zero)
        imageView.sd_setImage(with: character.thumbnail.url, placeholderImage: UIImage(named: "verticalLogo"))
        imageView.layer.cornerRadius = 50
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 0.2
        imageView.layer.borderColor = UIColor.systemGray.cgColor
        return imageView
    }()

    private lazy var titleLabel: MHTitleLabel = {
        let title = MHTitleLabel(textAlignment: .left)
        title.text = character.name
        title.numberOfLines = 1
        return title
    }()

    private lazy var subtitleLabel: MHBodyLabel = {
        let title = MHBodyLabel(textAlignment: .left)
        title.text = character.description
        title.isHidden = character.description.isEmpty
        title.numberOfLines = 6
        return title
    }()

    private lazy var comicsLabel: MHBodyLabel = {
        labelGenerator(type: .comics(count: character.comics.items.count))
    }()

    private lazy var seriesLabel: MHBodyLabel = {
        labelGenerator(type: .series(count: character.series.items.count))
    }()

    private lazy var storiesLabel: MHBodyLabel = {
        labelGenerator(type: .stories(count: character.stories.items.count))
    }()

    private lazy var infoStackContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 15
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var footerStackContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()

    private lazy var itemsStackContainer: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .top
        stack.distribution = .fill
        stack.spacing = 10
        stack.layer.cornerRadius = 15
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        stack.backgroundColor = .secondarySystemBackground
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .secondarySystemBackground
        button.addTarget(self, action: #selector(launchDetails), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.setTitleColor(.label, for: .normal)
        button.setTitle("🔗 More info", for: .normal)
        return button
    }()

    // MARK: Object lifecycle

    init(model: Character) {
        self.character = model
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = DetailScreenInteractor()
        let presenter = DetailScreenPresenter()
        let router = DetailScreenRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        hideTitleView()
        setup()

        addSubviews()
        layoutSubviews()
    }

    // MARK: Layout

    private func addSubviews() {
        [presentationImageView, infoStackContainer].forEach(view.addSubview(_:))
        [titleLabel, subtitleLabel, footerStackContainer].forEach(infoStackContainer.addArrangedSubview(_:))
        [itemsStackContainer, button].forEach(footerStackContainer.addArrangedSubview(_:))
        [comicsLabel, seriesLabel, storiesLabel].forEach(itemsStackContainer.addArrangedSubview(_:))
    }

    private func layoutSubviews() {
        layoutImageView()
        layoutStackView()
    }

    private func layoutImageView() {
        NSLayoutConstraint.activate([
            presentationImageView.topAnchor.constraint(equalTo: view.topAnchor),
            presentationImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            presentationImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            presentationImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.6),
        ])
    }

    private func layoutStackView() {
        NSLayoutConstraint.activate([
            infoStackContainer.topAnchor.constraint(equalTo: presentationImageView.bottomAnchor, constant: 20),
            infoStackContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoStackContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }

    // MARK: Helpers

    @objc func launchDetails() {
        guard let firstUrl = character.urls.first?.url, let url = URL(string: firstUrl) else { return }
        router.routeToMoreInfoFrom(url: url)
    }

    private enum LabelType {
        case comics(count: Int)
        case series(count: Int)
        case stories(count: Int)
    }

    private func labelGenerator(type: LabelType) -> MHBodyLabel {
        let label = MHBodyLabel()

        let firstAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        let secondAttributes = [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel]

        switch type {
        case let .comics(count):
            let firstString = NSMutableAttributedString(string: "📰 Comics: ", attributes: firstAttributes)
            let secondString = NSAttributedString(string: String(count), attributes: secondAttributes)
            firstString.append(secondString)
            label.attributedText = firstString
        case let .series(count):
            let firstString = NSMutableAttributedString(string: "📺 Series: ", attributes: firstAttributes)
            let secondString = NSAttributedString(string: String(count), attributes: secondAttributes)
            firstString.append(secondString)
            label.attributedText = firstString
        case let .stories(count):
            let firstString = NSMutableAttributedString(string: "🎭 Stories: ", attributes: firstAttributes)
            let secondString = NSAttributedString(string: String(count), attributes: secondAttributes)
            firstString.append(secondString)
            label.attributedText = firstString
        }

        return label
    }

    // MARK: Do something

    func doSomething() {}

    func displaySomething() {}
}
