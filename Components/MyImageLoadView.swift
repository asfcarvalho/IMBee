//
//  MyImageLoadView.swift
//  Components
//
//  Created by Anderson F Carvalho on 21/07/23.
//

import Foundation
import BaseUI
import SwiftUI
import Common

public extension ViewModel {
    enum MyImageLoadView {
        public enum ViewOutput {
            public enum Action: Hashable {
                case buttonTapped
            }
        }
        
        public class ViewInput: ObservableObject, Hashable {
            public static func == (lhs: ViewInput, rhs: ViewInput) -> Bool {
                lhs.urlString == rhs.urlString
            }
            
            public func hash(into hasher: inout Hasher) {
                hasher.combine(urlString)
            }
            
            public init(urlString: String? = nil,
                        size: CGSize = .zero) {
                self.urlString = urlString
                self.size = size
            }
            
            @Published public var urlString: String?
            @State public var size: CGSize
        }
    }
}

public struct MyImageLoadView: View {
    
    @ObservedObject var input: ViewModel.MyImageLoadView.ViewInput
    public var output = MyObservableObject<ViewModel.MyImageLoadView.ViewOutput.Action>()
        
    public init(input: ViewModel.MyImageLoadView.ViewInput) {
        self.input = input
    }
    
    public var body: some View {
        AsyncImage(
            url: URL(string: input.urlString ?? ""),
            content: { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: input.size.width, height: input.size.height)
            },
            placeholder: {
                ProgressView()
                    .frame(height: input.size.height)
            }
        ).ignoresSafeArea()
    }
}

struct MyImageLoadView_Previews: PreviewProvider {
    static var previews: some View {
        MyImageLoadView(input: .init(urlString: "https://m.media-amazon.com/images/M/MV5BZDA3NDExMTUtMDlhOC00MmQ5LWExZGUtYmI1NGVlZWI4OWNiXkEyXkFqcGdeQXVyNjc1NTYyMjg@._V1_QL75_UX380_CR0,5,380,562_.jpg", size: CGSize(width: 300, height: 400)))
//            .padding()
            .border(Color.red)
            .clipped()
    }
}
