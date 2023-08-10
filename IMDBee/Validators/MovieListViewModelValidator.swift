//
//  MovieListViewModelValidator.swift
//  IMDBee
//
//  Created by Anderson F Carvalho on 14/07/23.
//

import Foundation
import DataModules

class MovieListViewModelValidator: MovieListViewModelValidatorProtocol {
    func isMovieListEmpty(_ list: [Movie]?) -> Bool {
        list?.isEmpty ?? true
    }
    
    func isSearching(_ text: String) -> Bool {
        !text.isEmpty
    }
}
