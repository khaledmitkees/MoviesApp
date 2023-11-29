//
//  MoviesListMapper.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 30/11/2023.
//

import Foundation

protocol MoviesListMapper {
    func map(_ response: MovieListResponse) -> [MoviesListDisplayModel]
}

final class MoviesListMapperImpl: MoviesListMapper {
    
    func map(_ response: MovieListResponse) -> [MoviesListDisplayModel] {
        return response.results.map { movie in
            MoviesListDisplayModel(
                title: movie.title,
                overview: movie.overview,
                posterPath: movie.posterPath ?? ""
            )
        }
    }
}
