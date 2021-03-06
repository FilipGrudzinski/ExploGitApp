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
    var emptyTitle: String { get }
    var dataSourceCount: Int { get }
    var searchButtonTitle: String { get }
    var searchPlaceholder: String { get }
    
    func onViewDidLoad()
    func searchButtonTap(_ value: String?)
    func item(at row: Int) -> SearchViewCellItemModel
    func didTapCell(at row: Int)
}

protocol SearchViewModelDelegate: class {
    func showIndicator(_ state: Bool)
    func hideEmptyView(_ state: Bool)
    func reloadData()
    func presentAlert(_ model: CommonAlertModel)
}

final class SearchViewModel {
    weak var delegate: SearchViewModelDelegate!
    
    private let coordinator: MainCoordinatorProtocol
    private let worker: APIWorkerProtocol
    
    private var itemsDataSource: [SearchViewCellItemModel] = []
    private var dataSource: [RepositoryResponseModel] = []
    
    init(_ coordinator: MainCoordinatorProtocol, worker: APIWorkerProtocol = APIWorker()) {
        self.coordinator = coordinator
        self.worker = worker
    }
    
    private func sendSearchRequest(_ query: String) {
        worker.fetchReposSearch(query)
            .done { response in
                self.delegate.showIndicator(false)
                self.dataSource = response.items
                self.parseResponse()
        } .catch { error in
            self.errorHandler(error)
        }
    }
    
    private func parseResponse() {
        itemsDataSource.removeAll()
        
        dataSource.forEach { item in
            itemsDataSource.append(SearchViewCellItemModel(id: item.id, title: item.fullName ?? .empty, language: item.language, imageURL: item.owner?.avatarUrl))
        }
        
        delegate.hideEmptyView(itemsDataSource.isNotEmpty)
        delegate.reloadData()
    }
    
    private func clearViewWhenEmptySearch() {
        dataSource.removeAll()
        delegate.showIndicator(false)
        parseResponse()
    }
    
    private func errorHandler(_ error: Error) {
        delegate.showIndicator(false)
        guard let _ = error as? ApiResponseError else {
            return
        }
        
        delegate.hideEmptyView(true)
        
        let model = CommonAlertModel(title: Localized.commonAlertTitle, description: Localized.commonAlertDescription, buttonTitle: Localized.commonAlertButtonTitle)
        delegate.presentAlert(model)
    }
}

extension SearchViewModel: SearchViewModelProtocol {    
    var title: String { Localized.searchViewTitle }
    var emptyTitle: String { Localized.searchEmptyTitle }
    var searchButtonTitle: String { Localized.searchButtonTitle }
    var searchPlaceholder: String { Localized.searchViewPlaceholder }
    var dataSourceCount: Int { itemsDataSource.count }
    
    func onViewDidLoad() {
        delegate.hideEmptyView(itemsDataSource.isNotEmpty)
    }
    
    func searchButtonTap(_ value: String?) {
        guard let value = value, value.trimmingCharacters(in: .whitespaces).isNotEmpty else {
            clearViewWhenEmptySearch()
            return
        }
        
        delegate.showIndicator(true)
        sendSearchRequest(value)
    }
    
    func item(at row: Int) -> SearchViewCellItemModel {
        return itemsDataSource[row]
    }
    
    func didTapCell(at row: Int) {
        guard let index = dataSource.firstIndex(where: { $0.id == itemsDataSource[row].id }), let url = URL(string: dataSource[index].htmlUrl ?? .empty), let title = dataSource[index].fullName else {
            return
        }
        coordinator.openDetailsView(url, title: title)
    }
}
