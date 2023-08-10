//
//  APIRequest.swift
//  DataModules
//
//  Created by Anderson F Carvalho on 17/07/23.
//

import Foundation

public class APIRequest {
    var baseURL: URL!
    var method = "GET"
    var parameters = [String: String]()
    
    public init(method: String = "GET",
                parameters: [String : String] = [String: String]()) {
        self.method = method
        self.parameters = parameters
    }
    
    func updateBaseURL(_ url: URL) {
        baseURL = url
    }
    
    func request() -> URLRequest {
        var request = URLRequest(url: baseURL)
        request.httpMethod = method
        request.allHTTPHeaderFields = ["X-RapidAPI-Host" : "imdb-top-100-movies1.p.rapidapi.com",
                                       "X-RapidAPI-Key": "5hSVqPq1ptmshCoghNj5wfJ0eAZOp1od3W4jsn48IvJQ761IjW"]
        return request
    }
}
