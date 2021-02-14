//
//  DetailScreenPresenter.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 13/2/21.
//  Copyright (c) 2021 Álvaro Gutiérrez Jácome. All rights reserved.
//

import UIKit

protocol DetailScreenPresentationLogic {
    func presentSomething()
}

class DetailScreenPresenter: DetailScreenPresentationLogic {
    weak var viewController: DetailScreenDisplayLogic?

    // MARK: Do something

    func presentSomething() {
        viewController?.displaySomething()
    }
}
