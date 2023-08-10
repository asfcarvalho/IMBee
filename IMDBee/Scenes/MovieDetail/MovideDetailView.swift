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

struct MovideDetailView: View {
    
    @ObservedObject var input: MovideDetailViewModel
    public var output = MyObservableObject<ViewModel.MovideDetail.ViewOutput.Action>()
    
    private var token = CancelBag()
    
    init(input: MovideDetailViewModel) {
        self.input = input
    }
    
    var body: some View {
        NavigationView {
            VStack {
                navigationBar
                if input.isLoading {
                    ProgressView()
                } else {
                    if let movie = input.movie {
                        VStack {
                            imageLoadView(movie.urlImage)
                            VStack(alignment: .leading, spacing: 16) {
                                Text(movie.title)
                                Text(movie.description)
                                Text(movie.year)
                            }.frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                        }
                        Spacer()
                    }
                }
            }.navigationBarHidden(true)
        }.alert(isPresented: $input.displayAlert) {
            Alert(title: Text("Movie not found!"),
                  dismissButton: Alert.Button.default(Text("OK"),
                                                      action: {
                output.value.send(.dismiss)
            }))
        }.accessibilityIdentifier(ValueDefault.movideDetailView)
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
