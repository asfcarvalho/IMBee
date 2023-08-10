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

class MovideDetailViewModel: MovieDetailViewModelProtocol {
    @Published var movie: Movie?
    @Published var displayAlert: Bool = false
    @Published var isLoading: Bool = true
    
    var router: MovideDetailRouter?
    var validator: MovieDetailViewModelValidatorProtocol!
    
    init(_ movie: Movie? = nil,
         _ validator: MovieDetailViewModelValidatorProtocol = MovieDetailViewModelValidator()) {
        self.movie = movie
        self.validator = validator
    }
    
    public func send(action: ViewModel.MovideDetail.ViewInput.Action) {
        switch action {
        case .dismiss:
            router?.perform(action: .dismiss)
        case .viewDidLoad:
            displayAlert = !validator.shuldDisplayView(movie)
            isLoading = false
        }
    }
}

public extension ViewModel {
    enum MovideDetail {
        public enum ViewOutput {
            public enum Action: Hashable {
                case sample
                case dismiss
            }
        }
        
        public enum ViewInput: Hashable {
            public enum Action: Hashable {
                case dismiss
                case viewDidLoad
            }
        }
    }
}
