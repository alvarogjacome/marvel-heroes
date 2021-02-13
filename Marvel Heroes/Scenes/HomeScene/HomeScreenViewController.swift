//
//  HomeScreenViewController.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 12/2/21.
//  Copyright (c) 2021 Álvaro Gutiérrez Jácome. All rights reserved.
//

import UIKit

protocol HomeScreenDisplayLogic: AnyObject {
    func displayState(viewModel: MHViewState<[Character]>)
}

class HomeScreenViewController: MHBaseViewController {
    private var interactor: HomeScreenBusinessLogic!
    private var router: HomeScreenRoutingLogic!

    // MARK: Components

    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: LayoutMaker.getLayout(in: view, withColumns: 2))
        collection.showsVerticalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier)
        collection.delegate = self

        return collection
    }()

    private lazy var dataSource = {
        UICollectionViewDiffableDataSource<LayoutMaker.Section, Character>(collectionView: collectionView) { (collectionView, indexPath, character) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.reuseIdentifier, for: indexPath) as! CharacterCollectionViewCell
            cell.set(character: character)
            return cell
        }
    }()

    // MARK: Object lifecycle

    init(apiClient: MarvelHeroesAPIClient) {
        super.init(nibName: nil, bundle: nil)
        setup(apiClient: apiClient)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup

    private func setup(apiClient: MarvelHeroesAPIClient) {
        let viewController = self
        let presenter = HomeScreenPresenter()
        let interactor = HomeScreenInteractor(api: apiClient, presenter: presenter)
        let router = HomeScreenRouter()
        viewController.interactor = interactor
        viewController.router = router
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        layoutSubviews()
        requestCharacterList()
    }

    // MARK: Interactions

    func requestCharacterList() {
        interactor?.fetchCharacterList(loading: true)
    }

    // MARK: Layout

    private func addSubviews() {
        [collectionView].forEach(view.addSubview(_:))
    }

    private func layoutSubviews() {
        layoutCollectionView()
    }

    private func layoutCollectionView() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomeScreenViewController: HomeScreenDisplayLogic {
    func displayState(viewModel: MHViewState<[Character]>) {
        switch viewModel {
        case let .completed(list):
            if !list.isEmpty {
                super.displayCompleted()
                update(with: list)
                return
            }
            super.displayEmptyState { [unowned self] in
                self.interactor.fetchCharacterList(loading: false)
            }
        case let .error(error):
            super.displayError(error: error, tapAction: {})
        case .loading:
            super.displayLoading()
        default:
            break
        }
    }
}

extension HomeScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        interactor.loadMoreCharactersIfNeeded(with: indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let character = dataSource.itemIdentifier(for: indexPath) else { return }
        router.routeToDetailView(infoModel: character)
    }

    func update(with list: [Character], animate: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<LayoutMaker.Section, Character>()
        snapshot.appendSections([.main])
        snapshot.appendItems(list, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: animate)
    }
}
