//
//  MockMovieListDataSource.swift
//  IMDBeeTests
//
//  Created by Anderson F Carvalho on 18/07/23.
//

import Foundation
import DataModules
import XCTest

class MockMovieListDataSource: MovieListDataSourceProtocol {
    
    var movieList: MovieList?
    var error: BeeError?
    var expectation: XCTestExpectation?
    
    func fetchMovieList(urlString: String?, callBack: @escaping (Result<MovieList, BeeError>) -> Void) {
        if let movieList = movieList {
            callBack(.success(movieList))
        } else if let error = error {
            callBack(.failure(error))
        } else {
            callBack(.failure(.ErrorDefault))
        }
        
        expectation?.fulfill()
    }
}
