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
        let destinationVC = DetailViewController(model: infoModel)
        viewController?.show(destinationVC, sender: nil)
    }
}

class DetailViewController: MHBaseViewController {
    init(model: Character) {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        hideTitleView()
    }
}
