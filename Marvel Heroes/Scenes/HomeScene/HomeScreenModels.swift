//
//  HomeScreenModels.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 12/2/21.
//  Copyright (c) 2021 Álvaro Gutiérrez Jácome. All rights reserved.
//

import UIKit



enum State<T: Equatable>: Equatable {
    case idle
    case loading
    case completed(T)
    case error(MHError)
}
