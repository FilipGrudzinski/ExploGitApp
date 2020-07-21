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
    var dataSourceCount: Int { get }
    var searchButtonTitle: String { get }
    var searchPlaceholder: String { get }
    
    func searchButtonTap(_ value: String?)
    func item(at row: Int) -> SearchViewCellItemModel
    func didTapCell(at row: Int)
}

protocol SearchViewModelDelegate: class {
    func showIndicator(_ state: Bool)
}

final class SearchViewModel {
    weak var delegate: SearchViewModelDelegate!
    
    private let coordinator: MainCoordinatorProtocol
    private let worker: APIWorkerProtocol
    
    private var itemsDataSource: [SearchViewCellItemModel] = []
    
    init(_ coordinator: MainCoordinatorProtocol, worker: APIWorkerProtocol = APIWorker()) {
        self.coordinator = coordinator
        self.worker = worker
    }
    
    private func sendSearchRequest(_ query: String) {
        worker.fetchReposSearch(query)
            .done { response in
                self.delegate.showIndicator(false)
                print(response)
        } .catch { error in
            print(error)
        }
    }
}

extension SearchViewModel: SearchViewModelProtocol {
    var title: String { Localized.searchViewTitle }
    var searchButtonTitle: String { Localized.searchButtonTitle }
    var searchPlaceholder: String { Localized.searchViewPlaceholder }
    var dataSourceCount: Int { itemsDataSource.count }
    
    func searchButtonTap(_ value: String?) {
        guard let value = value else {
            return
        }
        
        delegate.showIndicator(true)
        sendSearchRequest(value)
    }
    
    func item(at row: Int) -> SearchViewCellItemModel {
        return itemsDataSource[row]
    }
    
    func didTapCell(at row: Int) {
        print(itemsDataSource[row])
        #warning("ToDO")
    }
}
