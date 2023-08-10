//
//  UserDefault+Extensions.swift
//  Common
//
//  Created by Anderson F Carvalho on 01/08/23.
//

import Foundation

public extension UserDefaults {
    enum SecureKey: String, CaseIterable {
        
        case themeColorKey = "themeColor.txt"
    }
    
    static func valueString(from key: SecureKey) -> String {
        let value = UserDefaults.standard.string(forKey: key.rawValue)
        return value ?? ""
    }
    
    static func setValue(value: String?, key: SecureKey) {
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
    }
}
