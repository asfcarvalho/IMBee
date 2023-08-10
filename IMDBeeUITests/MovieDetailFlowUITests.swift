//
//  MovieDetailFlowUITests.swift
//  IMDBeeUITests
//
//  Created by Anderson F Carvalho on 21/07/23.
//

import XCTest
import Common

final class MovieDetailFlowUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        app = XCUIApplication()
        app.launchArguments = ["-skipSurvey","-debugServer", ValueDefault.argumentsUITesting]
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testMovieListViewController_WhenViewDetail_DisplayAlert() {
        // Arrange
        app.launchEnvironment[ValueDefault.enviromentJsonURL] = ValueDefault.movieDetailDataErrorJSON
                
        let firstItemList = app.scrollViews[ValueDefault.movieListView].otherElements
            .scrollViews[ValueDefault.movieListInTheaterList].otherElements.buttons["carousel_item_63eef9c2244a27600bb64820"]
        let alert = app.alerts["Movie not found!"]
        // Act
        app.launch()
        XCTAssertTrue(firstItemList.waitForExistence(timeout: 2))
        firstItemList.tap()
        
        XCTAssertTrue(alert.waitForExistence(timeout: 2))
        alert.buttons["OK"].tap()
                
        // Assert
        XCTAssertTrue(app.otherElements[ValueDefault.movieListView].exists, "The alert 'Movie not found!' didn't appear.")
    }
    
    func testMovieListViewController_WhenViewDetail_DisplayInTheaterMoviesList() {
        // Arrange
        app.launchEnvironment[ValueDefault.enviromentJsonURL] = ValueDefault.movieListJSON
                
        // Act
        app.launch()
                
        // Assert
        XCTAssertTrue(app.scrollViews[ValueDefault.movieListInTheaterList].exists, "The Movie Theater list view didn't appear.")
    }
    
    func testMovieListViewController_WhenViewDetail_DisplayMoviesList() {
        // Arrange
        app.launchEnvironment[ValueDefault.enviromentJsonURL] = ValueDefault.movieListJSON
                
        // Act
        app.launch()
                
        // Assert
        XCTAssertTrue(app.scrollViews[ValueDefault.movieListView].exists, "The Movie list view didn't appear.")
    }
    
    func testMovieDetailViewController_WhenMovieItemTapped_DisplayDetail() {
        // Arrange
        app.launchEnvironment[ValueDefault.enviromentJsonURL] = ValueDefault.movieListJSON
                
        let firstItemList = app.scrollViews[ValueDefault.movieListView].otherElements
            .scrollViews[ValueDefault.movieListMovieList].otherElements.buttons["carousel_item_63eef9c2244a27600bb64820"]
        
        // Act
        app.launch()
        XCTAssertTrue(firstItemList.waitForExistence(timeout: 2))
        firstItemList.tap()
                
        // Assert
        XCTAssertTrue(app.otherElements[ValueDefault.movideDetailView].exists, "The movie detail dian't appear")
    }
}
