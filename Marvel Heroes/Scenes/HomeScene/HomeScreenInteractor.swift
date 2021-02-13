//
//  HomeScreenInteractor.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 12/2/21.
//  Copyright (c) 2021 Álvaro Gutiérrez Jácome. All rights reserved.
//

import Combine

protocol HomeScreenBusinessLogic {
    func fetchCharacterList()
    func loadMoreCharactersIfNeeded(with index: Int)
}

protocol HomeScreenDataStore {}

class HomeScreenInteractor: HomeScreenBusinessLogic, HomeScreenDataStore {
    let api: MarvelHeroesAPIClient
    let presenter: HomeScreenPresentationLogic
    var characterCounter = 0
    var characters: [Character] = []

    private var disposables = Set<AnyCancellable>()

    init(api: MarvelHeroesAPIClient, presenter: HomeScreenPresentationLogic) {
        self.api = api
        self.presenter = presenter
    }

    // MARK: Fetch characters

    func fetchCharacterList() {
        presenter.presentSomething(state: .loading)
        api.getCharacters(offset: String(characterCounter))
            .sink(receiveCompletion: { [unowned self] response in
                if case let .failure(error) = response {
                    presenter.presentSomething(state: .error(error))
                }
            }) { [unowned self] model in
                characterCounter += model.data.results.count
                characters.append(contentsOf: model.data.results)
                presenter.presentSomething(state: .completed(characters))
            }
            .store(in: &disposables)
    }

    func loadMoreCharactersIfNeeded(with index: Int) {
        guard index == characterCounter - 10 else { return }
        fetchCharacterList()
    }
}
