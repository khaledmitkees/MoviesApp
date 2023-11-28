//
//  MoviesListResponse.swift
//  MoviesApp
//
//  Created by Khaled Mitkees on 28/11/2023.
//

import Foundation

struct MovieListResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
}
