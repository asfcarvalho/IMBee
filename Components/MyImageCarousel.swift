//
//  MyImageCarousel.swift
//  Components
//
//  Created by Anderson F Carvalho on 21/07/23.
//

import Foundation
import BaseUI
import SwiftUI
import Common
import DataModules

public extension ViewModel {
    enum MyImageCarousel {
        public enum ViewOutput {
            public enum Action: Hashable {
                case itemTapped(_ id: String)
            }
        }
        
        public class ViewInput: ObservableObject, Hashable {
            public static func == (lhs: ViewInput, rhs: ViewInput) -> Bool {
                lhs.itemList == rhs.itemList
            }
            
            public func hash(into hasher: inout Hasher) {
                hasher.combine(itemList)
            }
            
            public init(itemList: [Movie] = [],
                        size: CGSize = .zero,
                        horizontalPadding: CGFloat? = nil) {
                self.itemList = itemList
                self.size = size
                self.horizontalPadding = horizontalPadding
            }
            
            @Published public var itemList: [Movie]
            @State public var size: CGSize
            @Published public var horizontalPadding: CGFloat?
        }
    }
}

public struct MyImageCarousel: View {
    
    @ObservedObject var input: ViewModel.MyImageCarousel.ViewInput
    public var output = MyObservableObject<ViewModel.MyImageCarousel.ViewOutput.Action>()
        
    public init(input: ViewModel.MyImageCarousel.ViewInput) {
        self.input = input
    }
    
    public var body: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(input.itemList, id: \.self) { item in
                        Button {
                            output.value.send(.itemTapped(item.id))
                        } label: {
                            ZStack(alignment: .bottom) {
                                imageLoadView(item.urlImage)
                                VStack(alignment: .leading) {
                                    Text(item.title)
                                        .lineLimit(1)
                                        .font(MyFont.systemBold22.font)
                                        .foregroundColor(.white)
                                        .frame(width: input.size.width - 32, alignment: .leading)
                                    HStack(alignment: .center) {
                                        Text(item.year)
                                            .font(MyFont.systemMedium18.font)
                                            .foregroundColor(.white)
                                        Spacer()
                                        Text(item.rating)
                                            .font(MyFont.systemMedium18.font)
                                            .foregroundColor(.white)
                                        ImageName.iconRating.image
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                    }
                                }.padding(16)
                                    .clipped()
                                    .background(
                                        LinearGradient(gradient:
                                                        Gradient(colors: [ColorName.gradient01.color.opacity(0), ColorName.gradient01.color]),
                                                       startPoint: .top, endPoint: .bottom)
                                        
                                        
                                    )
                            }.clipped()
                        }.accessibilityIdentifier("carousel_item_\(item.id)")
                    }
                }.padding(.horizontal, input.horizontalPadding ?? UIScreen.screenWidth / 2 - input.size.width / 2)
            }.accessibilityIdentifier(ValueDefault.carouselList)
        }.frame(width: UIScreen.screenWidth)
            
    }
    
    private func imageLoadView(_ urlString: String?) -> some View {
        let imageView = MyImageLoadView(input: .init(urlString: urlString,
                                                     size: CGSize(width: input.size.width, height: input.size.height)))
        
        return imageView
    }
}

struct MyImageCarousel_Previews: PreviewProvider {
    static var previews: some View {
        MyImageCarousel(input: .init(itemList: [Movie(id: "1", title: "The Lord of the Rings: The Return of the King", description: "", year: "1986", rating: "07 / 10", urlImage: "https://m.media-amazon.com/images/M/MV5BZDA3NDExMTUtMDlhOC00MmQ5LWExZGUtYmI1NGVlZWI4OWNiXkEyXkFqcGdeQXVyNjc1NTYyMjg@._V1_QL75_UX380_CR0,5,380,562_.jpg"), Movie(id: "2", title: "The Lord of the Rings: The Return of the King", description: "", year: "1986", rating: "07 / 10", urlImage: "https://m.media-amazon.com/images/M/MV5BM2MyNjYxNmUtYTAwNi00MTYxLWJmNWYtYzZlODY3ZTk3OTFlXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_QL75_UY562_CR8,0,380,562_.jpg"), Movie(id: "3", title: "The Lord of the Rings: The Return of the King", description: "", year: "1986", rating: "07 / 10", urlImage: "https://m.media-amazon.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_QL75_UX380_CR0,0,380,562_.jpg"), Movie(id: "4", title: "The Lord of the Rings: The Return of the King", description: "", year: "1986", rating: "07 / 10", urlImage: "https://m.media-amazon.com/images/M/MV5BNDE4OTMxMTctNmRhYy00NWE2LTg3YzItYTk3M2UwOTU5Njg4XkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_QL75_UX380_CR0,4,380,562_.jpg")], size: CGSize(width: 250, height: 400)))
            .padding()
    }
}
