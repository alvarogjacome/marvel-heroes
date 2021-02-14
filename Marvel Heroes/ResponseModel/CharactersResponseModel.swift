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
    let thumbnail: Thumbnail
    let urls: [CharacterURLS]
    let comics: ItemData
    let series: ItemData
    let stories: ItemData
}

struct Thumbnail: Decodable, Hashable {
    let path: String
    let `extension`: String

    var url: URL? {
        guard !path.contains("image_not_available"), !path.contains("4c002e0305708") else { return nil }
        return URL(string: [path, self.extension].joined(separator: "."))
    }
}

struct ItemData: Decodable, Hashable {
    let available: Int
    let collectionURI: String
    let items: [Item]
    let returned: Int
}

struct Item: Decodable, Hashable {
    let resourceURI: String
    let name: String
}

struct CharacterURLS: Decodable, Hashable {
    let type: String
    let url: String
}
