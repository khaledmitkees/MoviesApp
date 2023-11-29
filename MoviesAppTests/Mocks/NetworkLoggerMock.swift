//
//  NetworkLoggerMock.swift
//  MoviesAppTests
//
//  Created by Khaled Mitkees on 29/11/2023.
//

import Foundation

class NetworkLoggerMock: NetworkLoggerContract {
    var loggedErrors: [Error] = []
    func log(request: URLRequest) { }
    func log(responseData data: Data?, response: URLResponse?) { }
    func log(error: Error) { loggedErrors.append(error) }
}
