//
//  GetMoviesListUseCaseTests.swift
//  MoviesAppTests
//
//  Created by Khaled Mitkees on 29/11/2023.
//

import XCTest

class GetMoviesListUseCaseTests: XCTestCase {
    
    static let moviesList: MovieListResponse = {
        let response = MovieListResponse(page: 1,
                                         results: [],
                                         totalPages: 1,
                                         totalResults: 10)
        return response
    }()
    
    enum MoviesRepositorySuccessTestError: Error {
        case failedFetching
    }
        
    class MoviesListRepositoryMock: MoviesListRepository {
        var result: Result<MovieListResponse, Error>
        var fetchCompletionCallsCount = 0

        init(result: Result<MovieListResponse, Error>) {
            self.result = result
        }

        func fetchMoviesList(
            page: Int,
            completion: @escaping (Result<MovieListResponse, Error>
            ) -> Void
        ) -> Cancellable? {
            completion(result)
            fetchCompletionCallsCount += 1
            return nil
        }
    }
    
    func testMoviesUseCase_whenSuccessfullyFetchesMovies() {
        // given
        var useCaseCompletionCallsCount = 0
        let moviesListRepository = MoviesListRepositoryMock(result: .success(GetMoviesListUseCaseTests.moviesList))

        let useCase = GetMoviesListUseCaseImpl(
            repository: moviesListRepository
        )

        // when
        _ = useCase.execute(
            page: 1
        ) { _ in
            useCaseCompletionCallsCount += 1
        }
        // then
        XCTAssertEqual(useCaseCompletionCallsCount, 1)
        XCTAssertEqual(moviesListRepository.fetchCompletionCallsCount, 1)
    }
    
    func testMoviesUseCase_whenFailedFetchingMovies() {
        // given
        var useCaseCompletionCallsCount = 0
        let moviesListRepository = MoviesListRepositoryMock(result: .failure(MoviesRepositorySuccessTestError.failedFetching))
        
        let useCase = GetMoviesListUseCaseImpl(
            repository: moviesListRepository
        )
                
        // when
        _ = useCase.execute(page: 1) { _ in
            useCaseCompletionCallsCount += 1
        }
        // then
        XCTAssertEqual(useCaseCompletionCallsCount, 1)
    }
}
