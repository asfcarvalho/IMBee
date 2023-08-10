//
//  MySearchBar.swift
//  Components
//
//  Created by Anderson F Carvalho on 26/07/23.
//

import Foundation
import BaseUI
import SwiftUI
import Common

public extension ViewModel {
    enum MySearchBar {
        public enum ViewOutput {
            public enum Action: Hashable {
                case buttonTapped
                case searching(_ text: String)
            }
        }
        
        public class ViewInput: ObservableObject, Hashable {
            public static func == (lhs: ViewInput, rhs: ViewInput) -> Bool {
                lhs.textSearching == rhs.textSearching
            }
            
            public func hash(into hasher: inout Hasher) {
                hasher.combine(textSearching)
            }
            
            public init(textSearching: String = "",
                        placeholder: String = "",
                        size: CGSize = CGSize(width: UIScreen.screenWidth,
                                              height: 30)) {
                self.textSearching = textSearching
                self.placeholder = placeholder
                self.size = size
            }
            
            @Published var textSearching: String
            @State var placeholder: String
            @State var size: CGSize
        }
    }
}

public struct MySearchBar: View {
    
    @ObservedObject var input: ViewModel.MySearchBar.ViewInput
    public var output = MyObservableObject<ViewModel.MySearchBar.ViewOutput.Action>()
        
    public init(input: ViewModel.MySearchBar.ViewInput) {
        self.input = input
    }
    
    public var body: some View {
        HStack {
            ImageName.iconSearch.image
                .resizable()
                .frame(width: 15, height: 15)
                .padding(.leading)
            TextField(input.placeholder, text: $input.textSearching)
                .onChange(of: input.textSearching) { newValue in
                output.value.send(.searching(input.textSearching))
            }
            if !input.textSearching.isEmpty {
                Button {
                    input.textSearching = ""
                    output.value.send(.buttonTapped)
                } label: {
                    ImageName.iconClose.image
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(.trailing)
                }
            }

        }.frame(maxWidth: input.size.width, maxHeight: input.size.height)
            .background(Color.white)
            .cornerRadius(input.size.height / 2)
    }
}

struct MySearchBar_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            MySearchBar(input: .init(textSearching: "Searching...", placeholder: "Searching for..."))
                .padding()
        }.background(Color.yellow)
    }
}
