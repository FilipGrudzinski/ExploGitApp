//
//  CommonAlertController.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 21/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit

final class CommonAlertController: CommonViewController {
    private enum Constants {
        static let alpha: CGFloat = 0.4
        static let bacgroundAlpha: CGFloat = 0.1
        static let buttonAlpha: CGFloat = 0.5
        static let cornerRadius: CGFloat = 4.0
        static let borderWidth: CGFloat = 1.0
    }
    
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var separatorView: UIView!
    @IBOutlet private weak var confirmButton: UIButton!
    
    private var viewModel: CommonAlertViewModelProtocol

    init(with viewModel: CommonAlertViewModelProtocol) {
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
    
    @IBAction private func confirmButtonTap(_ sender: Any) {
        dismiss(animated: false, completion: viewModel.confirmDidTap)
    }
    
    private func setupView() {
        view.backgroundColor = nil
        contentView.backgroundColor = UIColor.appBlue.withAlphaComponent(Constants.bacgroundAlpha)
        separatorView.backgroundColor = UIColor.black.withAlphaComponent(Constants.alpha)
        
        confirmButton.setTitleColor(.black, for: .normal)
        confirmButton.backgroundColor = UIColor.appBlue.withAlphaComponent(Constants.buttonAlpha)
        contentView.layer.addCommonBorder()
        confirmButton.layer.addCommonBorder()

        titleLabel.font = .font(with: .bold, size: .medium)
        descriptionLabel.font = .font(with: .regular, size: .small)
        titleLabel.textColor = .appRed
        titleLabel.textAlignment = .center
        descriptionLabel.textAlignment = .center
        
        setupTexts()
    }
    
    private func setupTexts() {
        titleLabel.text = viewModel.alertTitle
        descriptionLabel.text = viewModel.alertDescription
        confirmButton.setTitle(viewModel.alertButtonTitle, for: .normal)
    }
}

extension CommonAlertController: CommonAlertViewModelDelegate { }

