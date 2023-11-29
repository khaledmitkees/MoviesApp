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
            headers: [
                "api_key": appConfiguration.apiKey,
                "accept": "application/json"
            ]
        )
        
        let apiDataNetwork = DefaultNetworkService(config: config)
        return DefaultDataTransferService(with: apiDataNetwork)
    }()

}
