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

class MovideDetailRouter: MovieDetailRouterProtocol {
    
    private(set) weak var viewController: UIViewController?
    internal weak var delegate: MovieDetailProtocol?
    
    init(viewController: UIViewController,
         delegate: MovieDetailProtocol? = nil) {
        self.viewController = viewController
        self.delegate = delegate
    }
        
    class func build(_ movie: Movie?, _ isLightMode: Bool, delegate: MovieDetailProtocol? = nil) -> UIHostingController<MovideDetailView> {
        let viewModel = MovideDetailViewModel(movie, isLightMode: isLightMode)
        let rootView = MovideDetailView(input: viewModel)
        let viewController = MovideDetailViewController(rootView: rootView)
        viewModel.router = MovideDetailRouter(viewController: viewController, delegate: delegate)
        
        return viewController
    }
    
    func perform(action: Router.MovideDetailRouter.ViewOutput.Acion) {
        switch action {
        case .sample:
            break
        case .dismiss:
            viewController?.dismiss(animated: true)
        case .darkModeAction(let status):
            delegate?.darkModeAction(status)
        }
    }
}

public extension Router {
    enum MovideDetailRouter {
        public enum ViewOutput {
            public enum Acion: Hashable {
                case sample
                case dismiss
                case darkModeAction(status: Bool)
            }
        }
    }
}
