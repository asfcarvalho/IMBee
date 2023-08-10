//
//  MovieDetailViewModelValidatorProtocol.swift
//  IMDBee
//
//  Created by Anderson F Carvalho on 19/07/23.
//

import Foundation
import DataModules

protocol MovieDetailViewModelValidatorProtocol {
    func isTitleEmpty(_ movie: Movie) -> Bool
    func isRatingNumber(_ rating: String) -> Bool
    func isDescriptionEmpty(_ description: String) -> Bool
    func isThumbnailEmpty(_ image: String?) -> Bool
    func shuldDisplayView(_ movie: Movie?) -> Bool
}
