//
//  MarvelHeroesAPIClient.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 11/2/21.
//

import Combine

protocol MarvelHeroesAPIClientProtocol {
    func getCharacters(offset: String, limit: String) -> AnyPublisher<CharactersResponseModel, MHError>
    func getCharacter(id: String) -> AnyPublisher<CharactersResponseModel, MHError>
}

class MarvelHeroesAPIClient: APIAgent, MarvelHeroesAPIClientProtocol {
    func getCharacters(offset: String, limit: String) -> AnyPublisher<CharactersResponseModel, MHError> {
        let endpoint: CharactersEndpoint = .getAll(offset: offset, limit: limit)
        return run(endpoint)
    }

    func getCharacter(id: String) -> AnyPublisher<CharactersResponseModel, MHError> {
        let endpoint: CharactersEndpoint = .getByID(id: id)
        return run(endpoint)
    }
}

