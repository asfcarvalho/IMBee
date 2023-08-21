//
//  MovideDetailViewControllerViewController.swift
//  IMDBee
//
//  Created by Anderson F Carvalho on 19/07/23.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SwiftUI
import Combine
import DataModules

class MovideDetailViewController: UIHostingController<MovideDetailView> {
    
    private var token = CancelBag()
    private var viewModel: MovideDetailViewModel?
    
    override init(rootView: MovideDetailView) {
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
            case .sample:
                break
            case .darkModeChanged(let status):
                self.viewModel?.send(action: .darkModeChanged(status))
            }
        }.store(in: token)
    }
}
