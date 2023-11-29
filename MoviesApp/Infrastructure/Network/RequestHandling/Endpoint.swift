//
//  Endpoint.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 28/11/2023.
//

import Foundation

enum HTTPMethodType: String {
    case get = "GET"
}

class Endpoint<R>: ResponseRequestable {
    
    typealias Response = R
    
    let path: String
    let method: HTTPMethodType
    let headerParameters: [String: String]
    let queryParametersEncodable: Encodable?
    let responseDecoder: ResponseDecoder
    
    init(path: String,
         method: HTTPMethodType = .get,
         headerParameters: [String: String] = [:],
         queryParametersEncodable: Encodable? = nil,
         responseDecoder: ResponseDecoder = JSONResponseDecoder()
    ) {
        self.path = path
        self.method = method
        self.headerParameters = headerParameters
        self.queryParametersEncodable = queryParametersEncodable
        self.responseDecoder = responseDecoder
    }
}

private class JSONResponseDecoder: ResponseDecoder {
    private let jsonDecoder = JSONDecoder()
    func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}
