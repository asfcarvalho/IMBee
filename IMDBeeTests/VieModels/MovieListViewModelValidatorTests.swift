//
//  MovieListViewModelValidatorTests.swift
//  IMDBeeTests
//
//  Created by Anderson F Carvalho on 13/07/23.
//

import XCTest
import DataModules
@testable import IMDBee

final class MovieListViewModelValidatorTests: XCTestCase {

    var sut: MovieListViewModelValidator!
    var movieModel: MovieModel!
    
    override func setUp() {
        sut = MovieListViewModelValidator()
        movieModel = MovieModel(id: "1", description: "Movie", image: [[]], rating: "9.2", title: "Back to The Future", year: 1989)
    }

    override func tearDown() {
        sut = nil
        movieModel = nil
    }
    
    func testMovieListViewModelValidator_WhenMovieList_ShouldBeEmpty() {        
        // Act
        let isMovieListEmpty = sut.isMovieListEmpty(nil)
        
        // Assert
        XCTAssertTrue(isMovieListEmpty, "The move list should be empty")
    }
    
    func testMovieListViewModelValidator_WhenMovieList_ShouldNotBeEmpty() {
        // Arrange
        let movieList: MovieList = [movieModel]
        
        // Act
        let isMovieListEmpty = sut.isMovieListEmpty(movieList.asasMovieArray())
        
        // Assert
        XCTAssertFalse(isMovieListEmpty, "The move list should not be empty")
    }
    
    func testMovieListViewModelValidator_WhenSearchBarIsSearching_ShouldShowSearchView() {
        // Arrange
        let isSearching = sut.isSearching("V")
        
        // Act
        
        // Assert
        XCTAssertTrue(isSearching, "The searching should be valid")
    }
    
    func testMovieListViewModelValidator_WhenSearchBarIsSearching_ShouldHideSearchView() {
        // Arrange
        let isSearching = sut.isSearching("")
        
        // Act
        
        // Assert
        XCTAssertFalse(isSearching, "The searching should be invalid")
    }
}
