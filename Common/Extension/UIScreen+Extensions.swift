//
//  UIScreen+Extensions.swift
//  Common
//
//  Created by Anderson F Carvalho on 13/07/23.
//

import Foundation
import SwiftUI

public extension UIScreen {
    static var screenWidth: CGFloat { UIScreen.main.bounds.size.width }
    static var screenHeight: CGFloat { UIScreen.main.bounds.size.height }
}
