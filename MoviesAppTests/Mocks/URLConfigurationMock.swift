//
//  URLConfigurationMock.swift
//  MoviesAppTests
//
//  Created by Khaled Mitkees on 29/11/2023.
//

import Foundation

class URLConfigurableMock: URLConfigurationContract {
    var baseURL: URL = URL(string: "https://mock.test.com")!
    var headers: [String: String] = [:]
    var queryParameters: [String: String] = [:]
}
