//
//  LoginViewController.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 21/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit

final class LoginViewController: CommonViewController {
    @IBOutlet private weak var loginImage: UIImageView!
    @IBOutlet private weak var loginButton: UIButton!
    
    private var viewModel: LoginViewModelProtocol
    
    init(with viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.onViewDidAppear()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = viewModel.title
        loginButton.setTitle(viewModel.buttonTitle, for: .normal)
        loginButton.tintColor = .appBlue
        loginImage.image = Asset.githubLogo.image
    }
    
    @IBAction private func loginButtonTap(_ sender: Any) {
        UIApplication.shared.open(viewModel.authLoginUrl)
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func presentAlert(_ model: CommonAlertModel) {
        AlertHelper.commonAlert(model: model, confirmHandler: nil, controller: self).show()
    }
}
