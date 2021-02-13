//
//  HomeScreenPresenter.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 12/2/21.
//  Copyright (c) 2021 Álvaro Gutiérrez Jácome. All rights reserved.
//

import UIKit

protocol HomeScreenPresentationLogic {
    func presentSomething(state: State<[Character]>)
}

class HomeScreenPresenter: HomeScreenPresentationLogic {
    weak var viewController: HomeScreenDisplayLogic?

    // MARK: Do something

    func presentSomething(state: State<[Character]>) {
        viewController?.displayState(viewModel: state)
    }
}
