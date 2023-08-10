//
//  MovieListViewControllerTests.swift
//  IMDBeeTests
//
//  Created by Anderson F Carvalho on 18/07/23.
//

import XCTest
import DataModules
@testable import IMDBee

final class MovieListViewControllerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMovieListViewController_WhenMovieListViewModel_CallFetchMovieListSuccess() {
        // Arrange
        let movieDataSource = MockMovieListDataSource()
        let mockMovieListViewModel = MockMovieListViewModel(movieDataSource: movieDataSource)
        let movieListView = MovieListView(input: mockMovieListViewModel)
        let sut = MovieListViewController(rootView: movieListView)
        
        let expectation = expectation(description: "Expected the successCallVetchMovie() method to be called")
        
        mockMovieListViewModel.expectation = expectation
        
        // Act
        sut.viewWillAppear(false)
        
        // Assert
        self.wait(for: [expectation], timeout: 2)
        XCTAssertTrue(mockMovieListViewModel.fetchMovieSuccess)
    }
    
    func testMovieListViewController_WhenMovieListViewModel_CallMovieDetailSuccess() {
        // Arrange
        let mockMovieListViewModel = MockMovieListViewModel()
        let movieListView = MovieListView(input: mockMovieListViewModel)
        let sut = MovieListViewController(rootView: movieListView)
        let movie = MovieModel(id: "", description: "", image: [[]], rating: "", title: "", year: 0)
        let expectation = expectation(description: "Expected the successCallVetchMovie() method to be called")
        
        mockMovieListViewModel.expectation = expectation
        
        // Act
        sut.rootView.output.value.send(.showDetail(movie.asMovie().id))
        
        // Assert
        self.wait(for: [expectation], timeout: 2)
        XCTAssertTrue(mockMovieListViewModel.showDetailSuccess)
    }
    
    func testMovieListViewController_WhenSearchvarIsSearching_ShowSearchView() {
        // Arrange
        let mockMovieListViewModel = MockMovieListViewModel()
        let movieListView = MovieListView(input: mockMovieListViewModel)
        let sut = MovieListViewController(rootView: movieListView)
                
        // Act
        sut.rootView.output.value.send(.isSearching("V"))
        
        // Assert
        XCTAssertTrue(mockMovieListViewModel.isSearching)
    }
}
