//
//  SearchViewModel.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 21/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

protocol SearchViewModelProtocol: class {
    var delegate: SearchViewModelDelegate! { get set }
    var title: String { get }
}

protocol SearchViewModelDelegate: class {
}

final class SearchViewModel {
    weak var delegate: SearchViewModelDelegate!
    
    private let coordinator: MainCoordinatorProtocol
    private let worker: APIWorkerProtocol
    
    init(_ coordinator: MainCoordinatorProtocol, worker: APIWorkerProtocol = APIWorker()) {
        self.coordinator = coordinator
        self.worker = worker
    }
}

extension SearchViewModel: SearchViewModelProtocol {
    var title: String { Localized.searchViewTitle }
    
    
}
