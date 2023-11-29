//
//  URLConfiguration.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 28/11/2023.
//

import Foundation

protocol URLConfigurationContract {
    var baseURL: URL { get }
    var headers: [String: String] { get }
    var queryParameters: [String: String] { get }
}

struct URLConfiguration: URLConfigurationContract {
    let baseURL: URL
    let headers: [String: String]
    let queryParameters: [String: String]
    
     init(
        baseURL: URL,
        headers: [String: String] = [:],
        queryParameters: [String: String] = [:]
     ) {
        self.baseURL = baseURL
        self.headers = headers
        self.queryParameters = queryParameters
    }
}
