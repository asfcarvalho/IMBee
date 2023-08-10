//
//  MovieListViewTests.swift
//  IMDBeeTests
//
//  Created by Anderson F Carvalho on 18/07/23.
//

import XCTest
import Common
import DataModules
@testable import IMDBee

final class MovieListViewTests: XCTestCase {

    var urlSession: URLSession!
    var apiCalling: APICalling!
            
    var movieDataSource: MockMovieListDataSource!
    var input: MockMovieListViewModel!
    
    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
        let apiCalling = APICalling(urlSession: urlSession)
                
        movieDataSource = MockMovieListDataSource()
        input = MockMovieListViewModel(movieDataSource: movieDataSource)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMovieListViewTests_WhenMovieListView_ShowEmptyList() {
        // Arrange
        let sut = MovieListView(input: input)
        let vc = MovieListViewController(rootView: sut)
        
        let expectation = expectation(description: "Expected the showEmptyList() method to be called")
        
        movieDataSource.expectation = expectation
        movieDataSource.movieList = nil//[MovieModel(id: "1", description: "222", image: [[]], rating: "9.3", title: "Back to the Future", year: 1985 )]
        
        // Act
        vc.viewWillAppear(false)
                
        self.wait(for: [expectation], timeout: 2)
        
        // Assert
        XCTAssertNil(sut.input.movieList)
        XCTAssertTrue(sut.input.isListEmpty)
    }
    
    func testMovieListViewTests_WhenMovieListView_ShowNotEmptyList() {
        // Arrange
        let sut = MovieListView(input: input)
        let vc = MovieListViewController(rootView: sut)
        
        let expectation = expectation(description: "Expected the showEmptyList() method to be called")
        
        movieDataSource.expectation = expectation
        movieDataSource.movieList = [MovieModel(id: "1", description: "222", image: [[]], rating: "9.3", title: "Back to the Future", year: 1985 )]
        
        // Act
        vc.viewWillAppear(false)
        
        self.wait(for: [expectation], timeout: 2)
        
        // Assert
        XCTAssertNotNil(sut.input.movieList)
        XCTAssertFalse(sut.input.isListEmpty)
    }
}
