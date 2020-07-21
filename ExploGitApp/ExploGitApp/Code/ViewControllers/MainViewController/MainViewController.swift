//
//  MainViewController.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 20/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit

final class MainViewController: CommonViewController {
    private enum Constants {
        static let collectionViewHeight: CGFloat = 120.0
        static let spacing: CGFloat = 16.0
        static let contentInset = UIEdgeInsets(top: 15.0, left: 10.0, bottom: 10.0, right: 10.0)
    }
    
    @IBOutlet private  weak var collectionView: UICollectionView!
    
    private var viewModel: MainViewModelProtocol
    
    init(with viewModel: MainViewModelProtocol) {
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
        viewModel.onViewDidLoad()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = viewModel.title
        addNavigationButtons()
        setupCollectionView()
    }
    
    private func addNavigationButtons() {
        let rightButton = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(layputButtonTap))
        let leftButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTap))
        
        navigationItem.rightBarButtonItem  = rightButton
        navigationItem.leftBarButtonItem  = leftButton
    }
    
    @objc private func layputButtonTap() {
        viewModel.switchStyle()
    }
    
    @objc private func searchButtonTap() {
        viewModel.openSearchView()
    }
    
    private func setupCollectionView() {
        collectionView.registerCellByNib(MainViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.contentInset = Constants.contentInset
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch viewModel.layoutStyle {
        case .list:
            let width = (collectionView.frame.width - Constants.spacing - collectionView.contentInset.left - collectionView.contentInset.right)
            return CGSize(width: width, height: Constants.collectionViewHeight)
        case .gird:
            let width = (collectionView.frame.width - Constants.spacing - collectionView.contentInset.left - collectionView.contentInset.right).half
            return CGSize(width: width, height: Constants.collectionViewHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectedItem(indexPath.row)
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSourceCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MainViewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        cell.update(viewModel.item(at: indexPath.row))
        return cell
    }
}

extension MainViewController: MainViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
}
