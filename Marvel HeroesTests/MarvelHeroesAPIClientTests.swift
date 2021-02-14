//
//  MarvelHeroesAPIClientTests.swift
//  Marvel HeroesTests
//
//  Created by Álvaro Gutiérrez Jácome on 11/2/21.
//

import Combine
@testable import Marvel_Heroes
import XCTest

struct MarvelHeroesMockAPIClient: MarvelHeroesAPIClientProtocol {
    func getCharacters(offset: String, limit: String) -> AnyPublisher<CharactersResponseModel, MHError> {
        Just(CharactersResponseModel(data: CharacterResultData(offset: Int(offset)!, limit: Int(limit)!, total: 20, count: 20, results: []), code: 200, status: "Ok"))
            .setFailureType(to: MHError.self)
            .eraseToAnyPublisher()
    }

    func getCharacter(id: String) -> AnyPublisher<CharactersResponseModel, MHError> {
        Just(CharactersResponseModel(data: CharacterResultData(offset: 20, limit: 20, total: 20, count: 20, results: []), code: 200, status: "Ok"))
            .setFailureType(to: MHError.self)
            .eraseToAnyPublisher()
    }
}

class MarvelHeroesAPIClientTests: XCTestCase {
    var mockApiClient: MarvelHeroesMockAPIClient!

    override func setUp() {
        mockApiClient = MarvelHeroesMockAPIClient()
    }

    func test_getCharactersResponse() {
        let offset = 20
        let limit = 20

        let expectedResponse = CharactersResponseModel(data: CharacterResultData(offset: offset, limit: limit, total: 20, count: 20, results: []), code: 200, status: "Ok")
        let expectation = XCTestExpectation(description: "getCharacters")

        _ = mockApiClient.getCharacters(offset: String(offset), limit: String(limit))
            .sink(receiveCompletion: { _ in }) { response in
                XCTAssertEqual(response, expectedResponse)
                expectation.fulfill()
            }

        wait(for: [expectation], timeout: 1)
    }
}
