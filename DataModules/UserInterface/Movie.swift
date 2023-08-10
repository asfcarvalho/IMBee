//
//  Movie.swift
//  DataModules
//
//  Created by Anderson F Carvalho on 24/07/23.
//

import Foundation

public struct Movie: Hashable {
    public var id: String
    public let title: String
    public let description: String
    public let year: String
    public let rating: String
    public let urlImage: String?
    
    public init(id: String, title: String, description: String, year: String, rating: String, urlImage: String?) {
        self.id = id
        self.title = title
        self.description = description
        self.year = year
        self.rating = rating
        self.urlImage = urlImage
    }
}
