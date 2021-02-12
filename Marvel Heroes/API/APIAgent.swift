//
//  APIAgent.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 11/2/21.
//

import Combine
import Foundation

protocol ResponseModelProtocol: Decodable {
    associatedtype Item: Decodable
    var data: Item { get }
    var code: Int { get }
    var status: String { get }
}

class APIAgent {
    private lazy var decoder = JSONDecoder()

    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }

    func run<T: ResponseModelProtocol>(_ endpoint: Endpoint) -> AnyPublisher<T, MarvelHeroesError> {
        let request = endpoint.urlRequest
        dump(request, name: "📤 Requested data")
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap(validate)
            .mapError { error in
                dump(error, name: "⛔️ API error")
                if let rac1Error = error as? MarvelHeroesError {
                    return rac1Error
                }
                return MarvelHeroesError.error(from: error)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    private func validate<T: ResponseModelProtocol>(_ data: Data, _ response: URLResponse) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw MarvelHeroesError.invalidResponse
        }

        if let error = MarvelHeroesError.error(from: httpResponse.statusCode) {
            throw error
        }

        do {
            let responseObject = try decoder.decode(T.self, from: data)
            dump(responseObject, name: "✅ Decoded data")
            return try validateResponse(responseObject)
        } catch {
            throw MarvelHeroesError.decodingFailed(error)
        }
    }

    private func validateResponse<T: ResponseModelProtocol>(_ responseObject: T) throws -> T {
        guard responseObject.code == 200 else {
            throw MarvelHeroesError.invalidResponse
        }
        return responseObject
    }
}
