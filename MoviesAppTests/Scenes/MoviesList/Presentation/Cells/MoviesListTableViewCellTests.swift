//
//  MoviesListTableViewCellTests.swift
//  MoviesAppTests
//
//  Created by Khaled Mitkees on 30/11/2023.
//

import XCTest

class MoviesListTableViewCellTests: XCTestCase {
    
    func testConfigure() {
        // Arrange
        let cell = MoviesListTableViewCell()
        
        // Simulate the creation of outlets
        let movieTitle = UILabel()
        let movieOverView = UILabel()
        let movieImageView = UIImageView()

        cell.movieTitle = movieTitle
        cell.movieOverView = movieOverView
        cell.movieImageView = movieImageView

        let mockMovie = MoviesDisplayModel(
            id: 1,
            title: "Mock Movie",
            overview: "Mock Overview",
            posterPath: "/mockPosterPath.jpg"
        )

        // Act
        cell.configure(with: mockMovie)

        // Assert
        XCTAssertEqual(cell.movieTitle?.text, "Mock Movie")
        XCTAssertEqual(cell.movieOverView?.text, "Mock Overview")
    }
}
