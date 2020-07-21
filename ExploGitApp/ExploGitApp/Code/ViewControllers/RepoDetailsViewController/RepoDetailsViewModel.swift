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
}

final class RepoDetailsViewModel {
    weak var delegate: RepoDetailsViewModelDelegate!
    
    private let coordinator: MainCoordinatorProtocol
    private let worker: APIWorkerProtocol
    
    init(_ coordinator: MainCoordinatorProtocol, worker: APIWorkerProtocol = APIWorker()) {
        self.coordinator = coordinator
        self.worker = worker
    }
}

extension RepoDetailsViewModel: RepoDetailsViewModelProtocol {
    var title: String { Localized.repoDetailsView }
    
    func onViewDidLoad() {
        
    }
}
