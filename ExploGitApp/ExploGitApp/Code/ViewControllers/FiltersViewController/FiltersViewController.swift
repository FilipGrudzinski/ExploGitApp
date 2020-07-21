//
//  FiltersViewController.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 21/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit

final class FiltersViewController: CommonViewController {
    private enum Constants {
        static let cellHeight: CGFloat = 62.0
    }
    
    @IBOutlet private  weak var tableView: UITableView!
    
    private var viewModel: FiltersViewModelProtocol
    
    init(with viewModel: FiltersViewModelProtocol) {
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
        view.backgroundColor = .white
        title = viewModel.title
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.registerCellByNib(FiltersCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelectionDuringEditing = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = Constants.cellHeight
    }
}

extension FiltersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didTapCell(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FiltersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSourceCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FiltersCell = tableView.dequeueReusableCell(indexPath: indexPath)
        cell.update()
        return cell
    }
}

extension FiltersViewController: FiltersViewModelDelegate {
}
