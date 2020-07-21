//
//  MainViewModel.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 20/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit

enum MainViewLayoutStyle {
    case gird
    case list
}

protocol MainViewModelProtocol: class {
    var delegate: MainViewModelDelegate! { get set }
    var title: String { get }
    var dataSourceCount: Int { get }
    var layoutStyle: MainViewLayoutStyle { get }
    
    func onViewDidLoad()
    
    func openSearchView()
    func switchStyle()
    func selectedItem(_ row: Int)
    func item(at row: Int) -> MainViewRenderable
    func filtersButtonDidTap()
}

protocol MainViewModelDelegate: class {
    func reloadData()
}

final class MainViewModel {
    weak var delegate: MainViewModelDelegate!
    
    private var listStyle = true {
        didSet {
            delegate.reloadData()
        }
    }
    
    private let coordinator: MainCoordinatorProtocol
    private let worker: APIWorkerProtocol
    
    init(_ coordinator: MainCoordinatorProtocol, worker: APIWorkerProtocol = APIWorker()) {
        self.coordinator = coordinator
        self.worker = worker
    }
    
    private func search(_ query: String) {
        worker.fetchFeeds()
            .done { response in
                print(response)
        } . catch { error in
            print(error)
        }
    }
}

extension MainViewModel: MainViewModelProtocol {
    var title: String { Localized.mainViewTitle }
    var dataSourceCount: Int { 10 }
    var layoutStyle: MainViewLayoutStyle { listStyle ? .list : .gird }
    
    func onViewDidLoad() {
        #warning("TO DO")
        search("fgrepo")
    }
    
    func switchStyle() {
        listStyle.toggle()
    }
    
    func selectedItem(_ row: Int) {
        print("Row\(row)")
    }
    
    func item(at row: Int) -> MainViewRenderable {
        return MainViewRenderable(icon: UIImage(), title: "Row\(row)")
    }
    
    func openSearchView() {
        coordinator.openSearchView()
    }
    
    func filtersButtonDidTap() {
        coordinator.openSearchFilter()
    }
}
