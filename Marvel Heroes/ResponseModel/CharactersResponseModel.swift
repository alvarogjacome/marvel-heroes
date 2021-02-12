//
//  CharactersResponseModel.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 11/2/21.
//

import Foundation

struct CharactersResponseModel: ResponseModelProtocol {
    typealias Item = ResultData
    let data: ResultData
    let code: Int
    let status: String
}

struct ResultData: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Character]
}

struct Character: Codable {
    let id: Int
    let name: String
    let description: String
    let modified: String
    let thumbnail: Thumbnail
    let resourceURI: String
    let comics: Comics
    let series: Series
    let stories: Stories
    let events: Events
    let urls: [CharacterURLS]
}

struct Thumbnail: Codable {
    let path: String
    let `extension`: String
}

typealias Comics = ItemData
typealias Series = ItemData
typealias Stories = ItemData
typealias Events = ItemData

struct ItemData: Codable {
    let available: Int
    let collectionURI: String
    let items: [Item]
    let returned: Int
}

struct Item: Codable {
    let resourceURI: String
    let name: String
}

struct CharacterURLS: Codable {
    let type: String
    let url: String
}
