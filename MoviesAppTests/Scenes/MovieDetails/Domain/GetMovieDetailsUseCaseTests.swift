//
//  GetMovieDetailsUseCaseTests.swift
//  MoviesAppTests
//
//  Created by Khaled Mitkees on 30/11/2023.
//

import XCTest


final class GetMovieDetailsUseCaseTests: XCTestCase {
    
    // Mock repository for testing
    class MockMovieDetailsRepository: MovieDetailsRepository {
        var fetchMovieDetailsCallCount = 0
        var movieIdPassed: Int?
        var mockResult: Result<MovieDetailsResponse, Error>?
        
        func fetchMovieDetails(movieId: Int, completion: @escaping (Result<MovieDetailsResponse, Error>) -> Void) -> Cancellable? {
            fetchMovieDetailsCallCount += 1
            movieIdPassed = movieId
            
            if let mockResult = mockResult {
                completion(mockResult)
            }
            
            return nil
        }
    }
        
    var useCase: GetMovieDetailsUseCaseImpl!
    var mockRepository: MockMovieDetailsRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockMovieDetailsRepository()
        useCase = GetMovieDetailsUseCaseImpl(repository: mockRepository)
    }
    
    override func tearDown() {
        useCase = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testExecuteCallsRepositoryWithCorrectMovieId() {
        // Given
        let movieId = 123
        
        // When
        _ = useCase.execute(movieId: movieId) { _ in }
        
        // Then
        XCTAssertEqual(mockRepository.fetchMovieDetailsCallCount, 1)
        XCTAssertEqual(mockRepository.movieIdPassed, movieId)
    }
}
