//
//  MovideDetailViewModelViewModel.swift
//  IMDBee
//
//  Created by Anderson F Carvalho on 19/07/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import BaseUI
import DataModules
import Common

class MovideDetailViewModel: MovieDetailViewModelProtocol {
    @Published var movie: Movie?
    @Published var displayAlert: Bool = false
    @Published var isLoading: Bool = true
    @Published var isLightMode: Bool = true
    @Published var isPlaying: Bool = false
    
    var router: MovideDetailRouter?
    var validator: MovieDetailViewModelValidatorProtocol!
    
    init(_ movie: Movie? = nil,
         validator: MovieDetailViewModelValidatorProtocol = MovieDetailViewModelValidator(),
         isLightMode: Bool = true) {
        self.movie = movie
        self.validator = validator
        self.isLightMode = isLightMode
    }
    
    public func send(action: ViewModel.MovideDetail.ViewInput.Action) {
        switch action {
        case .dismiss:
            router?.perform(action: .dismiss)
        case .viewDidLoad:
            displayAlert = !validator.shuldDisplayView(movie)
            isLoading = false
        case .darkModeChanged(let status):
            if status {
                LocalDataAdapter.shared.setValue(value: ValueDefault.light, key: .themeColorKey)
            } else {
                LocalDataAdapter.shared.setValue(value: ValueDefault.dark, key: .themeColorKey)
            }
            
            router?.perform(action: .darkModeAction(status: status))
            
            self.isLightMode = status
        }
    }
}

public extension ViewModel {
    enum MovideDetail {
        public enum ViewOutput {
            public enum Action: Hashable {
                case sample
                case dismiss
                case darkModeChanged(_ status: Bool)
            }
        }
        
        public enum ViewInput: Hashable {
            public enum Action: Hashable {
                case dismiss
                case viewDidLoad
                case darkModeChanged(_ status: Bool)
            }
        }
    }
}
