//
//  ImageName.swift
//  Common
//
//  Created by Anderson F Carvalho on 21/07/23.
//

import Foundation
import SwiftUI

public enum ImageName: String, CaseIterable, Codable {
    case none
    case iconRating = "iconRating"
    case imageLogo = "imageLogo"
    case iconToggleLight = "iconToggleLight"
    case iconToggleDark = "iconToggleDark"
    case iconSearch = "magnifyingglass"
    case iconClose = "xmark.circle"
    
    public var name: String {
        self.rawValue
    }
    
    public var image: Image {
        Image(uiImage: uiImage)
    }
    
    public var imageTemplate: Image {
        Image(uiImage: uiImage).renderingMode(.template)
    }    
    
    public var uiImage: UIImage {
        let value = self.rawValue
        return uiImage(by: value)
    }
    
    private func uiImage(by named: String) -> UIImage {
        let bundle = Bundle(for: BundleFinder.self)
        if self == ImageName.none {
            return UIImage()
        } else if let result = UIImage(named: named) {
            return result
        } else if let result = UIImage(systemName: named) {
            return result
        } else if let result = UIImage(named: named, in: bundle, compatibleWith: nil) {
            return result
        }
        debugPrint("Image not found [\(self)]")
        return UIImage()
    }
}
