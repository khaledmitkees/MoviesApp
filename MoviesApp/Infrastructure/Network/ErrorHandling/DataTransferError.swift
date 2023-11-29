//
//  DataTransferError.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 29/11/2023.
//

import Foundation

enum DataTransferError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
}

protocol DataTransferErrorResolver {
    func resolve(error: NetworkError) -> Error
}

// MARK: - Error Resolver
class DefaultDataTransferErrorResolver: DataTransferErrorResolver {
    func resolve(error: NetworkError) -> Error {
        return error
    }
}
