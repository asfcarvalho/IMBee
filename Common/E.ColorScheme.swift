//
//  E.ColorScheme.swift
//  Common
//
//  Created by Anderson F Carvalho on 24/07/23.
//

import Foundation
import UIKit
import SwiftUI

public extension CommonNameSpace {
    enum ColorScheme: String, CaseIterable {
        
        public init?(rawValue: String) {
            if let some = Self.allCases.first(where: { $0.rawValue.lowercased() == rawValue.lowercased() }) {
                self = some
            } else {
                return nil
            }
        }
        
        case light
        case dark
        
        public static var current: Common_ColorScheme {
            UIView().traitCollection.userInterfaceStyle == .dark ? .dark : .light
        }
        
        public static var alternative: Common_ColorScheme {
            current == .dark ? .light: .dark
        }
        
        public static func currentWidget(_ colorScheme: SwiftUI.ColorScheme) -> Common_ColorScheme {
            colorScheme == .dark ? .dark : .light
        }
    }
}
