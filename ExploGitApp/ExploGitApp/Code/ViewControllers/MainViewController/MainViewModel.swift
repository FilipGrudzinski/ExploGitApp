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
    
    private let coordinator: MainCoordinatorProtocol
    private let worker: APIWorkerProtocol
    private var itemsDataSource: [MainViewRenderable] = []
    private var dataSource: [String] = []
    
    init(_ coordinator: MainCoordinatorProtocol, worker: APIWorkerProtocol = APIWorker()) {
        self.coordinator = coordinator
        self.worker = worker
    }
    
    private func loadFeeds() {
        worker.fetchFeeds()
            .done { response in
                print(response)
                self.delegate.showIndicator(false)
                self.parseResponse()
        } . catch { error in
            self.errorHandler(error)
        }
    }
    
    private func parseResponse() {
        itemsDataSource.removeAll()
        
        dataSource.forEach { item in

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
            fatalError()
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
    var filterButtonTitle: String { Localized.mainViewFilterButtonTitle }
    var dataSourceCount: Int { dataSource.count }
    var layoutStyle: MainViewLayoutStyle { listStyle ? .list : .gird }
    
    func onViewDidLoad() {
        delegate.hideEmptyView(itemsDataSource.isNotEmpty)
        loadFeeds()
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
    
    func logout() {
        coordinator.logout()
    }
}
