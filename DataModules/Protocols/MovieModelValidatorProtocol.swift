//
//  MovieModelValidatorProtocol.swift
//  DataModules
//
//  Created by Anderson F Carvalho on 13/07/23.
//

import Foundation

protocol MovieModelValidatorProtocol {
    func isImage285SizeValid(_ url: String?) -> Bool
    func isIMDBRatingNumberValid(_ rating: String?) -> Bool
    func isMovieTitleEmpty(_ title: String?) -> Bool
}
