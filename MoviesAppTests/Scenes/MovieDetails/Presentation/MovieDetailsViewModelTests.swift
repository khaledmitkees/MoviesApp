//
//  MovieDetailsViewModelTests.swift
//  MoviesAppTests
//
//  Created by Khaled Mitkees on 30/11/2023.
//

import XCTest

class MovieDetailsViewModelTests: XCTestCase {

    var viewModel: MovieDetailsViewModel!
    var mockUseCase: MockGetMovieDetailsUseCase!

    let movie = MoviesDisplayModel(
        id: 1,
        title: "title",
        overview: "overview",
        posterPath: "posterPath"
    )
    
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

    override func setUp() {
        super.setUp()
        mockUseCase = MockGetMovieDetailsUseCase()
        viewModel = MovieDetailsViewModel(movie: movie, useCase: mockUseCase)
    }

    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        super.tearDown()
    }

    func testGetMovieDetailsSuccess() {
        // Given
        mockUseCase.mockResult = .success(movieDetailsDisplayModel)

        // When
        viewModel.getMovieDetails { success, error in
            // Then
            XCTAssertTrue(success)
            XCTAssertNil(error)
        }

        // Additional checks
        XCTAssertEqual(mockUseCase.executeCallCount, 1)
        XCTAssertTrue(mockUseCase.executeCompletionHandler != nil)
        XCTAssertEqual(mockUseCase.cancelCallCount, 0)
    }

    func testGetMovieDetailsFailure() {
        // Given
        let expectedError = NSError(domain: "TestErrorDomain", code: 123, userInfo: nil)
        mockUseCase.mockResult = .failure(expectedError)

        // When
        viewModel.getMovieDetails { success, error in
            // Then
            XCTAssertFalse(success)
            XCTAssertNotNil(error)
        }

        // Additional checks
        XCTAssertEqual(mockUseCase.executeCallCount, 1)
        XCTAssertTrue(mockUseCase.executeCompletionHandler != nil)
        XCTAssertEqual(mockUseCase.cancelCallCount, 0)
    }
}

// MockGetMovieDetailsUseCase for testing
class MockGetMovieDetailsUseCase: GetMovieDetailsUseCase {
    var executeCallCount = 0
    var executeCompletionHandler: ((Result<MovieDetailsResponse, Error>) -> Void)?
    var cancelCallCount = 0

    var mockResult: Result<MovieDetailsResponse, Error>?

    func execute(movieId: Int, completion: @escaping (Result<MovieDetailsResponse, Error>) -> Void) -> Cancellable? {
        executeCallCount += 1
        executeCompletionHandler = completion

        if let mockResult = mockResult {
            completion(mockResult)
        }

        return MockCancellable { [weak self] in
            self?.cancelCallCount += 1
        }
    }
}

