//
//  MovideDetailRouterRouter.swift
//  IMDBee
//
//  Created by Anderson F Carvalho on 19/07/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import SwiftUI
import BaseUI
import DataModules

class MovideDetailRouter{
    
    private(set) weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
        
    class func build(_ movie: Movie?) -> UIHostingController<MovideDetailView> {
        let viewModel = MovideDetailViewModel(movie)
        let rootView = MovideDetailView(input: viewModel)
        let viewController = MovideDetailViewController(rootView: rootView)
        viewModel.router = MovideDetailRouter(viewController: viewController)
        
        return viewController
    }
    
    func perform(action: Router.MovideDetailRouter.ViewOutput.Acion) {
        switch action {
        case .sample:
            break
        case .dismiss:
            viewController?.dismiss(animated: true)
        }
    }
}

public extension Router {
    enum MovideDetailRouter {
        public enum ViewOutput {
            public enum Acion: Hashable {
                case sample
                case dismiss
            }
        }
    }
}
