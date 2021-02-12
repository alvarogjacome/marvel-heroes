//
//  MarvelHeroesError.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 11/2/21.
//

import Foundation

enum MarvelHeroesError: Error, Equatable {
    case clientError(_ statusCode: Int)
    case serverError(_ statusCode: Int)
    case connectionError(Error?)
    case decodingFailed(_ error: Error)
    case other(Error?)
    case invalidResponse
    case internalError

    static func == (lhs: MarvelHeroesError, rhs: MarvelHeroesError) -> Bool {
        lhs.localizedDescription == rhs.localizedDescription
    }
}

extension MarvelHeroesError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .connectionError:
            return "Sin conexión"
        default:
            return "La operación no se ha podido completar"
        }
    }
}

extension MarvelHeroesError {
    static func error(from error: Error) -> MarvelHeroesError {
        let errorCode = (error as NSError).code

        switch errorCode {
        case 400 ..< 500: return .clientError(errorCode)
        case 500 ..< 600: return .serverError(errorCode)
        case -1005, -1009, -1018, -1020: return .connectionError(error)
        default: return .other(error)
        }
    }

    static func error(from statusCode: Int) -> MarvelHeroesError? {
        switch statusCode {
        case 200 ..< 300: return nil
        case 400 ..< 500: return .clientError(statusCode)
        case 500 ..< 600: return .serverError(statusCode)
        default: return .other(nil)
        }
    }
}
