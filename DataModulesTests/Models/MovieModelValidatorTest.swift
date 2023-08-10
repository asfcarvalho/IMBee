//
//  MovieModelValidatorTest.swift
//  IMDBeeTests
//
//  Created by Anderson F Carvalho on 13/07/23.
//

import XCTest
@testable import DataModules

final class MovieModelValidatorTest: XCTestCase {
    
    var sut: MovieModelValidator!

    override func setUp() {
        sut = MovieModelValidator()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testMovieModelValidator_WhenImage285Size_ShouldBeValid() {
        // Arrange
        let url = "https://m.media-amazon.com/images/M/MV5BNzA5ZDNlZWMtM2NhNS00NDJjLTk4NDItYTRmY2EwMWZlMTY3XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_QL75_UX285_CR0,0,285,422_.jpg"
        
        // Act
        let isImage285SizeValid = sut.isImage285SizeValid(url)
        
        // Assert
        XCTAssertTrue(isImage285SizeValid, "The move image size is not valid")
    }
    
    func testMovieModelValidator_WhenIMDBRating_ShouldBeNumber() {
        // Arrange
        let rating = "9.2"
        
        // Act
        let isIMDBRatingNumber = sut.isIMDBRatingNumberValid(rating)
        
        // Assert
        XCTAssertTrue(isIMDBRatingNumber, "The rating should be a valid number")
    }

    func testMovieModelValidator_WhenIMDBRating_ShouldNotBeNumber() {
        // Arrange
        let rating = "ABC"
        
        // Act
        let isIMDBRatingNumber = sut.isIMDBRatingNumberValid(rating)
        
        // Assert
        XCTAssertFalse(isIMDBRatingNumber, "The rating should not be a valid number")
    }
    
    func testMovieModelValidator_WhenMovieTitle_ShouldNotBeEmpty() {
        // Arrange
        let title = "Back to The Future"
        
        // Act
        let isMovieTitleEmpty = sut.isMovieTitleEmpty(title)
        
        // Assert
        XCTAssertFalse(isMovieTitleEmpty, "The movie title should not be empty value")
    }
    
    func testMovieModelValidator_WhenMovieTitle_ShouldBeEmpty() {
        // Act
        let isMovieTitleEmpty = sut.isMovieTitleEmpty(nil)
        
        // Assert
        XCTAssertTrue(isMovieTitleEmpty, "The movie title should be empty value")
    }
}
