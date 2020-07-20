//
//  MainViewModel.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 20/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

protocol MainViewModelProtocol: class {
    var delegate: MainViewModelDelegate! { get set }
    var title: String { get }
    
    func onViewDidLoad()
}

protocol MainViewModelDelegate: class {
}

final class MainViewModel {
    weak var delegate: MainViewModelDelegate!
    
    private let coordinator: MainCoordinatorProtocol
    private let worker: APIWorkerProtocol = APIWorker()
    
    init(_ coordinator: MainCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    private func search(_ query: String) {
        worker.fetchReposSearch(query)
            .done { response in
                print(response)
        } .catch { error in
            print(error)
        }
    }
}

extension MainViewModel: MainViewModelProtocol {
    var title: String { .empty }
    
    func onViewDidLoad() {
        #warning("TO DO")
        search("fgrepo")
    }
}
