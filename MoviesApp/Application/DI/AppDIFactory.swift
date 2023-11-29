//
//  AppDIFactory.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 29/11/2023.
//

import Foundation


final class AppDIFactory {
        
    static let appConfiguration = AppConfiguration()
    
    static let apiDataTransferService: DataTransferService = {
        let config = URLConfiguration(
            baseURL: URL(string: appConfiguration.apiBaseURL)!,
            queryParameters: [
                "api_key": appConfiguration.apiKey,
            ]
        )
        
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()

}
