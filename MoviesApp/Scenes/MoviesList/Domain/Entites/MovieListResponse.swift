//
//  MoviesListResponse.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 28/11/2023.
//

import Foundation

struct MovieListResponse: Codable, Equatable {
    static func == (lhs: MovieListResponse, rhs: MovieListResponse) -> Bool {
        return lhs.page == rhs.page &&
            lhs.results == rhs.results &&
            lhs.totalPages == rhs.totalPages &&
            lhs.totalResults == rhs.totalResults
    }
    
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
}
