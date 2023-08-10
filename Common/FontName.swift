//
//  FontName.swift
//  Common
//
//  Created by Anderson F Carvalho on 13/07/23.
//

import Foundation
import SwiftUI

public enum MyFont {
    case systenMedium13
    case systenMedium14
    case systemMedium16
    case systemMedium18
    case systemMedium20
    case systemMedium22
    case systemMedium24
    case systemSemiBold22
    case systemBold16
    case systemBold20
    case systemBold22
    
    public var font: Font {
        switch self {
        case .systenMedium13:
            return Font.system(size: 13, weight: .medium)
        case .systenMedium14:
            return Font.system(size: 14, weight: .medium)
        case .systemMedium16:
            return Font.system(size: 16, weight: .medium)
        case .systemMedium18:
            return Font.system(size: 18, weight: .medium)
        case .systemMedium20:
            return Font.system(size: 20, weight: .medium)
        case .systemMedium22:
            return Font.system(size: 22, weight: .medium)
        case .systemMedium24:
            return Font.system(size: 24, weight: .medium)
        case .systemSemiBold22:
            return Font.system(size: 22, weight: .semibold)
        case .systemBold16:
            return Font.system(size: 16, weight: .bold)
        case .systemBold20:
            return Font.system(size: 20, weight: .bold)
        case .systemBold22:
            return Font.system(size: 22, weight: .bold)
        }
    }
}
