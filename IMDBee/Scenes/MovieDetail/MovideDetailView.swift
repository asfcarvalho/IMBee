//
//  MovideDetailViewView.swift
//  IMDBee
//
//  Created by Anderson F Carvalho on 19/07/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import Common
import BaseUI
import Components
import DataModules
import AVKit

struct MovideDetailView: View {
    
    @ObservedObject var input: MovideDetailViewModel
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    public var output = MyObservableObject<ViewModel.MovideDetail.ViewOutput.Action>()
    
    @State var player = AVPlayer(url:  Bundle.main.url(forResource: "video", withExtension: "mp4")!)
    
    private var token = CancelBag()
    
    init(input: MovideDetailViewModel) {
        self.input = input
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            ZStack {
                VStack {
                    if let movie = input.movie {
                        VStack {
                            headerView
                            
                            titleView(movie)
                            
                            bodyView(movie)
                        }.padding()
                    }
                }.background(ColorName.backgroundSecondy.color)
                    .cornerRadius(15)
                    .padding()                    
                    .frame(maxWidth:  UIScreen.screenWidth, maxHeight: 600)
                    
                    
            }.frame(width:  UIScreen.screenWidth, height: UIScreen.screenHeight)
        }.alert(isPresented: $input.displayAlert) {
            Alert(title: Text("Movie not found!"),
                  dismissButton: Alert.Button.default(Text("OK"),
                                                      action: {
                output.value.send(.dismiss)
            }))
        }.accessibilityIdentifier(ValueDefault.movideDetailView)
            .background(ColorName.backgroundTransparent.color.opacity(0.5))
    }
    
    private var headerView: some View {
        HStack {
            Button {
                player.pause()
                output.value.send(.dismiss)
            } label: {
                ImageName.iconBack.imageTemplate
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 34, height: 24)
                    .foregroundColor(ColorName.secondaryText.color)
            }
            
            Spacer()
            toggleView()
                .accessibilityIdentifier(input.isLightMode ? ValueDefault.themeLightMode : ValueDefault.themeDarkMode)
        }.padding(4)
    }
    
    private func titleView(_ movie: Movie) -> some View {
        HStack {
            Text(movie.title)
                .font(MyFont.systemMedium32.font)
                .foregroundColor(ColorName.secondaryText.color)
                .lineLimit(1)
                .frame(alignment: .leading)
            Spacer()
            Text(movie.rating)
                .font(MyFont.systemMedium22.font)
                .foregroundColor(ColorName.secondaryText.color)
            ImageName.iconRating.image
                .resizable()
                .frame(width: 25, height: 25)
        }.padding(4)
    }
    
    private var playerView: some View {
        ZStack {
            VideoPlayer(player: player)
                .frame(height: 198)
                .overlay(alignment: .bottomLeading) {
                    if !input.isPlaying {
                        Button {
                            player.play()
                            input.isPlaying = true
                        } label: {
                            HStack {
                                ImageName.iconPlayer.imageTemplate
                                    .resizable()
                                    .frame(width: 66, height: 66)
                                    .foregroundColor(Color.white)
                                Text("Play trailer")
                                    .font(MyFont.systenMedium14.font)
                                    .foregroundColor(Color.white)
                            }.padding()
                        }
                    }
                }
        }
    }
    
    private func bodyView(_ movie: Movie) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(movie.year)
                .font(MyFont.systenMedium14.font)
                .foregroundColor(ColorName.secondaryText.color)
            
            playerView
            
            Text(movie.description)
                .font(MyFont.systenMedium14.font)
                .foregroundColor(ColorName.secondaryText.color)
        }.frame(maxWidth: .infinity, alignment: .leading)
            .padding(4)
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
    
    private var navigationBar: some View {
        let navigation = MyNavigationBarView(input: .init())
        
        navigation.output.value.sink { action in
            switch action {
            case .buttonTapped:
                output.value.send(.dismiss)
            }
        }.store(in: token)
        
        return navigation
    }
    
    private func imageLoadView(_ urlString: String?) -> some View {
        let imageView = MyImageLoadView(input: .init(urlString: urlString,
                                                     size: CGSize(width: 300, height: 500)))
        
        return imageView
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct MovideDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovideDetailView(input: .init(Movie(id: "1", title: "Back to The Future", description: "Marty travels back in time using an eccentric scientist's time machine. However, he must make his high-school-aged parents fall in love in order to return to the present.", year: "1985", rating: "9 / 10", urlImage: "https://m.media-amazon.com/images/M/MV5BZmU0M2Y1OGUtZjIxNi00ZjBkLTg1MjgtOWIyNThiZWIwYjRiXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_.jpg")))
    }
}
