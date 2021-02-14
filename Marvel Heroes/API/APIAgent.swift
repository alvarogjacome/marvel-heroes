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

    func run<T: ResponseModelProtocol>(_ endpoint: Endpoint) -> AnyPublisher<T, MHError> {
        let request = endpoint.urlRequest
        dump(request, name: "📤 Requested data")
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap(validate)
            .mapError { error in
                dump(error, name: "⛔️ API error")
                if let rac1Error = error as? MHError {
                    return rac1Error
                }
                return MHError.error(from: error)
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }

    private func validate<T: ResponseModelProtocol>(_ data: Data, _ response: URLResponse) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw MHError.invalidResponse
        }

        if let error = MHError.error(from: httpResponse.statusCode) {
            throw error
        }

        do {
            let responseObject = try decoder.decode(T.self, from: data)
            dump(responseObject, name: "✅ Decoded data")
            return try validateResponse(responseObject)
        } catch {
            throw MHError.decodingFailed(error)
        }
    }

    private func validateResponse<T: ResponseModelProtocol>(_ responseObject: T) throws -> T {
        guard responseObject.code == 200 else {
            throw MHError.invalidResponse
        }
        return responseObject
    }
}
