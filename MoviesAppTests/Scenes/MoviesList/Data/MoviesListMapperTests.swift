//
//  MoviesListMapperTests.swift
//  MoviesAppTests
//
//  Created by Khaled Mitkees on 30/11/2023.
//

import XCTest

final class MoviesListMapperTests: XCTestCase {

    func testMapMovieListResponseToDisplayModels() {
           // Given
           let mapper: MoviesListMapper = MoviesListMapperImpl()
           let response = MovieListResponse(
               page: 1,
               results: [
                Movie(adult: false, backdropPath: "", genreIds: [], id: 1, originalLanguage: "", originalTitle: "", overview: "Overview 1", popularity: 0, posterPath: "/poster1.jpg", releaseDate: "", title: "Movie 1", video: false, voteAverage: 0, voteCount: 0),
                Movie(adult: false, backdropPath: "", genreIds: [], id: 2, originalLanguage: "", originalTitle: "", overview: "Overview 2", popularity: 0, posterPath: "/poster2.jpg", releaseDate: "", title: "Movie 2", video: false, voteAverage: 0, voteCount: 0)
               ],
               totalPages: 1,
               totalResults: 2
           )

           // When
           let displayModels = mapper.map(response)

           // Then
           XCTAssertEqual(displayModels.count, 2)

           XCTAssertEqual(displayModels[0].title, "Movie 1")
           XCTAssertEqual(displayModels[0].overview, "Overview 1")
           XCTAssertEqual(displayModels[0].posterPath, "/poster1.jpg")

           XCTAssertEqual(displayModels[1].title, "Movie 2")
           XCTAssertEqual(displayModels[1].overview, "Overview 2")
           XCTAssertEqual(displayModels[1].posterPath, "/poster2.jpg")
       }
   }
