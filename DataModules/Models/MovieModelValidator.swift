//
//  MovieModelValidator.swift
//  DataModules
//
//  Created by Anderson F Carvalho on 13/07/23.
//

import Foundation
import UIKit

class MovieModelValidator: MovieModelValidatorProtocol {
    func isImage285SizeValid(_ url: String?) -> Bool {
        guard let urlString = url, let url = URL(string: urlString) else {
            return false
        }
        
        return UIApplication.shared.canOpenURL(url)
    }
    
    func isIMDBRatingNumberValid(_ rating: String?) -> Bool {
        guard let rating = rating, Float(rating) != nil else {
            return false
        }
        
        return true
    }
    
    func isMovieTitleEmpty(_ title: String?) -> Bool {
        title?.isEmpty ?? true
    }
}
