//
//  MovieDetailViewModelValidatorTests.swift
//  IMDBeeTests
//
//  Created by Anderson F Carvalho on 19/07/23.
//

import XCTest
import DataModules
@testable import IMDBee

final class MovieDetailViewModelValidatorTests: XCTestCase {
    
    var sut: MovieDetailViewModelValidator!
    var movie: MovieModel!
    var movieEmpty: MovieModel!

    override func setUp() {
        sut = MovieDetailViewModelValidator()
        movie = MovieModel(id: "1", description: "Back to the Future", image: [[
            "380",
            "https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_QL75_UX380_CR0,1,380,562_.jpg"
        ]], rating: "9.3", title: "Back to the Future", year: 2023)
        movieEmpty = MovieModel(id: "1", description: "", image: [], rating: "", title: "", year: 0)
    }

    override func tearDown() {
        sut = nil
        movie = nil
        movieEmpty = nil
    }
    
    func testMovieDetailViewModelValidator_WhenMovieDetail_ShouldDisplayTitleEmpty() {
        // Arrange
        
        // Act
        let isMovideDetailTitleEmpty = sut.isTitleEmpty(movieEmpty.asMovie())
        
        // Assert
        XCTAssertTrue(isMovideDetailTitleEmpty, "Movie Detail title should be empty")
    }
    
    func testMovieDetailViewModelValidator_WhenMovieDetail_ShouldNotDisplayTitleEmpty() {
        // Arrange
        
        // Act
        let isMovideDetailTitleEmpty = sut.isTitleEmpty(movie.asMovie())
        
        // Assert
        XCTAssertFalse(isMovideDetailTitleEmpty, "Movie Detail title should not be empty")
    }
    
    func testMovieDetailViewModelValidator_WhenMovieDetail_ShuldRatingBeNumber() {
        // Arrange
        let rating = movie.rating
        
        // Act
        let isModieDetailRatingNumber = sut.isRatingNumber(rating)
        
        // Assert
        XCTAssertTrue(isModieDetailRatingNumber, "Movie Detail rating shuld be a number")
    }
    
    func testMovieDetailViewModelValidator_WhenMovieDetail_ShuldRatingNotBeNumber() {
        // Arrange
        let rating = "ABC"
        
        // Act
        let isModieDetailRatingNumber = sut.isRatingNumber(rating)
        
        // Assert
        XCTAssertFalse(isModieDetailRatingNumber, "Movie Detail rating shuld not be a number")
    }
    
    func testMovieDetailViewModelValidator_WhenMovieDetail_ShuldDescriptionBeEmpty() {
        // Arrange
        let description = movieEmpty.description
        
        // Act
        let isDescriptionEmpty = sut.isDescriptionEmpty(description)
        
        // Assert
        XCTAssertTrue(isDescriptionEmpty, "Movie Detail description shuld be empty")
    }
    
    func testMovieDetailViewModelValidator_WhenMovieDetail_ShuldDescriptionNotBeEmpty() {
        // Arrange
        let description = movie.description
        
        // Act
        let isDescriptionEmpty = sut.isDescriptionEmpty(description)
        
        // Assert
        XCTAssertFalse(isDescriptionEmpty, "Movie Detail description shuld not be empty")
    }
    
    func testMovieDetailViewModelValidator_WhenMovieDetail_ShuldImageListEmpty() {
        // Arrange
        let imageList = movieEmpty.asMovie().urlImage
        
        // Act
        let isThumbnailEmpty = sut.isThumbnailEmpty(imageList)
        
        // Assert
        XCTAssertTrue(isThumbnailEmpty, "Movie Detail image shuld be empty")
    }
    
    func testMovieDetailViewModelValidator_WhenMovieDetail_ShuldImageListNotEmpty() {
        // Arrange
        let imageList = movie.asMovie().urlImage
        
        // Act
        let isThumbnailEmpty = sut.isThumbnailEmpty(imageList)
        
        // Assert
        XCTAssertFalse(isThumbnailEmpty, "Movie Detail image shuld be empty")
    }
}
