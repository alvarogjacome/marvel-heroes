//
//  Localizables.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 14/2/21.
//  Copyright © 2021 Álvaro Gutiérrez Jácome. All rights reserved.
//

import Foundation

func NSLocalizedString(_ key: Localizables) -> String {
    NSLocalizedString(key.rawValue, comment: "")
}

enum Localizables: String {
    case loading
    case error
    case ok
    case empty
    case comics
    case stories
    case series
    case moreInfo
    case noConnection
    case serverError
    case clientError
    case unavailable
}
