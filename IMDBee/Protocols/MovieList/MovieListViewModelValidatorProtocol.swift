//
//  MovieListViewModelValidatorProtocol.swift
//  IMDBee
//
//  Created by Anderson F Carvalho on 14/07/23.
//

import Foundation
import DataModules

protocol MovieListViewModelValidatorProtocol {
    func isMovieListEmpty(_ list: [Movie]?) -> Bool
    func isSearching(_ text: String) -> Bool
}
