//
//  MovieDetailsRepository.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 30/11/2023.
//

import Foundation

protocol MovieDetailsRepository {
    @discardableResult
    func fetchMovieDetails(
        movieId: Int,
        completion: @escaping (Result<MovieDetailsResponse, Error>) -> Void
    ) -> Cancellable?
}
