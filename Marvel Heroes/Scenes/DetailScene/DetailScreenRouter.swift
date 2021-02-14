//
//  DetailScreenRouter.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 13/2/21.
//  Copyright (c) 2021 Álvaro Gutiérrez Jácome. All rights reserved.
//

import UIKit

@objc protocol DetailScreenRoutingLogic {
    func routeToMoreInfoFrom(url: URL)
}

class DetailScreenRouter: DetailScreenRoutingLogic {
    weak var viewController: DetailScreenViewController?

    func routeToMoreInfoFrom(url: URL) {
        UIApplication.shared.open(url, options: [:])
    }
}
