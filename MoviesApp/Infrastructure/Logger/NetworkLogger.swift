//
//  NetworkLogger.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 28/11/2023.
//

import Foundation

protocol NetworkLoggerContract {
    func log(request: URLRequest)
    func log(responseData data: Data?, response: URLResponse?)
    func log(error: Error)
}

final class NetworkLogger: NetworkLoggerContract {
    func log(request: URLRequest) {
        printIfDebug("-------------")
        printIfDebug("request: \(request.url!)")
        printIfDebug("headers: \(request.allHTTPHeaderFields!)")
        printIfDebug("method: \(request.httpMethod!)")
        if let httpBody = request.httpBody, let result = ((try? JSONSerialization.jsonObject(with: httpBody, options: []) as? [String: AnyObject]) as [String: AnyObject]??) {
            printIfDebug("body: \(String(describing: result))")
        } else if let httpBody = request.httpBody, let resultString = String(data: httpBody, encoding: .utf8) {
            printIfDebug("body: \(String(describing: resultString))")
        }
    }

    func log(responseData data: Data?, response: URLResponse?) {
        guard let data = data else { return }
        if let dataDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            printIfDebug("responseData: \(String(describing: dataDict)) ✅")
        }
    }

    func log(error: Error) {
        printIfDebug("❌❌❌ \(error) ❌❌❌")
    }
    
    private func printIfDebug(_ string: String) {
        #if DEBUG
        print(string)
        #endif
    }
}
