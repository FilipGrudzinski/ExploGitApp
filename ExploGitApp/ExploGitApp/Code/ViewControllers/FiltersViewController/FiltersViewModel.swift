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
    var dataSourceCount: Int { get }
    
    func item(at row: Int) -> String
    func didTapCell(at row: Int)
    func selectedItem(_ closure: @escaping (String) -> ())
}

protocol FiltersViewModelDelegate: class {
}

final class FiltersViewModel {
    weak var delegate: FiltersViewModelDelegate!
    
    private let coordinator: MainCoordinatorProtocol
    
    private var selectedItemClosure: ((String)-> ())?
    
    private var dataSource: [String] = []
    
    init(_ coordinator: MainCoordinatorProtocol, dataSource: [String]) {
        self.coordinator = coordinator
        self.dataSource = dataSource
    }
}

extension FiltersViewModel: FiltersViewModelProtocol {
    var title: String { Localized.filterViewTitle }
    var dataSourceCount: Int { dataSource.count }
    
    func item(at row: Int) -> String {
        dataSource[row]
    }
    
    func didTapCell(at row: Int) {
        selectedItemClosure?(dataSource[row])
    }
    
    func selectedItem(_ closure: @escaping (String) -> ()) {
        selectedItemClosure = closure
    }
}
