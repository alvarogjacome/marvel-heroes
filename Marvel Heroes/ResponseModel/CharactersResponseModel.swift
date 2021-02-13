//
//  CharactersResponseModel.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 11/2/21.
//

import Foundation

struct CharactersResponseModel: ResponseModelProtocol {
    typealias Item = CharacterResultData
    let data: CharacterResultData
    let code: Int
    let status: String
}

struct CharacterResultData: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Character]
}

struct Character: Decodable, Hashable {
    let id: Int
    let name: String
    let description: String
    let modified: String
    let thumbnail: Thumbnail
    let resourceURI: String
    let urls: [CharacterURLS]
}

struct Thumbnail: Decodable, Hashable {
    let path: String
    let `extension`: String

    var url: URL? {
        guard !path.contains("image_not_available") else { return nil }
        return URL(string: [path, self.extension].joined(separator: "."))
    }
}

struct CharacterURLS: Decodable, Hashable {
    let type: String
    let url: String
}
