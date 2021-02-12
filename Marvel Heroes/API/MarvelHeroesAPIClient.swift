//
//  MarvelHeroesAPIClient.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 11/2/21.
//

import Combine

protocol MarvelHeroesAPIClientProtocol {
    func getCharacters(offset: String) -> AnyPublisher<CharactersResponseModel, MarvelHeroesError>
    func getCharacter(id: String) -> AnyPublisher<CharactersResponseModel, MarvelHeroesError>
}

class MarvelHeroesAPIClient: APIAgent, MarvelHeroesAPIClientProtocol {
    func getCharacters(offset: String) -> AnyPublisher<CharactersResponseModel, MarvelHeroesError> {
        let endpoint: CharactersEndpoint = .getAll(offset: offset)
        return run(endpoint)
    }

    func getCharacter(id: String) -> AnyPublisher<CharactersResponseModel, MarvelHeroesError> {
        let endpoint: CharactersEndpoint = .getByID(id: id)
        return run(endpoint)
    }
}
