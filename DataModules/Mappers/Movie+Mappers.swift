//
//  Movie+Mappers.swift
//  DataModules
//
//  Created by Anderson F Carvalho on 24/07/23.
//

import Foundation

public extension MovieModel {
    func asMovie() -> Movie {
        Movie(id: id,
              title: title,
              description: description,
              year: yearString,
              rating: "\(Int(Float(rating) ?? 0.0)) / 10",
              urlImage: thumbnail)
    }
}

public extension Sequence where Element == MovieModel {
    func asasMovieArray() -> [Movie] {
        self.map { $0.asMovie() }
    }
}
