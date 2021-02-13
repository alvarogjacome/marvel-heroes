//
//  HomeScreenViewController.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 12/2/21.
//  Copyright (c) 2021 Álvaro Gutiérrez Jácome. All rights reserved.
//

import UIKit

protocol HomeScreenDisplayLogic: AnyObject {
    func displayState(viewModel: State<[Character]>)
}

class HomeScreenViewController: BaseViewController, HomeScreenDisplayLogic {
    private var interactor: HomeScreenBusinessLogic!
    private var router: (NSObjectProtocol & HomeScreenRoutingLogic & HomeScreenDataPassing)!

    // MARK: Components

    private lazy var collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: LayoutMaker.getLayout(in: view, withColumns: 2))
    private lazy var dataSource = { UICollectionViewDiffableDataSource<Int, Character>(collectionView: collectionView) { (collectionView, indexPath, character) -> UICollectionViewCell? in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.reuseID, for: indexPath) as! CharacterCollectionViewCell
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

        configureView()
        configureCollectionView()
        doSomething()
    }

    private func configureView() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.reuseID)
        collectionView.delegate = self
    }

    // MARK: Do something

    func doSomething() {
        interactor?.fetchCharacterList()
    }

    func displayState(viewModel: State<[Character]>) {
        switch viewModel {
        case let .completed(list):
            super.displayCompleted()
            update(with: list)
        case let .error(error):
            super.displayError(error: error)
        default:
            break
        }
    }

    func update(with list: [Character], animate: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Character>()
        snapshot.appendSections([0])
        snapshot.appendItems(list, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: animate)
    }
}

extension HomeScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        interactor.loadMoreCharactersIfNeeded(with: indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let character = dataSource.itemIdentifier(for: indexPath) else { return }
        
    }
}

protocol BaseDisplayLogic {
    func displayLoading()
    func displayError(error: Error)
    func displayEmptyState()
    func displayCompleted()
}

class BaseViewController: UIViewController, BaseDisplayLogic {
    let loadingAlert = UIAlertController(title: nil, message: "Loading...", preferredStyle: .alert)
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func displayLoading() {
        loadingAlert.view.tintColor = UIColor.black
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating()

        loadingAlert.view.addSubview(loadingIndicator)
        present(loadingAlert, animated: true, completion: nil)
    }

    func displayCompleted() {
        dismissLoading()
    }

    func dismissLoading() {
        loadingAlert.dismiss(animated: true)
    }

    func displayError(error: Error) {
        dismissLoading()

        let alert = UIAlertController(title: "⚠️ Ups! ⚠️", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            fatalError(error.localizedDescription)
        }
        alert.addAction(action)

        present(alert, animated: true)
    }

    func displayEmptyState() {
        dismissLoading()

        let alert = UIAlertController(title: "⚠️ Ups! ⚠️", message: "No data", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)

        present(alert, animated: true)
    }
}
