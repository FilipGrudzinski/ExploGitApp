//
//  MainViewCell.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 20/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit

final class MainViewCell: UICollectionViewCell {
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    private enum Constants {
        static let cornerRadius: CGFloat = 8.0
        static let shadowOffset: CGFloat = 2.0
        static let shadowOpacity: Float = 1.0
        static let shadowRadius: CGFloat = 4.0
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        setupView()
        setupShadow()
    }

    private func setupView() {
        titleLabel.font = .font(with: .bold, size: .small)
        backgroundColor = .white
        titleLabel.textColor = .appBlue
        //iconImageView.tintColor = .appBlue
    }

    private func setupShadow() {
        layer.masksToBounds = false
        layer.cornerRadius = Constants.cornerRadius
        layer.shadowOffset = CGSize(width: .zero, height: Constants.shadowOffset)
        layer.shadowColor = UIColor.appBlue.cgColor
        layer.shadowOpacity = Constants.shadowOpacity
        layer.shadowRadius = Constants.shadowRadius
    }

    func update(_ renderable: MainViewRenderable) {
        titleLabel.text = renderable.title
        //iconImageView.image = renderable.icon
    }
}
