//
//  FiltersViewModel.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 21/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

protocol FiltersViewModelProtocol: class {
    var delegate: FiltersViewModelDelegate! { get set }
    var title: String { get }
    
    func onViewDidLoad()
}

protocol FiltersViewModelDelegate: class {
}

final class FiltersViewModel {
    weak var delegate: FiltersViewModelDelegate!
    
    private let coordinator: MainCoordinatorProtocol
    
    init(_ coordinator: MainCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

extension FiltersViewModel: FiltersViewModelProtocol {
    var title: String { Localized.filterViewTitle }
    
    func onViewDidLoad() {
    }
}
