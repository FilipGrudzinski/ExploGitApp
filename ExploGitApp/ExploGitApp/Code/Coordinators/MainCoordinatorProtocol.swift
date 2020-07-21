//
//  MainCoordinatorProtocol.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 20/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit

protocol MainCoordinatorProtocol: CoordinatorProtocol {
    func openLoginView()
    func openMainView()
    func openSearchView()
    func openDetailsView(_ url: URL, title: String)
    func openSearchFilter<T: FiltersViewModelFilterDelegate>(_ dataSource: [String], delegate: T)
    func dismiss()
    func logout()
}

final class MainCoordinator: MainCoordinatorProtocol {
    private let parentCoordinator: ApplicationParentCoordinatorProtocol
    private let navigationController = MainNavigationController()
    
    init(parentCoordinator: ApplicationParentCoordinatorProtocol) {
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        SessionHelper.userIsLoggedIn ? openMainView() : openLoginView()
    }
    
    func openMainView() {
        let viewModel = MainViewModel(self)
        let viewController = MainViewController(with: viewModel)
        navigationController.pushViewController(viewController, animated: true)
        
        parentCoordinator.showRootViewController(rootViewController: navigationController)
    }
    
    func openLoginView() {
        let viewModel = LoginViewModel(self)
        let viewController = LoginViewController(with: viewModel)
        
        parentCoordinator.showRootViewController(rootViewController: viewController)
    }
    
    func openSearchView() {
        let viewModel = SearchViewModel(self)
        let viewController = SearchViewController(with: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func openDetailsView(_ url: URL, title: String) {
        let viewModel = RepoDetailsViewModel(self, url: url, title: title)
        let viewController = RepoDetailsViewController(with: viewModel)
        
        let modalNavigationController = CommonModalNavigationController(rootViewController: viewController)
        
        modalNavigationController.modalPresentationStyle = .overFullScreen
        navigationController.present(modalNavigationController, animated: true)
    }
    
    func openSearchFilter<T: FiltersViewModelFilterDelegate>(_ dataSource: [String], delegate: T) {
        let viewModel = FiltersViewModel(self, dataSource: dataSource)
        let viewController = FiltersViewController(with: viewModel)
        
        viewModel.selectedItem { [weak self] filter in
            self?.navigationController.popViewController(animated: true)
            delegate.returnFilter(filter)
        }
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
    
    func logout() {
        SessionHelper.logout()
        start()
    }
}
