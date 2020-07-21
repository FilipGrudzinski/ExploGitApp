//
//  LoginViewModel.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 21/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

protocol LoginViewModelProtocol: class {
    var delegate: LoginViewModelDelegate! { get set }
    var title: String { get }
    var buttonTitle: String { get }
    var authLoginUrl: URL { get }
    
    func onViewDidAppear()
}

protocol LoginViewModelDelegate: class {
    func presentAlert(_ model: CommonAlertModel)
}

final class LoginViewModel {
    weak var delegate: LoginViewModelDelegate!
    
    private let coordinator: MainCoordinatorProtocol
    private let worker: APIWorkerProtocol
    
    init(_ coordinator: MainCoordinatorProtocol, worker: APIWorkerProtocol = APIWorker()) {
        self.coordinator = coordinator
        self.worker = worker
    }
    
    private func errorHandler(_ error: Error) {
        guard let _ = error as? ApiResponseError else {
            fatalError()
        }
        
        let model = CommonAlertModel(title: Localized.commonAlertTitle, description: Localized.commonAlertDescription, buttonTitle: Localized.commonAlertButtonTitle)
        delegate.presentAlert(model)
    }
}

extension LoginViewModel: LoginViewModelProtocol {
    var title: String { Localized.loginViewTitle }
    var buttonTitle: String { Localized.loginViewButtonTitle }
    var authLoginUrl: URL {
        var authPath: URL!
        if let authURL: URL = URL(string: AuthorizationStrings.authorizeURL) {
            authPath = authURL
        }
        return authPath
    }
    
    func onViewDidAppear() {
        guard let code: String = KeychainManager.get(from: .loginToken), code != .empty else {
            return
        }
        worker.getAccessToken(code)
    }
}
