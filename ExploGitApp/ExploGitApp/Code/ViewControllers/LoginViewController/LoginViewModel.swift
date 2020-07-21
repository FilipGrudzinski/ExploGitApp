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
    
    func onViewDidLoad()
}

protocol LoginViewModelDelegate: class {
}

final class LoginViewModel {
    weak var delegate: LoginViewModelDelegate!
    
    private let coordinator: MainCoordinatorProtocol
    
    init(_ coordinator: MainCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

extension LoginViewModel: LoginViewModelProtocol {
    var title: String { Localized.loginViewTitle }
    var buttonTitle: String { Localized.loginViewButtonTitle }
    
    func onViewDidLoad() {
    }
}
