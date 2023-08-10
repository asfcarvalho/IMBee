//
//  MovieListViewModelTests.swift
//  IMDBeeTests
//
//  Created by Anderson F Carvalho on 18/07/23.
//

import XCTest
import DataModules
import Common
@testable import IMDBee

final class MovieListViewModelTests: XCTestCase {
    
    var validation: MovieListViewModelValidator!
    var dataSource: MockMovieListDataSource!
    var mockSut: MockMovieListViewModel!
    var sut: MovieListViewModel!
    var darkModeStatus: String!

    override func setUp() {
        darkModeStatus = LocalDataAdapter.shared.valueString(from: .themeColorKey)
        validation = MovieListViewModelValidator()
        dataSource = MockMovieListDataSource()
        mockSut = MockMovieListViewModel(movieDataSource: dataSource)
        sut = MovieListViewModel(movieListValidator: validation, movieDataSource: dataSource)
    }

    override func tearDown() {
        validation = nil
        dataSource = nil
        mockSut = nil
        LocalDataAdapter.shared.setValue(value: darkModeStatus, key: .themeColorKey)
    }
    
    func testMovieListViewModel_WhenFetchMovieList_CallSuccessOnViewLoad() {
        // Arrange
        let expectation = expectation(description: "Expected the successfulFetch() method to be called")
        dataSource.expectation = expectation
        dataSource.movieList = LoadJsonData.loadJson(filename: ValueDefault.movieListJSON)
        
        // Act
        mockSut.send(action: .viewDidLoad)
        
        // Assert
        self.wait(for: [expectation], timeout: 5)
        
        XCTAssertFalse(self.validation.isMovieListEmpty(mockSut.movieList))
    }
    
    func testMovieListViewModel_WhenFetchMovieList_CallFailedOnViewLoad() {
        // Arrange
        let expectation = expectation(description: "Expected the failedFetch() method to be called")
        dataSource.expectation = expectation
        dataSource.error = BeeError.ErrorDataEmpty
        
        // Act
        mockSut.send(action: .viewDidLoad)
        
        // Assert
        self.wait(for: [expectation], timeout: 2)
        XCTAssertTrue(validation.isMovieListEmpty(mockSut.movieList))
        XCTAssertTrue(validation.isMovieListEmpty(nil))
    }
    
    func testMovieListViewModel_WhenMoviViewListDidApear_ToggleIsInLightMode() {
        // Arrange
        LocalDataAdapter.shared.setValue(value: ValueDefault.light, key: .themeColorKey)
        
        // Act
        sut.send(action: .viewDidLoad)
        
        let isLightMode = sut.isLightMode
        
        
        // Assert
        XCTAssertTrue(isLightMode, "Theme color should be light")
    }
    
    func testMovieListViewModel_WhenMoviViewListDidApear_ToggleIsInDarkMode() {
        // Arrange
        LocalDataAdapter.shared.setValue(value: ValueDefault.dark, key: .themeColorKey)
        
        // Act
        sut.send(action: .viewDidLoad)
        
        let isDarkMode = !sut.isLightMode
        
        
        // Assert
        XCTAssertTrue(isDarkMode, "Theme color should be light")
    }
    
    func testMoviListViewModel_WhenMovieList_ChangeLightToDarkMode() {
        // Arrange
        LocalDataAdapter.shared.setValue(value: ValueDefault.light, key: .themeColorKey)
        
        // Act
        sut.send(action: .darkModeChanged(false))
        
        let themeColor = LocalDataAdapter.shared.valueString(from: .themeColorKey)
        
        
        // Assert
        XCTAssertEqual(themeColor, ValueDefault.dark, "Theme color should be dark")
    }
    
    func testMoviListViewModel_WhenMovieList_ChangeDarktoLightMode() {
        // Arrange
        LocalDataAdapter.shared.setValue(value:  ValueDefault.dark, key: .themeColorKey)
        
        // Act
        sut.send(action: .darkModeChanged(true))
        
        let themeColor = LocalDataAdapter.shared.valueString(from: .themeColorKey)
                
        // Assert
        XCTAssertEqual(themeColor, ValueDefault.light, "Theme color should be light")
    }
    
    func testMovieListViewModel_WhenMovieSearchBarIsSearching_ShouldShowSearchView() {
        // Arrange
        let text = "V"
        // Act
        mockSut.send(action: .isSearching(text))
        let isDisplay = mockSut.isSearching
        
        // Assert
        XCTAssertTrue(isDisplay, "The search view should be displayed")
    }
    
    func testMovieListViewModel_WhenMovieSearchBarIsSearching_ShouldNotShowSearchView() {
        // Arrange
        let text = ""
        // Act
        mockSut.send(action: .isSearching(text))
        let isDisplay = mockSut.isSearching
        
        // Assert
        XCTAssertFalse(isDisplay, "The search view should not be displayed")
    }
    
    func testMovieListViewModel_WhenMovieSearchBarIsSearching_ShouldShowFilteredList() {
        // Arrange
        let text = "The dark Knight"
        // Act
        let movieList: MovieList? = LoadJsonData.loadJson(filename: ValueDefault.movieListJSON)
        sut.movieList = movieList?.asasMovieArray()
        sut.send(action: .isSearching(text))
        
        let filteredMovie = sut.movieListFiltered
        
        // Assert
        XCTAssertNotNil(filteredMovie)
    }
    
    func testMovieListViewModel_WhenMovieSearchBarIsSearching_ShouldShowFilteredListEmpty() {
        // Arrange
        let text = "Back to the future"
        // Act
        let movieList: MovieList? = LoadJsonData.loadJson(filename: ValueDefault.movieListJSON)
        sut.movieList = movieList?.asasMovieArray()
        sut.send(action: .isSearching(text))
        
        let filteredMovie = sut.movieListFiltered
        
        // Assert
        XCTAssertTrue(filteredMovie?.isEmpty ?? true)
    }
}
