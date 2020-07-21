//
//  AlertHelper.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 21/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit

enum AlertHelper {
    static let alert =  AlertService()
    
    case commonAlert(model: CommonAlertModel, confirmHandler: (() -> ())? = nil, controller: UIViewController)
    
    enum SubType {
        case commonAlert
    }
    
    func show() {
        switch self {
        case let .commonAlert(model, confirmHandler, controller):
            AlertHelper.alert.create(type: .commonAlert, model: model, confirmHandler: confirmHandler, controller)
        }
    }
}

final class AlertService {
    
    @discardableResult
    func create(type: AlertHelper.SubType, model: CommonAlertModel, confirmHandler: (() -> ())?, _ controller: UIViewController) -> CommonViewController {
        switch type {
        case .commonAlert:
            return create(model: model, confirmHandler: confirmHandler, controller)
        }
    }
    
    private func create(model: CommonAlertModel ,confirmHandler: (() -> ())?, _ controller: UIViewController) -> CommonViewController {
        let viewModel = CommonAlertViewModel(model: model, confirmHandler: confirmHandler)
        let viewController = CommonAlertController(with: viewModel)
        viewController.modalPresentationStyle = .custom
        controller.present(viewController, animated: false)
        return viewController
    }
}
