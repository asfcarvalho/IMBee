//
//  MovieModel.swift
//  DataModules
//
//  Created by Anderson F Carvalho on 13/07/23.
//

import Foundation

public struct MovieModel: Codable, Hashable {
    public let id: String
    public let description: String
    public let image: [[String]]
    public let rating: String
    public let title: String
    public let year: Int
    public var thumbnail: String? {
        image.first(where: { $0.contains("380")})?.last
    }
    public var yearString: String {
        "Year: \(year)"
    }

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case description, image, rating, title, year
    }
    
    public init(id: String, description: String, image: [[String]], rating: String, title: String, year: Int) {
        self.id = id
        self.description = description
        self.image = image
        self.rating = rating
        self.title = title
        self.year = year
    }
}

public typealias MovieList = [MovieModel]
