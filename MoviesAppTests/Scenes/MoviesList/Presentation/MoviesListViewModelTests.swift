//
//  MoviesListViewModelTests.swift
//  MoviesAppTests
//
//  Created by Khaled Mitkees on 29/11/2023.
//

import XCTest

class MoviesListViewModelTests: XCTestCase {

    private var viewModel: MoviesListViewModel!
    private var mockMoviesListUseCase: MockMoviesListUseCase!

    override func setUp() {
        super.setUp()
        mockMoviesListUseCase = MockMoviesListUseCase()
        viewModel = MoviesListViewModel(moviesListUseCase: mockMoviesListUseCase)
    }

    override func tearDown() {
        viewModel = nil
        mockMoviesListUseCase = nil
        super.tearDown()
    }

    func testGetMoviesSuccess() {
        // Given
        let expectedResponse = [MoviesDisplayModel(
            id: 1,
            title: "title",
            overview: "overview",
            posterPath: "posterPath"
        )]
        mockMoviesListUseCase.mockResult = .success(expectedResponse)

        // When
        viewModel.getMovies { success, error in
            // Then
            XCTAssertTrue(success)
            XCTAssertNil(error)
        }
        // Then
        XCTAssertEqual(mockMoviesListUseCase.executeCallCount, 1)
        XCTAssertTrue(mockMoviesListUseCase.executeCompletionHandler != nil)
        XCTAssertEqual(mockMoviesListUseCase.cancelCallCount, 0)
    }

    func testGetMoviesFailure() {
        // Given
        let expectedError = NSError(domain: "TestErrorDomain", code: 123, userInfo: nil)
        mockMoviesListUseCase.mockResult = .failure(expectedError)

        // When
        viewModel.getMovies { success, error in
            // Then
            XCTAssertFalse(success)
            XCTAssertNotNil(error)
        }
        // Then
        XCTAssertEqual(mockMoviesListUseCase.executeCallCount, 1)
        XCTAssertTrue(mockMoviesListUseCase.executeCompletionHandler != nil)
        XCTAssertEqual(mockMoviesListUseCase.cancelCallCount, 0)
    }

    // Additional tests for handling UI updates or error messages can be added.
}

// MockMoviesListUseCase for testing
class MockMoviesListUseCase: MoviesListUseCase {
    var executeCallCount = 0
    var executeCompletionHandler: ((Result<[MoviesDisplayModel], Error>) -> Void)?
    var cancelCallCount = 0

    var mockResult: Result<[MoviesDisplayModel], Error>?

    func execute(page: Int, completion: @escaping (Result<[MoviesDisplayModel], Error>) -> Void) -> Cancellable? {
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

// MockCancellable for testing
class MockCancellable: Cancellable {
    func cancel() {
        
    }
    
    var onCancel: () -> Void
    
    init(onCancel: @escaping () -> Void) {
        self.onCancel = onCancel
    }
    
}
