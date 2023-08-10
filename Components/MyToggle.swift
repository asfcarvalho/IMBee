//
//  MyToggle.swift
//  Components
//
//  Created by Anderson F Carvalho on 25/07/23.
//

import Foundation
import BaseUI
import SwiftUI
import Common

public extension ViewModel {
    enum MyToggle {
        public enum ViewOutput {
            public enum Action: Hashable {
                case toggleTapped(_ status: Bool)
            }
        }
        
        public class ViewInput: ObservableObject, Hashable {
            public static func == (lhs: ViewInput, rhs: ViewInput) -> Bool {
                lhs.isEnabled == rhs.isEnabled
            }
            
            public func hash(into hasher: inout Hasher) {
                hasher.combine(isEnabled)
            }
            
            public init(isEnabled: Bool = true,
                        size: CGSize = .zero) {
                self.isEnabled = isEnabled
                self.size = size
            }
            
            @Published public var isEnabled: Bool
            @Published public var size: CGSize
        }
    }
}

public struct MyTuggle: View {
    
    @ObservedObject var input: ViewModel.MyToggle.ViewInput
    public var output = MyObservableObject<ViewModel.MyToggle.ViewOutput.Action>()
        
    public init(input: ViewModel.MyToggle.ViewInput) {
        self.input = input
    }
    
    public var body: some View {
        (input.isEnabled ? ImageName.iconToggleLight.image : ImageName.iconToggleDark.image)
            .resizable()
            .animation(.linear)
            .onTapGesture {
                input.isEnabled.toggle()
                output.value.send(.toggleTapped(input.isEnabled))
            }
            
            .frame(width: input.size.width, height: input.size.height)
            .accessibilityIdentifier(input.isEnabled ? ValueDefault.themeDarkMode : ValueDefault.themeLightMode)
    }
}

struct MyTuggle_Previews: PreviewProvider {
    static var previews: some View {
        MyTuggle(input: .init(size: CGSize(width: 55, height: 30)))
    }
}
