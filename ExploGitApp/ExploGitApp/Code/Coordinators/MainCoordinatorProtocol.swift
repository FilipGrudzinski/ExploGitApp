//
//  MainCoordinatorProtocol.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 20/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit

protocol MainCoordinatorProtocol: CoordinatorProtocol {
    func openSearchView()
    func openDetailsView()
}

final class MainCoordinator: MainCoordinatorProtocol {
    
    private let parentCoordinator: ApplicationParentCoordinatorProtocol
    private let navigationController = MainNavigationController()
    
    init(parentCoordinator: ApplicationParentCoordinatorProtocol) {
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let viewModel = MainViewModel(self)
        let viewController = MainViewController(with: viewModel)
        navigationController.pushViewController(viewController, animated: true)
        
        parentCoordinator.showRootViewController(rootViewController: navigationController)
    }
    
    func openSearchView() {
        let viewModel = SearchViewModel(self)
        let viewController = SearchViewController(with: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func openDetailsView() {
        let viewModel = RepoDetailsViewModel(self)
        let viewController = RepoDetailsViewController(with: viewModel)
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
