//
//  NetworkRequestRepresentable.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 29/11/2023.
//

import Foundation

enum RequestGenerationError: Error {
    case invalidURL
}

protocol NetworkRequestRepresentable {
    var path: String { get }
    var method: HTTPMethodType { get }
    var headerParameters: [String: String] { get }
    var queryParametersEncodable: Encodable? { get }
    
    func urlRequest(with config: URLConfigurationContract) throws -> URLRequest
}

extension NetworkRequestRepresentable {
    func urlRequest(with config: URLConfigurationContract) throws -> URLRequest {
        let url = try getUrl(with: config)
        var urlRequest = URLRequest(url: url)
        var allHeaders: [String: String] = config.headers
        headerParameters.forEach { allHeaders.updateValue($1, forKey: $0) }
        
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = allHeaders
        return urlRequest
    }
    
    private func getUrl(with config: URLConfigurationContract) throws -> URL {
        
        let baseURL = config.baseURL.absoluteString
        let endpoint = baseURL.appending(path)
        
        guard var urlComponents = URLComponents(string: endpoint) else { throw RequestGenerationError.invalidURL }
        
        var urlQueryItems = [URLQueryItem]()
        let queryParameters = try queryParametersEncodable?.toDictionary()
        queryParameters?.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
        }
        
        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil

        guard let url = urlComponents.url else { throw RequestGenerationError.invalidURL }
        
        return url
    }
}

private extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonData = try JSONSerialization.jsonObject(with: data)
        return jsonData as? [String : Any]
    }
}
