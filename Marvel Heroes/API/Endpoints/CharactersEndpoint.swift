//
//  CharactersEndpoint.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 11/2/21.
//

import Foundation

enum CharactersEndpoint: Endpoint {
    case getAll(offset: String, limit: String)
    case getByID(id: String)

    var path: String {
        let basePath = "characters"
        switch self {
        case .getAll:
            return basePath
        case let .getByID(id):
            return [basePath, id].joined(separator: "/")
        }
    }

    var params: [String: String]? {
        switch self {
        case let .getAll(offset, limit):
            return ["offset": offset, "limit": limit]
        case .getByID:
            return nil
        }
    }
}
