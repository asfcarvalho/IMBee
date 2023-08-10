//
//  MovieListRouterRouter.swift
//  IMDBee
//
//  Created by Anderson F Carvalho on 13/07/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import SwiftUI
import BaseUI
import DataModules

class MovieListRouter{
    
    private(set) weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
        
    class func build() -> UIViewController {
        var movieDataSource = MovieListDataSource()
        let viewModel = MovieListViewModel(movieListValidator: MovieListViewModelValidator(),
                                           movieDataSource: movieDataSource)
        let rootView = MovieListView(input: viewModel)
        let viewController = MovieListViewController(rootView: rootView)
        viewModel.router = MovieListRouter(viewController: viewController)
        
        return viewController
    }
    
    func perform(action: Router.MovieListRouter.ViewOutput.Acion) {
        switch action {
        case .showDetail(let movie):
            let vc = MovideDetailRouter.build(movie)
            viewController?.present(vc, animated: true)
        case .dismiss:
            viewController?.dismiss(animated: true)
        }
    }
}

public extension Router {
    enum MovieListRouter {
        public enum ViewOutput {
            public enum Acion: Hashable {
                case showDetail(_ movie: Movie?)
                case dismiss
            }
        }
    }
}
