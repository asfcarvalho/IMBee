//
//  MovieListViewControllerViewController.swift
//  IMDBee
//
//  Created by Anderson F Carvalho on 13/07/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SwiftUI
import Combine
import DataModules

class MovieListViewController<T: MovieListViewModelProtocol>: UIHostingController<MovieListView<T>> {
    
    private var token = CancelBag()
    private var viewModel: (any MovieListViewModelProtocol)?
    
    override init(rootView: MovieListView<T>) {
        super.init(rootView: rootView)
        
        viewModel = rootView.input
        configureComunication()
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.send(action: .viewDidLoad)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func configureComunication() {
        rootView.output.value.sink { [weak self] action in
            guard let self = self else { return }
            switch action {
            case .dismiss:
                self.viewModel?.send(action: .dismiss)
            case .showDetail(let movie):
                self.viewModel?.send(action: .showDetail(movie))
            case .darkModeChanged(let status):
                self.viewModel?.send(action: .darkModeChanged(status))
            case .isSearching(let text):
                self.viewModel?.send(action: .isSearching(text))
            }
        }.store(in: token)
    }
}

extension MovieListViewController: MovieDetailProtocol {
    func darkModeAction(_ status: Bool) {
        viewModel?.send(action: .darkModeDetailChanged(status))
    }
}
