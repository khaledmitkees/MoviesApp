//
//  GetMoviesListUseCaseTests.swift
//  MoviesAppTests
//
//  Created by Khaled Mitkees on 29/11/2023.
//

import XCTest

class GetMoviesListUseCaseTests: XCTestCase {
    
    static let moviesList: [MoviesDisplayModel] = {
        let response = [
            MoviesDisplayModel(
                id: 1,
                title: "title",
                overview: "overview",
                posterPath: "posterPath"
            )
        ]
        return response
    }()
    
    enum MoviesRepositorySuccessTestError: Error {
        case failedFetching
    }
        
    class MoviesListRepositoryMock: MoviesListRepository {
        var result: Result<[MoviesDisplayModel], Error>
        var fetchCompletionCallsCount = 0

        init(result: Result<[MoviesDisplayModel], Error>) {
            self.result = result
        }

        func fetchMoviesList(
            page: Int,
            completion: @escaping (Result<[MoviesDisplayModel], Error>
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
