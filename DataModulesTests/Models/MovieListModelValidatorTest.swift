//
//  MovieListModelValidatorTest.swift
//  DataModulesTests
//
//  Created by Anderson F Carvalho on 13/07/23.
//

import XCTest
@testable import DataModules

final class MovieListModelValidatorTest: XCTestCase {
    
    var sut: MovieListModelValidator!
    var movieModel: MovieModel!

    override func setUp() {
        sut = MovieListModelValidator()
        movieModel = MovieModel(id: "1", description: "Movie", image: [[]], rating: "9.2", title: "Back to The Future", year: 1989)
    }

    override func tearDown() {
        sut = nil
        movieModel = nil
    }

    func testMovieListModelValidator_WhenMovieList_ShouldNotBeEmpty() {
        // Arrange
        let moveList: MovieList = [movieModel]
        
        // Act
        let isMovieListEmpty = sut.isMovieListModelEmpty(moveList)
        
        // Assert
        XCTAssertFalse(isMovieListEmpty, "Movie List should not be empty")
    }
    
    func testMovieListModelValidator_WhenMovieList_ShouldBeEmpty() {
        // Act
        let isMovieListNill = sut.isMovieListModelEmpty(nil)
        
        // Assert
        XCTAssertTrue(isMovieListNill, "Movie List should not be empty")
    }

}
