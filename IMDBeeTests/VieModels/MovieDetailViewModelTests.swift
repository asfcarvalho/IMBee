//
//  MovieDetailViewModelTests.swift
//  IMDBeeTests
//
//  Created by Anderson F Carvalho on 19/07/23.
//

import XCTest
import DataModules
@testable import IMDBee

final class MovieDetailViewModelTests: XCTestCase {
    
    var movie: MovieModel!
    var movieEmpty: MovieModel!

    override func setUp() {
        movie = MovieModel(id: "1", description: "Back to the Future", image: [[
            "380",
            "https://m.media-amazon.com/images/M/MV5BMDFkYTc0MGEtZmNhMC00ZDIzLWFmNTEtODM1ZmRlYWMwMWFmXkEyXkFqcGdeQXVyMTMxODk2OTU@._V1_QL75_UX380_CR0,1,380,562_.jpg"
        ]], rating: "9.3", title: "Back to the Future", year: 2023)
        movieEmpty = MovieModel(id: "1", description: "", image: [[]], rating: "", title: "", year: 0)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMovieDetailViewModel_WhenViewModel_GetThumbNail380SizeEmpty() {
        // Arrange
        let validator = MovieDetailViewModelValidator()
        let sut = MovideDetailViewModel(movieEmpty.asMovie(), validator)
        
        // Act
        let urlImage = sut.movie?.urlImage
        
        // Assert
        XCTAssertNil(urlImage, "Movie Detail image 380 shuld be empty")
    }
    
    func testMovieDetailViewModel_WhenViewModel_GetThumbNail380SizeNotBeEmpty() {
        // Arrange
        let sut = MovideDetailViewModel(movie.asMovie())
        
        // Act
        let imageList = sut.movie?.urlImage
        
        // Assert
        XCTAssertNotNil(imageList, "Movie Detail image 380 shuld not be empty")
    }
    
    func testMovieDetailViewModel_WhenViewModel_ShuldDisplayView() {
        // Arrange
        let validator = MovieDetailViewModelValidator()
        let sut = MovideDetailViewModel(movie.asMovie(), validator)
        
        // Act
        sut.send(action: .viewDidLoad)
        
        let displayView = !sut.displayAlert

        //Assert
        XCTAssertTrue(displayView, "Movie Detail shuld display view")
    }
}
