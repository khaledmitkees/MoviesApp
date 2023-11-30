//
//  MovieDetailsRepositoryImpl.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 30/11/2023.
//

import Foundation

final class MovieDetailsRepositoryImpl: MovieDetailsRepository {
    private var remoteDataSource: DataTransferService
    private var backgroundQueue: DataTransferDispatchQueue
    
    init(remoteDataSource: DataTransferService,
         backgroundQueue: DataTransferDispatchQueue = DispatchQueue.global(qos: .userInitiated)
    ) {
        self.remoteDataSource = remoteDataSource
        self.backgroundQueue = backgroundQueue
    }
    
    func fetchMovieDetails(
        movieId: Int,
        completion: @escaping (Result<MovieDetailsResponse, Error>) -> Void
    ) -> Cancellable? {
        
        let request = MovieDetailsRequest(movieId: movieId)
        
        let task = RepositoryTask()
        let endPoint = getMoviesDetailsEndpoint(with: request)
        
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
    
    
    private func getMoviesDetailsEndpoint(with request: MovieDetailsRequest) -> Endpoint<MovieDetailsResponse> {
        return Endpoint(
            path: "movie/\(request.movieId)"
        )
    }
}
