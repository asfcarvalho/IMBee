//
//  MockMovieListViewModel.swift
//  IMDBeeTests
//
//  Created by Anderson F Carvalho on 18/07/23.
//

import Foundation
import BaseUI
import IMDBee
import DataModules
import XCTest

class MockMovieListViewModel: MovieListViewModelProtocol {
    
    var isLightMode: Bool = true
    var isLoading: Bool = true
    var isListEmpty: Bool = true
    var isSearching: Bool = false
    var movieList: [Movie]?
    var movieTheaterList: [Movie]?
    var movieListFiltered: [Movie]?
    var fetchMovieSuccess: Bool!
    var showDetailSuccess: Bool = false
    var expectation: XCTestExpectation?
    
    var movieDataSource: MovieListDataSourceProtocol?
    
    init(movieDataSource: MovieListDataSourceProtocol? = nil) {
        self.movieDataSource = movieDataSource
    }
    
    func send(action: ViewModel.MovieList.ViewInput.Action) {
        switch action {
        case .dismiss:
            expectation?.fulfill()
        case .viewDidLoad:
            fetchMovieSuccess = true
            movieDataSource?.fetchMovieList(urlString: nil) { result in
                switch result {
                case .success(let success):
                    self.movieList = success.asasMovieArray()
                    self.isListEmpty = false
                    self.isLoading = false
                case .failure:
                    self.movieList = nil
                    self.isListEmpty = true
                    self.isLoading = false
                }
                self.expectation?.fulfill()
            }
        case .showDetail:
            showDetailSuccess = true
            expectation?.fulfill()
        case .darkModeChanged(let status):
            isLightMode = status
        case .isSearching(let text):
            isSearching = !text.isEmpty
            self.movieListFiltered = self.movieList?.filter({ $0.title.localizedCaseInsensitiveContains(text) })
        case .darkModeDetailChanged(let status):
            isLightMode = status
        }
    }
}
