//
//  MovieDetailViewModelValidator.swift
//  IMDBee
//
//  Created by Anderson F Carvalho on 19/07/23.
//

import Foundation
import DataModules

class MovieDetailViewModelValidator: MovieDetailViewModelValidatorProtocol {
    func isTitleEmpty(_ movie: Movie) -> Bool {
        movie.title.isEmpty
    }
    
    func isRatingNumber(_ rating: String) -> Bool {
        Float(rating) != nil
    }
    
    func isDescriptionEmpty(_ description: String) -> Bool {
        description.isEmpty
    }
    
    func isThumbnailEmpty(_ image: String?) -> Bool {
        image?.isEmpty ?? true
    }
    
    func shuldDisplayView(_ movie: Movie?) -> Bool {
        guard let movie = movie else { return false }
        return !isThumbnailEmpty(movie.urlImage) && !movie.description.isEmpty && !movie.title.isEmpty
    }
}
