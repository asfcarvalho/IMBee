//
//  MovieListDataSourceTests.swift
//  DataModulesTests
//
//  Created by Anderson F Carvalho on 14/07/23.
//

import XCTest
import Common
@testable import DataModules

final class MovieListDataSourceTests: XCTestCase {
    
    var urlSession: URLSession!
    var apiCalling: APICalling!
    var sut: MovieListDataSource!

    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: config)
        apiCalling = APICalling(urlSession: urlSession)
        
        sut = MovieListDataSource(apiCalling: apiCalling)
    }

    override func tearDown() {
        urlSession = nil
        apiCalling = nil
        sut = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.error = nil
    }
    
    func testMovieListDataSource_WhenFetchMovieListResponse_ReturnsSuccess() {
        // Arrange
        let expectation = self.expectation(description: "Fetch Movie List Response Expectation")
        
        MockURLProtocol.stubResponseData = LoadJsonData.loadJsonData(filename: ValueDefault.movieListJSON)
        
        // Act
        sut.fetchMovieList() { result in
            
            // Assert
            switch result {
            case .success(let movieList):
                XCTAssertNotNil(movieList, "Fetch Movie List should not bee empty")
            case .failure(let error):
                XCTAssertNil(error, "Fetch Movie List should not be empty")
            }
            
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testMovieListDataSource_WhenFetchMovieListResponse_ReturnURLError() {
        // Arrange
        let expectation = self.expectation(description: "Fetch Movie List Response Expectation")
        
        // Act
        sut.fetchMovieList(urlString: "") { result in
            
            // Assert
            switch result {
            case .success(let movieList):
                XCTAssertNotNil(movieList, "Fetch Movie List should be URLError")
            case .failure(let error):
                XCTAssertEqual(error, BeeError.URLError, "Error type should be URLError")
            }
            
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testMovieListDataSource_WhenFetchMovieListData_ReturnsDecoderError() {
        // Arrange
        let expectation = self.expectation(description: "Fetch Movie List Response Expectation")
        
            MockURLProtocol.stubResponseData = LoadJsonData.loadJsonData(filename: ValueDefault.movieListDataErrorJSON)
        
        // Act
        sut.fetchMovieList() { result in
            
            // Assert
            switch result {
            case .success(let movieList):
                XCTAssertNotNil(movieList, "Fetch Movie List should be ErrorDecoder")
            case .failure(let error):
                XCTAssertEqual(error, BeeError.ErrorDecoder, "Error type should be ErrorDecoder")
            }
            
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testMovieListDataSource_WhenFetchMovieListData_ReturnsDataError() {
        // Arrange
        let expectation = self.expectation(description: "Fetch Movie List Response Expectation")
                
        // Act
        sut.fetchMovieList() { result in
            
            // Assert
            switch result {
            case .success(let movieList):
                XCTAssertNotNil(movieList, "Fetch Movie List should be DataError")
            case .failure(let error):
                XCTAssertEqual(error, BeeError.ErrorDataEmpty, "Error type should be DataError")
            }
            
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testMovieListDataSource_WhenFetchMovieListData_ReturnsError() {
        // Arrange
        let expectation = self.expectation(description: "Fetch Movie List Response Expectation")
//        let errorDescription = "API error response"
//        MockURLProtocol.error = BeeError.Error(description: errorDescription)
        MockURLProtocol.error = BeeError.ErrorError
                
        // Act
        sut.fetchMovieList() { result in
            
            // Assert
            switch result {
            case .success(let movieList):
                XCTAssertNotNil(movieList, "Fetch Movie List should be Error")
            case .failure(let error):
                XCTAssertEqual(error, BeeError.ErrorError, "Error type should be Error")
//                XCTAssertEqual(error, BeeError.Error(description: errorDescription), "Error type should be DataError")
            }
            
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
}
