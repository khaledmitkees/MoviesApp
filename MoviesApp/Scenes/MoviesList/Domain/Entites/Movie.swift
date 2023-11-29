//
//  Movie.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 28/11/2023.
//

import Foundation

struct Movie: Codable, Equatable {
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id &&
            lhs.title == rhs.title &&
            lhs.overview == rhs.overview &&
            lhs.releaseDate == rhs.releaseDate &&
            lhs.voteAverage == rhs.voteAverage &&
            lhs.posterPath == rhs.posterPath
    }
}
