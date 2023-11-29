//
//  EndpointMock.swift
//  MoviesAppTests
//
//  Created by Khaled Mitkees on 29/11/2023.
//

import Foundation

struct EndpointMock: NetworkRequestRepresentable {
    var path: String
    var method: HTTPMethodType
    var headerParameters: [String: String] = [:]
    var queryParametersEncodable: Encodable?
    
    init(path: String, method: HTTPMethodType) {
        self.path = path
        self.method = method
    }
}
