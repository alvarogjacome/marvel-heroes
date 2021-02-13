//
//  HomeScreenInteractor.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 12/2/21.
//  Copyright (c) 2021 Álvaro Gutiérrez Jácome. All rights reserved.
//

import Combine

protocol HomeScreenBusinessLogic {
    func fetchCharacterList(loading: Bool)
    func loadMoreCharactersIfNeeded(with index: Int)
}

protocol HomeScreenDataStore {}

class HomeScreenInteractor: HomeScreenBusinessLogic, HomeScreenDataStore {
    let api: MarvelHeroesAPIClient
    let presenter: HomeScreenPresentationLogic
    private var characterCounter = 0
    private var disposables = Set<AnyCancellable>()

    init(api: MarvelHeroesAPIClient, presenter: HomeScreenPresentationLogic) {
        self.api = api
        self.presenter = presenter
    }

    // MARK: Fetch characters

    func fetchCharacterList(loading: Bool) {
        if loading { presenter.presentLoading() }
        
        api.getCharacters(offset: String(characterCounter))
            .sink(receiveCompletion: { [unowned self] response in
                if case let .failure(error) = response {
                    presenter.presentError(error: error)
                }
            }) { [unowned self] model in
                characterCounter += model.data.count
                presenter.presentCompleted(responseModel: model)
            }
            .store(in: &disposables)
    }

    func loadMoreCharactersIfNeeded(with index: Int) {
        guard index == characterCounter - 14 else { return }
        fetchCharacterList(loading: false)
    }
}
