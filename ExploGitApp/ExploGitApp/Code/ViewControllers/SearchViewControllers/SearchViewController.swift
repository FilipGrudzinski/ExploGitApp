//
//  SearchViewController.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 21/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit

final class SearchViewController: CommonViewController {
    private enum Constants {
        static let cellHeight: CGFloat = 60.0
    }
    
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    
    private var viewModel: SearchViewModelProtocol
    
    init(with viewModel: SearchViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        title = viewModel.title
        textField.placeholder = viewModel.searchPlaceholder
        textField.clearButtonMode = .always
        searchButton.setTitle(viewModel.searchButtonTitle, for: .normal)
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.registerCellByNib(SearchViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelectionDuringEditing = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = Constants.cellHeight
    }
    
    @IBAction private func searchButtonTap(_ sender: Any) {
        viewModel.searchButtonTap(textField.text)
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didTapCell(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSourceCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchViewCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.update(viewModel.item(at: indexPath.row))
        return cell
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func showIndicator(_ state: Bool) {
        state ? activityIndicator.show() : activityIndicator.hide()
    }
}
