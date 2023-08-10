//
//  String+Extensions.swift
//  Common
//
//  Created by Anderson F Carvalho on 24/07/23.
//

import Foundation

public extension String {
    var trim: String { // Trim and single spaces
        return replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression).trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var numberValue: NSNumber? { NumberFormatter().number(from: cleanBeforeConversion.replace(",", with: ".")) }
    
    var cgFloatValue: CGFloat? {
        if let some = cleanBeforeConversion.numberValue {
            return CGFloat(truncating: some)
        }
        return CGFloat((self as NSString).floatValue)
    }
    
    func replace(_ some: String, with: String) -> String {
        guard !some.isEmpty else { return self }
        return replacingOccurrences(of: some, with: with)
    }
    
    func split(by: String) -> [String] {
        guard !by.isEmpty, let first = by.first else { return [] }
        return components(separatedBy: "\(first)")
    }
    
    private var cleanBeforeConversion: String {
        return replacingOccurrences(of: "\n", with: "").replacingOccurrences(of: " ", with: "")
    }
}
