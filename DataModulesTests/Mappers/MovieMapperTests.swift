//
//  MovieMapperTests.swift
//  DataModulesTests
//
//  Created by Anderson F Carvalho on 24/07/23.
//

import XCTest
@testable import DataModules

final class MovieMapperTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMovieMapper_WhenMappingMovie_ResultSuccess() {
        // Arrange
        let movieModel = MovieModel(id: "1",
                                    description: "Test description",
                                    image: [
                                        ["https://m.media-amazon.com/images/M/MV5BZDA3NDExMTUtMDlhOC00MmQ5LWExZGUtYmI1NGVlZWI4OWNiXkEyXkFqcGdeQXVyNjc1NTYyMjg@._V1_QL75_UX380_CR0,5,380,562_.jpg"]
                                    ],
                                    rating: "8.3",
                                    title: "Test title",
                                    year: 1959)
        
        // Act
        let newMovie = movieModel.asMovie()
        
        // Assert
        XCTAssertEqual(newMovie.rating, "\(Int(Float(movieModel.rating) ?? 0)) / 10")
        XCTAssertEqual(newMovie.year, movieModel.yearString)
    }
}
