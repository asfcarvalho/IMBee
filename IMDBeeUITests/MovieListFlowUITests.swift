//
//  MovieListFlowUITests.swift
//  IMDBeeUITests
//
//  Created by Anderson F Carvalho on 19/07/23.
//

import XCTest
import Common
import Components
import DataModules

final class MovieListFlowUITests: XCTestCase {
    
    var app: XCUIApplication!
    private var token = CancelBag()
    var darkModeStatus: String!
    

    override func setUpWithError() throws {
        try super.setUpWithError()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        app = XCUIApplication()
        app.launchArguments = ["-skipSurvey","-debugServer", ValueDefault.argumentsUITesting]
        
        darkModeStatus = LocalDataAdapter.shared.valueString(from: .themeColorKey)
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
        LocalDataAdapter.shared.setValue(value: darkModeStatus, key: .themeColorKey)
    }

    func testMovieListViewController_WhenViewDidLoad_DisplayEmpty() throws {
        // Arrange
        app.launchEnvironment[ValueDefault.enviromentJsonURL] = ValueDefault.movieListDataErrorJSON
                
        // Act
        app.launch()
        
        // Assert
        XCTAssertTrue(app.staticTexts["movieList_empty"].exists, "A Empty warning was not presented when response are not presented")
    }
    
    func testMovieListViewController_WhenViewDidLoad_DisplayMovieInTheaterList() throws {
        // Arrange
        app.launchEnvironment[ValueDefault.enviromentJsonURL] = ValueDefault.movieListJSON
                
        // Act
        app.launch()
        
        // Assert
        XCTAssertTrue(app.scrollViews[ValueDefault.movieListInTheaterList].exists, "A Movie In Theater list should be desplayed")
    }
    
    func testMovieListViewController_WhenViewDidLoad_DisplayMovieList() throws {
        // Arrange
        app.launchEnvironment[ValueDefault.enviromentJsonURL] = ValueDefault.movieListJSON
                
        // Act
        app.launch()
        
        // Assert
        XCTAssertTrue(app.scrollViews[ValueDefault.movieListMovieList].exists, "A Movie list should be desplayed")
    }
    
    func testMovieListViewController_WhenViewList_ItemListTapped() {
        // Arrange
        app.launchEnvironment[ValueDefault.enviromentJsonURL] = ValueDefault.movieListJSON
                
        let firstItemList = app.scrollViews[ValueDefault.movieListView].otherElements
            .scrollViews[ValueDefault.movieListInTheaterList].otherElements.buttons["carousel_item_63eef9c2244a27600bb64820"]
        // Act
        app.launch()
        XCTAssertTrue(firstItemList.waitForExistence(timeout: 2))
        firstItemList.tap()
        
        // Assert
        XCTAssertTrue(app.otherElements[ValueDefault.movideDetailView].exists, "A Movie Detail View was not presented")
    }
    
    func testMovieListView_WhenView_ShowTuggleDarkMode() {
        // Arrange
        app.launchEnvironment[ValueDefault.enviromentJsonURL] = ValueDefault.movieListJSON
        app.launchEnvironment[ValueDefault.themeColorTest] = ValueDefault.light
        
        let toggleLightButton = app.images[ValueDefault.themeLightMode]
                
        // Act
        app.launch()
        
        // Assert
        XCTAssertTrue(toggleLightButton.exists, "The toogle dark mode was not presented")

    }
    
    func testMovieListView_WhenViewTuggleLightTapped_ThenShowDark() {
        // Arrange
        app.launchEnvironment[ValueDefault.enviromentJsonURL] = ValueDefault.movieListJSON
        app.launchEnvironment[ValueDefault.themeColorTest] = ValueDefault.light

        let toggleDarkmodeImage = app.images[ValueDefault.themeLightMode]
        
        // Act
        app.launch()
        toggleDarkmodeImage.tap()
        
        // Assert
        XCTAssertTrue(app.images[ValueDefault.themeDarkMode].exists,  "The toogle dark mode was not presented")
    }
    
    func testMovieListView_WhenViewTuggleDarkTapped_ThenShowLight() {
        // Arrange
        app.launchEnvironment[ValueDefault.enviromentJsonURL] = ValueDefault.movieListJSON
        app.launchEnvironment[ValueDefault.themeColorTest] = ValueDefault.dark

        let toggleDarkmodeImage = app.images[ValueDefault.themeDarkMode]
        
        // Act
        app.launch()
        toggleDarkmodeImage.tap()
        
        // Assert
        XCTAssertTrue(app.images[ValueDefault.themeLightMode].exists,  "The toogle light mode was not presented")
    }
    
    func testMovieListView_WhenViewDidLoad_ThenDisplayTopMovieTitle() {
        // Arrange
        app.launchEnvironment[ValueDefault.enviromentJsonURL] = ValueDefault.movieListJSON
        
        let titleText = app.staticTexts[ValueDefault.topMovieTitle]
        
        // Act
        app.launch()
        
        // Assert
        XCTAssertTrue(titleText.exists)
    }
    
    func testMovieListView_WhenViewDidLoad_ThenDisplayMovieInTheaterTitle() {
        // Arrange
        app.launchEnvironment[ValueDefault.enviromentJsonURL] = ValueDefault.movieListJSON
        
        let titleText = app.staticTexts[ValueDefault.movieInTheaterTitle]
        
        // Act
        app.launch()
        
        // Assert
        XCTAssertTrue(titleText.exists)
    }
    
    func testMovieListView_WhenViewDidLoad_ThenDisplaySearchBar() {
        // Arrange
        app.launchEnvironment[ValueDefault.enviromentJsonURL] = ValueDefault.movieListJSON
        
        let titleText = app.textFields[ValueDefault.searchBarView]
        
        // Act
        app.launch()
        
        // Assert
        XCTAssertTrue(titleText.exists)
    }
    
    func testMovieListview_WhenScrollView_ThenSearchBarDisappear() {
        // Arrange
        app.launchEnvironment[ValueDefault.enviromentJsonURL] = ValueDefault.movieListJSON
        
        let scrollView = app.scrollViews[ValueDefault.movieListView]
        let headView = app.images[ValueDefault.logoImageHidden]
        
        // Act
        app.launch()

        scrollView.swipeUp()
        
        // Assert
        XCTAssertTrue(headView.exists)
    }
    
    func testMovieListView_WhenSearchBarIsSearching_ThenSearchViewDisplay() {
        // Arrange
        app.launchEnvironment[ValueDefault.enviromentJsonURL] = ValueDefault.movieListJSON
        
        let searchTextField = app.textFields[ValueDefault.searchBarView]
        let searchView = app.scrollViews[ValueDefault.searchView]
        
        // Act
        app.launch()
        
        searchTextField.tap()
        
        app.keys["V"].tap()
        
        // Assert
        XCTAssertTrue(searchView.exists)
    }
    
    func testMovieListView_WhenSearchBarIsSearching_ThenSearchViewHide() {
        // Arrange
        app.launchEnvironment[ValueDefault.enviromentJsonURL] = ValueDefault.movieListJSON
        
        let searchTextField = app.textFields[ValueDefault.searchBarView]
        let searchView = app.scrollViews[ValueDefault.searchView]
        
        // Act
        app.launch()
        
        searchTextField.tap()
        
        app.keys["T"].tap()
        app.keys["delete"].tap()
        
        // Assert
        XCTAssertFalse(searchView.exists)
    }
    
    func testMovieListView_WhenSearchBarISSearching_ThenShowmovieInList() {
        // Arrange
        app.launchEnvironment[ValueDefault.enviromentJsonURL] = ValueDefault.movieListDebugJSON
        
        let searchTextField = app.textFields[ValueDefault.searchBarView]
        let itemList = app.scrollViews[ValueDefault.searchView].otherElements.buttons["filterl_item_63eef9c6244a27600bb64828"]
        
        // Act
        app.launch()
        
        searchTextField.tap()
        
        app.keys["T"].tap()
        app.keys["h"].tap()
        app.keys["e"].tap()
        app.keys["space"].tap()
        app.keys["d"].tap()
        app.keys["a"].tap()
        app.keys["r"].tap()
        app.keys["k"].tap()
        app.keys["space"].tap()
        app.keys["k"].tap()
        app.keys["n"].tap()
        
        // Assert
        XCTAssertTrue(itemList.exists, "Item not found in movie list filter")
    }
    
    func testMovieListView_WhenSearchBarISSearching_ThenShowmovieListEmpty() {
        // Arrange
        app.launchEnvironment[ValueDefault.enviromentJsonURL] = ValueDefault.movieListDebugJSON
        
        let searchTextField = app.textFields[ValueDefault.searchBarView]
        let itemList = app.scrollViews[ValueDefault.searchView].otherElements.buttons
        
        // Act
        app.launch()
        
        searchTextField.tap()
        
        app.keys["S"].tap()
        app.keys["t"].tap()
        app.keys["a"].tap()
        app.keys["r"].tap()
        app.keys["space"].tap()
        app.keys["s"].tap()
        app.keys["h"].tap()
        app.keys["i"].tap()
        app.keys["p"].tap()
        
        // Assert
        XCTAssertTrue(itemList.count == 0, "Item should not found in movie list filter")
    }
    
    func testMovieListView_WhenSearchBarISSearching_ThenOpenDetail() {
        // Arrange
        app.launchEnvironment[ValueDefault.enviromentJsonURL] = ValueDefault.movieListDebugJSON
        
        let searchTextField = app.textFields[ValueDefault.searchBarView]
        let itemList = app.scrollViews[ValueDefault.searchView].otherElements.buttons["filterl_item_63eef9c6244a27600bb64828"]
        let detailView = app.otherElements[ValueDefault.movideDetailView]
        
        // Act
        app.launch()
        
        searchTextField.tap()
        
        app.keys["T"].tap()
        app.keys["h"].tap()
        app.keys["e"].tap()
        app.keys["space"].tap()
        app.keys["d"].tap()
        app.keys["a"].tap()
        app.keys["r"].tap()
        app.keys["k"].tap()
        app.keys["space"].tap()
        app.keys["k"].tap()
        app.keys["n"].tap()
        
        itemList.tap()
        
        // Assert
        XCTAssertTrue(detailView.exists, "Detail view not displayed")
    }
    
    
//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
