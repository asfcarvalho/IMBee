//
//  LocalDataAdapter.swift
//  Common
//
//  Created by Anderson F Carvalho on 01/08/23.
//

import Foundation

public class LocalDataAdapter {
    
    public static let shared = LocalDataAdapter()
    
    public enum SecureKey: String, CaseIterable {
        
        case themeColorKey = "themeColor.txt"
    }
    
    public func valueString(from key: SecureKey) -> String {
        guard let key = FileManager.SecureKey(rawValue: key.rawValue) else {
            return ""
        }

        return FileManager.valueString(from: key)
//        guard let key = UserDefaults.SecureKey(rawValue: key.rawValue) else {
//            return ""
//        }
//
//        return UserDefaults.valueString(from: key)
    }
    
    public func setValue(value: String?, key: SecureKey) {
        guard let key = FileManager.SecureKey(rawValue: key.rawValue) else {
            return
        }

        FileManager.setValue(value: value, key: key)
//        guard let key = UserDefaults.SecureKey(rawValue: key.rawValue) else {
//            return
//        }
//
//        UserDefaults.setValue(value: value, key: key)
    }
}
