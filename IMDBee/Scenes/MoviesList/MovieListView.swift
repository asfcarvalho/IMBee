//
//  MovieListViewView.swift
//  IMDBee
//
//  Created by Anderson F Carvalho on 13/07/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import Common
import BaseUI
import Components
import DataModules

struct MovieListView<T: MovieListViewModelProtocol>: View {
    @ObservedObject var input: T
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    public var output = MyObservableObject<ViewModel.MovieList.ViewOutput.Action>()
    
    private var token = CancelBag()
    
    @State var searchText: String = ""
    @State var searchbarY: CGFloat = 0
    
    init(input: T) {
        self.input = input
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                ZStack {
                    if input.isSearching {
                        searchingView
                    } else if input.isLoading {
                        ProgressView()
                    } else if input.isListEmpty {
                        Text("Empty")
                            .accessibilityIdentifier(ValueDefault.movieListEmpty)
                    } else {
                        ScrollView {
                            VStack(spacing: 40) {
                                if let movieTheaterList = input.movieTheaterList {
                                    moviesInTheater(movieTheaterList)
                                }
                                if let movieList = input.movieList {
                                    topMovieListView(movieList)
                                }
                            }
                            .padding(.top, 100)
                        }.accessibilityIdentifier(ValueDefault.movieListView)
                            .simultaneousGesture(drag)
                    }
                }
                searchBar
                    .offset(y: searchbarY)
                    .animation(.linear(duration: 0.2), value: searchbarY)
                
            }.frame(maxHeight: UIScreen.screenHeight)
                
            .navigationBarHidden(true)
            .onTapGesture {
                hideKeyboard()
            }.background(ColorName.background.color)
        }.accessibilityIdentifier(ValueDefault.movieListView)
            
    }
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { state in
                let _ = print("---->", state.translation.height, state.translation.width)
                if state.translation.height > 0 && state.translation.width > -10 &&
                    state.translation.width < 10 {
                    searchbarY = 0
                } else if state.translation.height < 0 && state.translation.width < 10 && state.translation.width > -10 {
                    searchbarY = -150
                }
            }
    }
    
    private var searchingView: some View {
        ScrollView {
            HStack() {
                if let movieTheaterList = input.movieListFiltered,
                   !movieTheaterList.isEmpty {
                    topMovieFilterListView(movieTheaterList)
                } else {
                    Text("No Results!")
                        .font(MyFont.systemBold22.font)
                        .foregroundColor(ColorName.primaryText.color)
                        .padding(.top, 200)
                }
            }
        }.accessibilityIdentifier(ValueDefault.searchView)
    }
    
    private var searchBar: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center) {
                ImageName.imageLogo.imageTemplate
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
                    .foregroundColor(ColorName.logo.color)
                    .accessibilityIdentifier(searchbarY == 0 ? ValueDefault.logoImage : ValueDefault.logoImageHidden)
                Spacer()
                toggleView()
                    .accessibilityIdentifier(input.isLightMode ? ValueDefault.themeLightMode : ValueDefault.themeDarkMode)
            }
            searchBarView()
                .frame(height: 30)
                .accessibilityIdentifier(ValueDefault.searchBarView)
        }.padding(.horizontal)
            .frame(width: UIScreen.screenWidth, height: 100, alignment: .leading)
            .background(LinearGradient(gradient:
                                        Gradient(colors: [ColorName.gradient02A.color, ColorName.gradient02B.color]),
                                       startPoint: .trailing, endPoint: .leading))
    }
    
    private func searchBarView() -> some View {
        let searchView = MySearchBar(input: .init(textSearching: searchText,
                                                  placeholder: "Searching for..."))
        
        searchView.output.value.sink { action in
            switch action {
            case .buttonTapped:
                hideKeyboard()
            case .searching(let text):
                self.searchText = text
                output.value.send(.isSearching(text))
            }
        }.store(in: token)
        
        return searchView
    }
    
    private func carouselMovieTheaterView(_ movieTheaterList: [Movie]) -> some View {
        let carouselView = MyImageCarousel(input: .init(itemList: movieTheaterList,
                                                        size: CGSize(width: 250, height: 400)))
        
        carouselView.output.value.sink { action in
            switch action {
            case .itemTapped(let id):
                output.value.send(.showDetail(id))
            }
        }.store(in: token)
        
        return carouselView
    }
    
    private func carouselMovieView(_ movieList: [Movie]) -> some View {
        let carouselView = MyImageCarouselSmall(input: .init(itemList: movieList, size: CGSize(width: 200, height: 300), horizontalPadding: 16))
        
        carouselView.output.value.sink { action in
            switch action {
            case .itemTapped(let id):
                output.value.send(.showDetail(id))
            }
        }.store(in: token)
        
        return carouselView
    }
    
    private func imageLoadView(_ urlString: String?) -> some View {
        let imageView = MyImageLoadView(input: .init(urlString: urlString,
                                                     size: CGSize(width: 50, height: 70)))
        
        return imageView
    }
    
    private func moviesInTheater(_ movieTheaterList: [Movie]) -> some View {
        ZStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(ColorName.titleRectangle.color)
                        .frame(width: 8, height: 17)
                    Text("Playing this week")
                        .font(MyFont.systemBold22.font)
                        .foregroundColor(ColorName.primaryText.color)
                        .accessibilityIdentifier(ValueDefault.movieInTheaterTitle)
                }.padding([.top, .leading])
                carouselMovieTheaterView(movieTheaterList)
                    .accessibilityIdentifier(ValueDefault.movieListInTheaterList)
                Spacer()
            }.frame(height: 500)
                .background(ColorName.primary.color)
                .shadow(color: Color.clear, radius: 0)
        }.shadow(color: ColorName.shadow.color, radius: 8)
        
    }
    
    private func topMovieListView(_ movieList: [Movie]) -> some View {
        ZStack {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(ColorName.titleRectangle.color)
                        .frame(width: 8, height: 17)
                    Text("Top Movies")
                        .font(MyFont.systemBold22.font)
                        .foregroundColor(ColorName.primaryText.color)
                        .accessibilityIdentifier(ValueDefault.topMovieTitle)
                }.padding([.top, .leading])
                carouselMovieView(movieList)
                    .accessibilityIdentifier(ValueDefault.movieListMovieList)
                Spacer()
            }.frame(height: 400)
                .background(ColorName.primary.color)
                .shadow(color: Color.clear, radius: 0)
        }.shadow(color: ColorName.shadow.color, radius: 8)
    }
    
    private func topMovieFilterListView(_ movieList: [Movie]) -> some View {
        ZStack {
            VStack(spacing: 8) {
                ForEach(movieList, id: \.self) { movie in
                    Button {
                        output.value.send(.showDetail(movie.id))
                        hideKeyboard()
                    } label: {
                        HStack(spacing: 16) {
                            imageLoadView(movie.urlImage)
                            VStack(alignment: .leading) {
                                Text(movie.title)
                                    .font(MyFont.systemBold16.font)
                                    .foregroundColor(ColorName.primaryText.color)
                                Text(movie.year)
                                    .font(MyFont.systenMedium13.font)
                                    .foregroundColor(ColorName.primaryText.color)
                            }
                            Spacer()
                        }
                    }.padding(.horizontal, 32)
                        .padding(.vertical, 4)
                        .accessibilityIdentifier("filterl_item_\(movie.id)")
                    Divider()
                        .background(ColorName.dividerPrimary.color)
                }
            }.padding(.top, 120)
        }.background(ColorName.primary.color)
    }
    
    private func toggleView() -> some View {
        let toggle = MyTuggle(input: .init(isEnabled: input.isLightMode,
                                           size: CGSize(width: 55, height: 30)))
        
        toggle.output.value.sink { action in
            switch action {
            case .toggleTapped(let status):
                output.value.send(.darkModeChanged(status))
            }
        }.store(in: token)
        
        return toggle
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        let jsonData = LoadJsonData.loadJsonData(filename: ValueDefault.movieListJSON)
        let list = try? JSONDecoder().decode(MovieList.self, from: jsonData!)
        
        return MovieListView(input: MovieListViewModel(list?.asasMovieArray(), movieListValidator: MovieListViewModelValidator(), movieDataSource: MovieListDataSource()))
    }
}
