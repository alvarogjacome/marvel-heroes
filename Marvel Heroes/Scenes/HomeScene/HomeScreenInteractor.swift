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
}

protocol HomeScreenDataStore {}

class HomeScreenInteractor: HomeScreenBusinessLogic, HomeScreenDataStore {
    let api: MarvelHeroesAPIClient
    let presenter: HomeScreenPresentationLogic
    private var characterCounter = 0
    private var characterTotal = 30
    private var disposables = Set<AnyCancellable>()
    private let batchLimit = "30"

    init(api: MarvelHeroesAPIClient, presenter: HomeScreenPresentationLogic) {
        self.api = api
        self.presenter = presenter
    }

    // MARK: Fetch characters

    func fetchCharacterList(loading: Bool) {
        guard characterCounter < characterTotal else { return }
        if loading { presenter.presentLoading() }

        api.getCharacters(offset: String(characterCounter), limit: batchLimit)
            .sink(receiveCompletion: { [unowned self] response in
                if case let .failure(error) = response {
                    presenter.presentError(error: error)
                }
            }) { [unowned self] model in
                characterTotal = model.data.total
                characterCounter = presenter.presentCompleted(responseModel: model)
            }
            .store(in: &disposables)
    }
}
