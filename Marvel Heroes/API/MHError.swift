//
//  MarvelHeroesError.swift
//  Marvel Heroes
//
//  Created by Álvaro Gutiérrez Jácome on 11/2/21.
//

import Foundation

enum MHError: Error, Equatable {
    case clientError(_ statusCode: Int)
    case serverError(_ statusCode: Int)
    case connectionError(Error?)
    case decodingFailed(_ error: Error)
    case other(Error?)
    case invalidResponse
    case internalError

    static func == (lhs: MHError, rhs: MHError) -> Bool {
        lhs.localizedDescription == rhs.localizedDescription
    }
}

extension MHError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .connectionError:
            return "Sin conexión"
        case let .clientError(code):
            return "Error por parte de cliente: \(code)"
        case let .serverError(code):
            return "Error por parte de servidor: \(code)"
        default:
            return "La operación no se ha podido completar"
        }
    }
}

extension MHError {
    static func error(from error: Error) -> MHError {
        let errorCode = (error as NSError).code

        switch errorCode {
        case 400 ..< 500: return .clientError(errorCode)
        case 500 ..< 600: return .serverError(errorCode)
        case -1005, -1009, -1018, -1020: return .connectionError(error)
        default: return .other(error)
        }
    }

    static func error(from statusCode: Int) -> MHError? {
        switch statusCode {
        case 200 ..< 300: return nil
        case 400 ..< 500: return .clientError(statusCode)
        case 500 ..< 600: return .serverError(statusCode)
        default: return .other(nil)
        }
    }
}
