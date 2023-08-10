//
//  MyNavigationBarView.swift
//  Components
//
//  Created by Anderson F Carvalho on 13/07/23.
//

import Foundation
import Combine
import SwiftUI
import BaseUI
import Common

public extension ViewModel {
    enum MyNavigationBar {
        public enum ViewOutput {
            public enum Action: Hashable {
                case buttonTapped
            }
        }
        
        public class ViewInput: ObservableObject, Hashable {
            public static func == (lhs: ViewInput, rhs: ViewInput) -> Bool {
                lhs.title == rhs.title
            }
            
            public func hash(into hasher: inout Hasher) {
                hasher.combine(title)
            }
            
            public init(title: String? = nil,
                        rigthButtonText: String? = nil) {
                self.title = title
                self.rightButtonText = rigthButtonText
            }
            
            @Published public var title: String?
            @Published public var rightButtonText: String?
        }
    }
}

public struct MyNavigationBarView: View {
    
    @ObservedObject var input: ViewModel.MyNavigationBar.ViewInput
    public var output = MyObservableObject<ViewModel.MyNavigationBar.ViewOutput.Action>()
        
    public init(input: ViewModel.MyNavigationBar.ViewInput) {
        self.input = input
    }
    
    public var body: some View {
        HStack {
            Spacer()
            Text(input.title ?? "")
                .font(MyFont.systemBold22.font)
                .multilineTextAlignment(.center)
            Spacer()
            Button {
                output.value.send(.buttonTapped)
            } label: {
                if let text = input.rightButtonText {
                    Text(text)
                        .font(MyFont.systenMedium14.font)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                }
            }.padding(.trailing)
        }.frame(width: UIScreen.screenWidth, height: 40, alignment: .leading)
    }
}

struct MyNavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        MyNavigationBarView(input: .init(title: "Title", rigthButtonText: "Menu"))
            .padding()
    }
}
