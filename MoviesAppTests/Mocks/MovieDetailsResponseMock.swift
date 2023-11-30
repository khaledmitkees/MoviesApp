//
//  MovieDetailsResponseMock.swift
//  MoviesAppTests
//
//  Created by Khaled Mitkees on 30/11/2023.
//

import Foundation

let movieDetailsDisplayModel: MovieDetailsResponse = MovieDetailsResponse(
    adult: true,
    backdropPath: "backdropPath",
    belongsToCollection: BelongsToCollection(id: 1, name: "Collection", posterPath: "posterPath", backdropPath: "backdropPath"),
    budget: 1000000,
    genres: [Genre(id: 1, name: "Action"), Genre(id: 2, name: "Drama")],
    homepage: "http://example.com",
    id: 123,
    imdbID: "tt123456",
    originalLanguage: "en",
    originalTitle: "Original Title",
    overview: "This is the movie overview.",
    popularity: 1234,
    posterPath: "posterPath",
    productionCompanies: [ProductionCompany(id: 1, logoPath: "logoPath", name: "Production Company", originCountry: "US")],
    productionCountries: [ProductionCountry(iso3166_1: "US", name: "United States")],
    releaseDate: "2023-01-01",
    revenue: 5000000,
    runtime: 120,
    spokenLanguages: [SpokenLanguage(englishName: "English", iso: "en", name: "English")],
    status: "Released",
    tagline: "Tagline",
    title: "Movie Title",
    video: false,
    voteAverage: 7,
    voteCount: 100
)
