//
//  MovieListDataSource.swift
//  DataModules
//
//  Created by Anderson F Carvalho on 14/07/23.
//

import Foundation
import UIKit

public class MovieListDataSource: MovieListDataSourceProtocol {
    
    var apiCalling: APICalling!
    var apiRequest: APIRequest!
    private var token = CancelBag()
    
    public init(apiCalling: APICalling = APICalling(),
                apiRequest: APIRequest = APIRequest()) {
        self.apiCalling = apiCalling
        self.apiRequest = apiRequest
    }
    
    public func fetchMovieList(urlString: String? = nil, callBack: @escaping (Result<MovieList, BeeError>) -> Void) {
        
        let urlString = urlString ?? APIStrings.baseUrl
        guard let url = URL(string: urlString),
                UIApplication.shared.canOpenURL(url) else {
            return callBack(.failure(BeeError.URLError))
        }
        
        apiRequest.updateBaseURL(url)
        
        apiCalling.fetch(apiRequest: apiRequest) { response in
            callBack(response)
        }
    }
}
