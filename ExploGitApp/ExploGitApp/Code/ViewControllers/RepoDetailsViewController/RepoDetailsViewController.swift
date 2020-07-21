//
//  RepoDetailsViewController.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 21/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit
import WebKit

final class RepoDetailsViewController: CommonViewController {
     @IBOutlet private weak var webView: WKWebView!
    
    private var viewModel: RepoDetailsViewModelProtocol
    
    init(with viewModel: RepoDetailsViewModelProtocol) {
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
        webView.backgroundColor = .white
        title = viewModel.title
    }
}

extension RepoDetailsViewController: RepoDetailsViewModelDelegate {
    func loadWeb(_ url: URLRequest) {
        webView.load(url)
    }
}
