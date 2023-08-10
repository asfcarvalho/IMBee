//
//  ObservableObject+Generic.swift
//  Common
//
//  Created by Anderson F Carvalho on 13/07/23.
//

import Foundation
import Combine

public class MyObservableObject<T: Hashable>: ObservableObject {
    public init() { }
    public var value = PassthroughSubject<T, Never>()
}
