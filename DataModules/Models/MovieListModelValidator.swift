//
//  MovieListModelValidator.swift
//  DataModules
//
//  Created by Anderson F Carvalho on 13/07/23.
//

import Foundation

class MovieListModelValidator: MovieListModelValidatorProtocol {
    func isMovieListModelEmpty(_ movieList: MovieList?) -> Bool {
        movieList?.isEmpty ?? true
    }
}
