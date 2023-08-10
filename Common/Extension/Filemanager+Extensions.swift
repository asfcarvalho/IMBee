//
//  Filemanager+Extensions.swift
//  Common
//
//  Created by Anderson F Carvalho on 24/07/23.
//

import Foundation

public extension FileManager {
    
    static let fileAccessQueue = DispatchQueue(label: "\(FileManager.self).group.bee-eng.pt.queue")
    
    enum SecureKey: String, CaseIterable {
        
        case themeColorFilename = "themeColor.txt"
    }
    
    static let appGroupContainerURL = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask)[0]
        
    static func valueString(from key: SecureKey) -> String {
//        return fileAccessQueue.sync {
        let url = FileManager.appGroupContainerURL.appendingPathComponent(key.rawValue)
            let value = try? String(contentsOf: url, encoding: .utf8)
            return value ?? ""
//        }
    }
    
    static func setValue(value: String?, key: SecureKey) {
//        fileAccessQueue.async {
            do {
                let url = FileManager.appGroupContainerURL.appendingPathComponent(key.rawValue)
                if let value = value {
                    let data = Data(value.utf8)
                    try data.write(to: url)
                } else {
                    if FileManager.default.fileExists(atPath: url.path) {
                        try FileManager.default.removeItem(at: url)
                    }
                }
            } catch {
                // swiftlint:disable logs_rule_1
                debugPrint(error)
                // swiftlint:enable logs_rule_1
            }
//        }
    }
}
