//
//  MHViewState.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 13/2/21.
//  Copyright © 2021 Álvaro Gutiérrez Jácome. All rights reserved.
//

import Foundation

enum MHViewState<T: Equatable>: Equatable {
    case idle
    case loading
    case completed(T)
    case error(MHError)
}
