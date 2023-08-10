//
//  MovieDetailViewModelProtocol.swift
//  IMDBee
//
//  Created by Anderson F Carvalho on 19/07/23.
//

import Foundation
import DataModules
import BaseUI

protocol MovieDetailViewModelProtocol: ObservableObject {
    var movie: Movie? { get set }
    var displayAlert: Bool { get set }
    func send(action: ViewModel.MovideDetail.ViewInput.Action)
}
