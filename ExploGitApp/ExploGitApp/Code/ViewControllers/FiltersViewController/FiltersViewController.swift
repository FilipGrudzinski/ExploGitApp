//
//  FiltersViewController.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 21/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit

final class FiltersViewController: CommonViewController {
    private var viewModel: FiltersViewModelProtocol
    
    init(with viewModel: FiltersViewModelProtocol) {
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
        viewModel.onViewDidLoad()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = viewModel.title
    }
}

extension FiltersViewController: FiltersViewModelDelegate {
}
