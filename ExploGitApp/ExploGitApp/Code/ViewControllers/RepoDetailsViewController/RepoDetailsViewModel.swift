//
//  RepoDetailsViewModel.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 21/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

protocol RepoDetailsViewModelProtocol: class {
    var delegate: RepoDetailsViewModelDelegate! { get set }
    var title: String { get }
    
    func onViewDidLoad()
}

protocol RepoDetailsViewModelDelegate: class {
    func loadWeb(_ url: URLRequest)
}

final class RepoDetailsViewModel {
    weak var delegate: RepoDetailsViewModelDelegate!
    
    private let coordinator: MainCoordinatorProtocol
    private let url: URL
    private let repoTitle: String
    
    init(_ coordinator: MainCoordinatorProtocol, url: URL, title: String) {
        self.coordinator = coordinator
        self.repoTitle = title
        self.url = url
    }
}

extension RepoDetailsViewModel: RepoDetailsViewModelProtocol {
    var title: String { repoTitle.capitalized }
    
    func onViewDidLoad() {
        let request = URLRequest(url: url)
        delegate.loadWeb(request)
    }
}
