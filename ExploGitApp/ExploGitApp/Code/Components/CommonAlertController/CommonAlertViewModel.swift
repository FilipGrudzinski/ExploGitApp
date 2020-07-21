//
//  CommonAlertViewModel.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 21/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

struct CommonAlertModel {
    let title: String
    let description: String
    let buttonTitle: String
}

protocol CommonAlertViewModelProtocol: class {
    var delegate: CommonAlertViewModelDelegate! { get set }
    var alertTitle: String { get }
    var alertDescription: String { get }
    var alertButtonTitle: String { get }
    
    func confirmDidTap()
}

protocol CommonAlertViewModelDelegate: class { }

final class CommonAlertViewModel {
    weak var delegate: CommonAlertViewModelDelegate!
    
    private let confirmHandler: (() -> ())?
    private let model: CommonAlertModel
    
    init(model: CommonAlertModel, confirmHandler: (() -> ())?) {
        self.confirmHandler = confirmHandler
        self.model = model
    }
}

extension CommonAlertViewModel: CommonAlertViewModelProtocol {
    var alertTitle: String { model.title }
    var alertDescription: String { model.description }
    var alertButtonTitle: String { model.buttonTitle }
    
    func confirmDidTap() {
        confirmHandler?()
    }
}
