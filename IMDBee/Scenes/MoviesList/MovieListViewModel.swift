//
//  MovieListViewModelViewModel.swift
//  IMDBee
//
//  Created by Anderson F Carvalho on 13/07/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import BaseUI
import DataModules
import Common

class MovieListViewModel: MovieListViewModelProtocol {
    
    @Published var isListEmpty: Bool = false
    @Published var movieList: [Movie]?
    @Published var movieTheaterList: [Movie]?
    @Published var isLoading: Bool = false
    @Published var isLightMode: Bool = true
    @Published var isSearching: Bool = false
    @Published var movieListFiltered: [Movie]?
    
    var router: MovieListRouter?
    var movieListValidator: MovieListViewModelValidator?
    var movieDataSource: MovieListDataSourceProtocol!
    
    init(_ movieList: [Movie]? = nil,
         movieListValidator: MovieListViewModelValidator,
         movieDataSource: MovieListDataSourceProtocol) {
        self.movieList = movieList
        self.movieListValidator = movieListValidator
        self.movieDataSource = movieDataSource
    }
    
    public func send(action: ViewModel.MovieList.ViewInput.Action) {
        switch action {
        case .dismiss:
            router?.perform(action: .dismiss)
        case .viewDidLoad:
            fetchMovieList()
            getThemeColorMode()
        case .showDetail(let movieId):
            let movie = self.movieList?.first(where: { $0.id == movieId })
            router?.perform(action: .showDetail(movie))
        case .darkModeChanged(let status):
            if status {
                LocalDataAdapter.shared.setValue(value: ValueDefault.light, key: .themeColorKey)
            } else {
                LocalDataAdapter.shared.setValue(value: ValueDefault.dark, key: .themeColorKey)
            }
            
            self.isLightMode = status
            
        case .isSearching(let text):
            isSearching = movieListValidator?.isSearching(text) ?? false
            self.movieListFiltered = filteringMovieList(text)
        }
    }
    
    private func getThemeColorMode() {
        #if DEBUG
        if let value = ProcessInfo.processInfo.environment[ValueDefault.themeColorTest] {
            LocalDataAdapter.shared.setValue(value: value, key: .themeColorKey)
        }
        #endif
        
        let themeColor = LocalDataAdapter.shared.valueString(from: .themeColorKey)
        
        self.isLightMode = themeColor == ValueDefault.light
    }
    
    private func fetchMovieList() {
        movieDataSource.fetchMovieList(urlString: nil) { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    let movieList = success.asasMovieArray()
                    self.isListEmpty = false
                    self.movieList = movieList
                    self.movieTheaterList = movieList.suffix(5)
                    self.isLoading = false
                }
            case .failure(let failure):
                debugPrint(failure)
                DispatchQueue.main.async {
                    self.movieList = nil
                    self.movieTheaterList = nil
                    self.isListEmpty = true
                    self.isLoading = false
                }
            }
        }
    }
    
    private func filteringMovieList(_ text: String) -> [Movie]? {
        self.movieList?.filter({ $0.title.localizedCaseInsensitiveContains(text) })
    }
}

public extension ViewModel {
    enum MovieList {
        public enum ViewOutput {
            public enum Action: Hashable {
                case dismiss
                case showDetail(_ movieId: String)
                case darkModeChanged(_ status: Bool)
                case isSearching(_ text: String)
            }
        }
        
        public enum ViewInput: Hashable {
            public enum Action: Hashable {
                case dismiss
                case viewDidLoad
                case showDetail(_ movieId: String)
                case darkModeChanged(_ status: Bool)
                case isSearching(_ text: String)
            }
        }
    }
}
