//
//  MoviesListRepositoryImpl.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 28/11/2023.
//

import Foundation


final class MoviesListRepositoryImpl: MoviesListRepository {
    private let remoteDataSource: DataTransferService

    init(remoteDataSource: DataTransferService) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getMovies() {
        
    }
}
