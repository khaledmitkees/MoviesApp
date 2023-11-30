//
//  MoviesListMapper.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 30/11/2023.
//

import Foundation

protocol MoviesListMapper {
    func map(_ response: MovieListResponse) -> [MoviesDisplayModel]
}

final class MoviesListMapperImpl: MoviesListMapper {
    
    func map(_ response: MovieListResponse) -> [MoviesDisplayModel] {
        return response.results.map { movie in
            MoviesDisplayModel(
                id: movie.id,
                title: movie.title,
                overview: movie.overview,
                posterPath: movie.posterPath ?? ""
            )
        }
    }
}
