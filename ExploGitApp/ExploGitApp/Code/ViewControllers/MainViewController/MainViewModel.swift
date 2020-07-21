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
    var logoutButotnTitle: String { get }
    var emptyTitle: String { get }
    var listStyleButtonTitle: String { get }
    var filterButtonTitle: String { get }
    var dataSourceCount: Int { get }
    var layoutStyle: MainViewLayoutStyle { get }
    
    func onViewDidLoad()
    func openSearchView()
    func switchStyle()
    func selectedItem(_ row: Int)
    func item(at row: Int) -> MainViewRenderable
    func filtersButtonDidTap()
    func logout()
}

protocol MainViewModelDelegate: class {
    func showIndicator(_ state: Bool)
    func hideEmptyView(_ state: Bool)
    func updateNavigationButtons()
    func reloadData()
    func presentAlert(_ model: CommonAlertModel)
}

final class MainViewModel {
    weak var delegate: MainViewModelDelegate!
    
    private var listStyle = true {
        didSet {
            delegate.reloadData()
            delegate.updateNavigationButtons()
        }
    }
    
    private var filters = false {
        didSet {
            delegate.updateNavigationButtons()
        }
    }
    
    private let coordinator: MainCoordinatorProtocol
    private let worker: APIWorkerProtocol
    private var itemsDataSource: [MainViewRenderable] = []
    private var dataSource: [RepositoryResponseModel] = []
    
    init(_ coordinator: MainCoordinatorProtocol, worker: APIWorkerProtocol = APIWorker()) {
        self.coordinator = coordinator
        self.worker = worker
    }
    
    private func loadUserRepositories() {
        worker.fetchRepositories()
            .done { response in
                self.dataSource = response
                self.delegate.showIndicator(false)
                self.parseResponse()
        } .catch { error in
            self.errorHandler(error)
        }
    }
    
    private func parseResponse() {
        itemsDataSource.removeAll()
        
        dataSource.forEach { item in
            itemsDataSource.append(MainViewRenderable(id: item.id, title: item.name, language: item.language, imageURL: item.owner?.avatarUrl))
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

extension MainViewModel: MainViewModelProtocol {
    var title: String { Localized.mainViewTitle }
    var logoutButotnTitle: String { Localized.mainViewLogoutButtonTitle }
    var emptyTitle: String { Localized.mainViewEmptyTitle }
    var listStyleButtonTitle: String { listStyle ? Localized.mainViewGridButtonTitle : Localized.mainViewListButtonTitle }
    var filterButtonTitle: String { filters ? Localized.mainViewFilterClearButtonTitle : Localized.mainViewFilterButtonTitle }
    var dataSourceCount: Int { itemsDataSource.count }
    var layoutStyle: MainViewLayoutStyle { listStyle ? .list : .gird }
    
    func onViewDidLoad() {
        delegate.hideEmptyView(itemsDataSource.isNotEmpty)
        loadUserRepositories()
    }
    
    func switchStyle() {
        listStyle.toggle()
    }
    
    func selectedItem(_ row: Int) {
        guard let index = dataSource.firstIndex(where: { $0.id == itemsDataSource[row].id }), let url = URL(string: dataSource[index].htmlUrl ?? .empty), let title = dataSource[index].fullName else {
            return
        }
        coordinator.openDetailsView(url, title: title)
    }
    
    func item(at row: Int) -> MainViewRenderable {
        return itemsDataSource[row]
    }
    
    func openSearchView() {
        coordinator.openSearchView()
    }
    
    func filtersButtonDidTap() {
        if filters {
            filters.toggle()
            parseResponse()
        } else {
            let items = dataSource.map { $0.language }.removingDuplicates()
            
            coordinator.openSearchFilter(items, delegate: self)
        }
    }
    
    func logout() {
        coordinator.logout()
    }
}

extension MainViewModel: FiltersViewModelFilterDelegate {
    func returnFilter(_ filter: String) {
        let tempData = itemsDataSource.filter { $0.language == filter }
        
        itemsDataSource.removeAll()
        itemsDataSource = tempData
        filters.toggle()
        delegate.hideEmptyView(itemsDataSource.isNotEmpty)
        delegate.reloadData()
    }
}
