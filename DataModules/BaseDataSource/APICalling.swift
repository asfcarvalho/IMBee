//
//  APICalling.swift
//  DataModules
//
//  Created by Anderson F Carvalho on 17/07/23.
//

import Foundation
import SystemConfiguration
import Combine
import Common

public enum BeeError: Error, Equatable {
    case ErrorDefault
    case URLError
    case Error(description: String)
    case ErrorError
    case ErrorDecoder
    case ErrorDataEmpty
}
    
extension BeeError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .Error(let description):
            return description
        case .ErrorDefault, .ErrorError, .URLError, .ErrorDecoder, .ErrorDataEmpty:
            return ""
        }
    }
}

public class APICalling {
    
    var urlSession: URLSession?
    private var token = CancelBag()
    
    public init(urlSession: URLSession? = nil) {
        self.urlSession = urlSession
    }
    
    func fetch<T: Codable>(apiRequest: APIRequest, callBack: @escaping (Result<T, BeeError>) -> Void) {
        
        
        if ProcessInfo.processInfo.arguments.contains(ValueDefault.argumentsUITesting) {
            testingFetch(apiRequest: apiRequest, callBack: callBack)
            return
        }
        
        #if DEBUG
        debugFetch(apiRequest: apiRequest, callBack: callBack)
        return
        #endif
        
        
        let request = apiRequest.request()
        
        let urlConfiguration = URLSessionConfiguration.default
        urlConfiguration.waitsForConnectivity = true
        urlConfiguration.timeoutIntervalForRequest = 12
        urlConfiguration.timeoutIntervalForResource = 12
        
        let urlSession = urlSession ?? URLSession(configuration: urlConfiguration)
        
        urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                callBack(.failure(.ErrorError))
                return
            }
            
            guard let data = data, !data.isEmpty else {
                return callBack(.failure(BeeError.ErrorDataEmpty))
            }
            
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                callBack(.success(response))
            } catch {
                callBack(.failure(.ErrorDecoder))
            }
            
        }.resume()
    }
    
    private func testingFetch<T: Codable>(apiRequest: APIRequest, callBack: @escaping (Result<T, BeeError>) -> Void) {
        guard let value = ProcessInfo.processInfo.environment[ValueDefault.enviromentJsonURL],
              let jsonData = LoadJsonData.loadJsonData(filename: value) else {
            callBack(.failure(BeeError.ErrorDataEmpty))
            return
        }
        
        do {
            let response = try JSONDecoder().decode(T.self, from: jsonData)
            callBack(.success(response))
        } catch {
            callBack(.failure(.ErrorDecoder))
        }
    }
    
    private func debugFetch<T: Codable>(apiRequest: APIRequest, callBack: @escaping (Result<T, BeeError>) -> Void) {
        guard let jsonData = LoadJsonData.loadJsonData(filename: ValueDefault.movieListDebugJSON) else {
            callBack(.failure(BeeError.ErrorDataEmpty))
            return
        }
        
        do {
            let response = try JSONDecoder().decode(T.self, from: jsonData)
            callBack(.success(response))
        } catch {
            callBack(.failure(.ErrorDecoder))
        }
    }
}
