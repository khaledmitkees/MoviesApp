//
//  MoviesListRepositoryImpl.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 28/11/2023.
//

import Foundation


final class MoviesListRepositoryImpl: MoviesListRepository {
    private let remoteDataSource: DataTransferService
    private let backgroundQueue: DataTransferDispatchQueue
    
    init(remoteDataSource: DataTransferService,
         backgroundQueue: DataTransferDispatchQueue = DispatchQueue.global(qos: .userInitiated)
    ) {
        self.remoteDataSource = remoteDataSource
        self.backgroundQueue = backgroundQueue
    }
    
    func fetchMoviesList(
        page: Int,
        completion: @escaping (Result<MovieListResponse, Error>) -> Void
    ) -> Cancellable? {
        
        let task = RepositoryTask()
        let endPoint = getMoviesEndpoint(with: MoviesListRequest(page: page))
        
        task.networkTask = self.remoteDataSource.request(
            with: endPoint,
            on: backgroundQueue
        ) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
    
    private func getMoviesEndpoint(with request: MoviesListRequest) -> Endpoint<MovieListResponse> {
        return Endpoint(
            path: "discover/movie",
            queryParametersEncodable: request
        )
    }
}
