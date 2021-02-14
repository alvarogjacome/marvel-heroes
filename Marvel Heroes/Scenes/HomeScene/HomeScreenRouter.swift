//
//  HomeScreenRouter.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 12/2/21.
//  Copyright (c) 2021 Álvaro Gutiérrez Jácome. All rights reserved.
//

import UIKit

protocol HomeScreenRoutingLogic {
    func routeToDetailView(infoModel: Character)
}

class HomeScreenRouter: HomeScreenRoutingLogic {
    weak var viewController: HomeScreenViewController?
    var dataStore: HomeScreenDataStore?

    // MARK: Routing

    func routeToDetailView(infoModel: Character) {
        let destinationVC = DetailScreenViewController(model: infoModel)
        viewController?.show(destinationVC, sender: nil)
    }
}
