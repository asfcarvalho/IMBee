//
//  MovieListViewModelProtocol.swift
//  IMDBee
//
//  Created by Anderson F Carvalho on 18/07/23.
//

import Foundation
import BaseUI
import DataModules
import Combine

public protocol MovieListViewModelProtocol: ObservableObject {
    var movieList: [Movie]? { get set }
    var movieTheaterList: [Movie]? { get set }
    var movieListFiltered: [Movie]? { get set }
    var isListEmpty: Bool { get set }
    var isLoading: Bool { get set }
    var isLightMode: Bool { get set }
    var isSearching: Bool { get set }
    func send(action: ViewModel.MovieList.ViewInput.Action)
}
