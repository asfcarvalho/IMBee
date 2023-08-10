//
//  UIColor+Extensions.swift
//  Common
//
//  Created by Anderson F Carvalho on 24/07/23.
//

import Foundation
import UIKit

public extension UIColor {
    static func colorFromRGBString(_ rgb: String) -> UIColor {
        guard !rgb.isEmpty else { return .black }

        if let cachedValue = ColorsCache.shared.get(key: rgb) as? UIColor { return cachedValue }

        var color: UIColor = .black
        let rgbSafe = rgb.trim.replace(";", with: ",")
        let splited = rgbSafe.split(by: ",")
        if splited.count>=3 {
            let red   = splited[0].cgFloatValue ?? 0
            let green = splited[1].cgFloatValue ?? 0
            let blue  = splited[2].cgFloatValue ?? 0
            if splited.count==4 {
                let alpha = splited[3].cgFloatValue ?? 1
                color = UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)

            } else {
                color = UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1)
            }
        } else {
            return colorFromHexString(rgb)
        }
        ColorsCache.shared.add(object: color, withKey: rgb)
        return color
    }
    
    static func colorFromHexString(_ hexString: String, alpha: Float=1.0) -> UIColor {

        func colorComponentsFrom(_ string: String, start: Int, length: Int) -> Float {
            let subString = (string as NSString).substring(with: NSMakeRange(start, length))
            var hexValue: UInt64 = 0
            Scanner(string: subString).scanHexInt64(&hexValue)
            return Float(hexValue) / 255.0
        }

        if let cachedValue = ColorsCache.shared.get(key: hexString) as? UIColor { return cachedValue }
        let colorString = hexString.replace("#", with: "").uppercased()
        let red, blue, green: Float
        red   = colorComponentsFrom(colorString, start: 0, length: 2)
        green = colorComponentsFrom(colorString, start: 2, length: 2)
        blue  = colorComponentsFrom(colorString, start: 4, length: 2)
        let color = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: CGFloat(alpha))
        ColorsCache.shared.add(object: color, withKey: hexString)
        return color
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
}
