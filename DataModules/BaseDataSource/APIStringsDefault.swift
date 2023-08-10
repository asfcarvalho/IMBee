//
//  APIStringsDefault.swift
//  DataModules
//
//  Created by Anderson F Carvalho on 17/07/23.
//

import Foundation

public class APIStrings {
    static var baseUrl: String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String else {
            fatalError("Could not find BaseURL variable in info.plist")
        }
        return value
    }
}
