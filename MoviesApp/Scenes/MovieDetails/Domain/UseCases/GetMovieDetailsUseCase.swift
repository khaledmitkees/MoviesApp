//
//  GetMovieDetailsUseCase.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 30/11/2023.
//

import Foundation

protocol GetMovieDetailsUseCase {
    func execute(movieId: Int, completion: @escaping (Result<MovieDetailsResponse, Error>) -> Void) -> Cancellable?
}

final class GetMovieDetailsUseCaseImpl: GetMovieDetailsUseCase {
    private let repository: MovieDetailsRepository
    
    init(repository: MovieDetailsRepository) {
        self.repository = repository
    }
    
    func execute(movieId: Int, completion: @escaping (Result<MovieDetailsResponse, Error>) -> Void) -> Cancellable? {
        return repository.fetchMovieDetails(movieId: movieId) { movieDetails in
            completion(movieDetails)
        }
    }
}
