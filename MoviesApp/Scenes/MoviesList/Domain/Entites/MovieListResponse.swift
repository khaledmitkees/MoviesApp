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

let movie1 = Movie(
    adult: false,
    backdropPath: "/8YFL5QQVPy3AgrEQxNYVSgiPEbe.jpg",
    genreIds: [28, 12, 878],
    id: 640146,
    originalLanguage: "en",
    originalTitle: "Ant-Man and the Wasp: Quantumania",
    overview: "Super-Hero partners Scott Lang and Hope van Dyne, along with Hope's parents Janet van Dyne and Hank Pym, and Scott's daughter Cassie Lang, find themselves exploring the Quantum Realm, interacting with strange new creatures and embarking on an adventure that will push them beyond the limits of what they thought possible.",
    popularity: 9272.643,
    posterPath: "/ngl2FKBlU4fhbdsrtdom9LVLBXw.jpg",
    releaseDate: "2023-02-15",
    title: "Ant-Man and the Wasp: Quantumania",
    video: false,
    voteAverage: 6.5,
    voteCount: 1856
)

let movie2 = Movie(
    adult: false,
    backdropPath: "/iJQIbOPm81fPEGKt5BPuZmfnA54.jpg",
    genreIds: [16, 12, 10751, 14, 35],
    id: 502356,
    originalLanguage: "en",
    originalTitle: "The Super Mario Bros. Movie",
    overview: "While working underground to fix a water main, Brooklyn plumbers—and brothers—Mario and Luigi are transported down a mysterious pipe and wander into a magical new world. But when the brothers are separated, Mario embarks on an epic quest to find Luigi.",
    popularity: 7212.464,
    posterPath: "/qNBAXBIQlnOThrVvA6mA2B5ggV6.jpg",
    releaseDate: "2023-04-05",
    title: "The Super Mario Bros. Movie",
    video: false,
    voteAverage: 7.5,
    voteCount: 1435
)

let mockMovieListResponse = MovieListResponse(
    page: 1,
    results: [movie1, movie2],
    totalPages: 38020,
    totalResults: 760385
)

