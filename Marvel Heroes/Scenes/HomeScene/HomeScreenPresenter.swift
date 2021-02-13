//
//  HomeScreenPresenter.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 12/2/21.
//  Copyright (c) 2021 Álvaro Gutiérrez Jácome. All rights reserved.
//

import UIKit

protocol HomeScreenPresentationLogic {
    func presentLoading()
    func presentError(error: MHError)
    func presentCompleted(responseModel: CharactersResponseModel)
}

class HomeScreenPresenter: HomeScreenPresentationLogic {
    weak var viewController: HomeScreenDisplayLogic?
    private var characters: [Character] = []

    func presentLoading() {
        viewController?.displayState(viewModel: .loading)
    }

    func presentError(error: MHError) {
        viewController?.displayState(viewModel: .error(error))
    }

    func presentCompleted(responseModel: CharactersResponseModel) {
        let newItems = responseModel.data.results.filter {
            !characters.contains($0)
        }

        characters.append(contentsOf: newItems)
        viewController?.displayState(viewModel: .completed(characters))
    }
}
