//
//  Endpoint.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 11/2/21.
//

import Foundation

protocol Endpoint {
    var basePath: String { get }
    var path: String { get }
    var host: String { get }
    var params: [String: String]? { get }
    var contentType: String { get }
}

extension Endpoint {
    var scheme: String {
        Configuration.scheme
    }

    var host: String {
        Configuration.host
    }

    var basePath: String {
        Configuration.basePath
    }
    
    var hash: String {
        Configuration.hash
    }

    var apiKey: String {
        Configuration.apiKey
    }

    var contentType: String {
        "application/json"
    }

    private var urlComponents: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = [basePath, path].joined(separator: "/")
        urlComponents.queryItems = [URLQueryItem(name: "apikey", value: apiKey),
                                    URLQueryItem(name: "hash", value: hash),
                                    URLQueryItem(name: "ts", value: "1")]
        if let params = params {
            urlComponents.queryItems?.append(contentsOf: params.compactMap {
                URLQueryItem(name: $0.key, value: $0.value)
            })
        }

        return urlComponents
    }

    var urlRequest: URLRequest {
        var request = URLRequest(url: urlComponents.url!)
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        return request
    }
}
