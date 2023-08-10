//
//  ColorName.swift
//  Common
//
//  Created by Anderson F Carvalho on 24/07/23.
//

import Foundation
import SwiftUI

public extension UIColor {
    indirect enum ColorName: String, CaseIterable, Codable {
        case gradient01
        case gradient02A
        case gradient02B
        case logo
        case blue02
        case blue03
        case primary
        case primaryText
        case background
        case titleRectangle
        case shadow
        case dividerPrimary
        
        public var currenColorScheme: Common_ColorScheme {
            return ColorName.getThemeColor
        }
        
        public var rawValue: UIColor { rawValue(currenColorScheme) }
        public var uiColor: UIColor { rawValue }
        public var color: Color { Color(uiColor: uiColor) }
        
        public func rawValue(_ on: Common_ColorScheme) -> UIColor {
            
            let cacheKey = "\(self)_\(on)"
            
            if let cachedValue = ColorsCache.shared.get(key: cacheKey) as? UIColor {
                return cachedValue
            }
            
            var result: UIColor?
            
            switch self {
            case .gradient01: result = on == .light ?
                UIColor.ColorPalleteBee.blue04.uiColor :
                UIColor.ColorPalleteBee.blue04.uiColor
                
            case .gradient02A: result = on == .light ?
                UIColor.ColorPalleteBee.blue02.uiColor :
                UIColor.ColorPalleteBee.neutral1000.uiColor
                
            case .gradient02B: result = on == .light ?
                UIColor.ColorPalleteBee.blue03.uiColor :
                UIColor.ColorPalleteBee.neutral1000.uiColor
                
            case .logo: result = on == .light ?
                UIColor.ColorPalleteBee.white01.uiColor :
                UIColor.ColorPalleteBee.primary200.uiColor
                
            case .blue02: result = on == .light ?
                UIColor.ColorPalleteBee.blue02.uiColor :
                UIColor.ColorPalleteBee.blue02.uiColor
                
            case .blue03: result = on == .light ?
                UIColor.ColorPalleteBee.blue03.uiColor :
                UIColor.ColorPalleteBee.blue03.uiColor
                
            case .primary: result = on == .light ?
                UIColor.ColorPalleteBee.primary100.uiColor :
                UIColor.ColorPalleteBee.neutral800.uiColor
                
            case .primaryText: result = on == .light ?
                UIColor.ColorPalleteBee.black.uiColor :
                UIColor.ColorPalleteBee.neutral100.uiColor
                
            case .background: result = on == .light ?
                UIColor.ColorPalleteBee.white.uiColor :
                UIColor.ColorPalleteBee.black.uiColor
                
            case .titleRectangle: result = on == .light ?
                UIColor.ColorPalleteBee.primary1000.uiColor :
                UIColor.ColorPalleteBee.primary200.uiColor
                
            case .shadow: result = on == .light ?
                UIColor.ColorPalleteBee.blue04.uiColor :
                UIColor.ColorPalleteBee.blue04.uiColor
                
            case .dividerPrimary: result = on == .light ?
                UIColor.ColorPalleteBee.neutral800.uiColor :
                UIColor.ColorPalleteBee.neutral100.uiColor
            }
            
            if let result = result {
                ColorsCache.shared.add(object: result, withKey: cacheKey)
                return result
            }
            
            return .clear
        }
        
        static var getThemeColor: Common_ColorScheme {
            if LocalDataAdapter.shared.valueString(from: .themeColorKey).isEmpty ||
                LocalDataAdapter.shared.valueString(from: .themeColorKey) == "system" {
                return Common_ColorScheme.current
            }
            
            return LocalDataAdapter.shared.valueString(from: .themeColorKey) == "light" ? .light : .dark
        }
    }
}

private struct ColorsCache {
    private init() {}
    public static let shared = ColorsCache()
    private var _cache = NSCache<NSString, AnyObject>()
    public func add(object: AnyObject, withKey: String) {
        objc_sync_enter(_cache); defer { objc_sync_exit(_cache) }
        _cache.setObject(object as AnyObject, forKey: withKey as NSString)
    }
    public func get(key: String) -> AnyObject? {
        objc_sync_enter(_cache); defer { objc_sync_exit(_cache) }
        if let object = _cache.object(forKey: key as NSString) { return object }
        return nil
    }
}

//rgba(14, 162, 227, 1)

internal extension UIColor {
    enum ColorPalleteBee: CaseIterable {
        case blue01
        case blue02
        case blue03
        case blue04
        
        case primary100
        case primary200
        case primary1000
        
        case neutral100
        case neutral800
        case neutral1000
        
        case white
        case white01
        case black
        
        public var uiColor: UIColor { rawValue }
        public var color: Color { Color(uiColor) }
        
        public var rawValue: UIColor {
            switch self {
            case .blue01: return UIColor.colorFromRGBString("14, 162, 227")
            case .blue02: return UIColor.colorFromRGBString("0, 98, 102")
            case .blue03: return UIColor.colorFromRGBString("110, 205, 247")
            case .blue04: return UIColor.colorFromRGBString("0, 71, 102")
            
            case .primary100: return UIColor.colorFromRGBString("207, 238, 252")
            case .primary200: return UIColor.colorFromRGBString("110, 205, 247")
            case .primary1000: return UIColor.colorFromRGBString("0, 35, 51")
                
            case .neutral100: return UIColor.colorFromRGBString("247, 248, 248")
            case .neutral800: return UIColor.colorFromRGBString("71, 79, 82")
            case .neutral1000: return UIColor.colorFromRGBString("24, 26, 27")
                                
            case .white: return UIColor.white
            case .white01: return UIColor.colorFromRGBString("217, 217, 217")
                
            case .black: return UIColor.black
            
            }
        }
    }
}
