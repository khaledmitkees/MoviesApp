//
//  NetworkSessionManagerMock.swift
//  MoviesAppTests
//
//  Created by Khaled Mitkees on 29/11/2023.
//

import Foundation


struct NetworkSessionManagerMock: NetworkSessionManager {
    let response: HTTPURLResponse?
    let data: Data?
    let error: Error?
    
    func request(_ request: URLRequest,
                 completion: @escaping CompletionHandler) -> NetworkCancellable {
        completion(data, response, error)
        return URLSessionDataTask()
    }
}
