//
//  MoviesListRepository.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 28/11/2023.
//

import Foundation

protocol MoviesListRepository {
    @discardableResult
    func fetchMoviesList(
        page: Int,
        completion: @escaping (Result<[MoviesDisplayModel], Error>) -> Void
    ) -> Cancellable?
}
