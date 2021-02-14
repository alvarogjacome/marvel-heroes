//
//  DetailScreenInteractor.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 13/2/21.
//  Copyright (c) 2021 Álvaro Gutiérrez Jácome. All rights reserved.
//

import UIKit

protocol DetailScreenBusinessLogic {
    func doSomething()
}

class DetailScreenInteractor: DetailScreenBusinessLogic {
    var presenter: DetailScreenPresentationLogic?

    // MARK: Do something

    func doSomething() {
        presenter?.presentSomething()
    }
}
