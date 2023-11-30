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
    private let moviesListMapper: MoviesListMapper
    
    init(remoteDataSource: DataTransferService,
         backgroundQueue: DataTransferDispatchQueue = DispatchQueue.global(qos: .userInitiated),
            moviesListMapper: MoviesListMapper
    ) {
        self.remoteDataSource = remoteDataSource
        self.backgroundQueue = backgroundQueue
        self.moviesListMapper = moviesListMapper
    }
    
    func fetchMoviesList(
        page: Int,
        completion: @escaping (Result<[MoviesDisplayModel], Error>) -> Void
    ) -> Cancellable? {
        
        let task = RepositoryTask()
        let endPoint = getMoviesEndpoint(with: MoviesListRequest(page: page))
        
        task.networkTask = self.remoteDataSource.request(
            with: endPoint,
            on: backgroundQueue
        ) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                let displayModel = self.moviesListMapper.map(response)
                completion(.success(displayModel))
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
