//
//  MovieListDataSourceProtocol.swift
//  DataModules
//
//  Created by Anderson F Carvalho on 18/07/23.
//

import Foundation

public protocol MovieListDataSourceProtocol {
    func fetchMovieList(urlString: String?, callBack: @escaping (Result<MovieList, BeeError>) -> Void)
}
