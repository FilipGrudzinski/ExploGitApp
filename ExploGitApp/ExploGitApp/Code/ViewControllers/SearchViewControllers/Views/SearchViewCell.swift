//
//  SearchViewCell.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 21/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit
import Kingfisher

final class SearchViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    private func setupView() {
        titleLabel.font = .font(with: .regular, size: .normal)
        titleLabel.textColor = .appBlue
        titleLabel.numberOfLines = .zero
        languageLabel.font = .font(with: .regular, size: .small)
        languageLabel.textColor = .appOrange
    }
    
    func update(_ model: SearchViewCellItemModel) {
        titleLabel.text = model.title
        languageLabel.text = model.language
        guard let imageUrl = model.imageURL, let url = URL(string: imageUrl) else {
            avatarImage.image = Asset.emptyAvatar.image
            return
        }
        avatarImage.kf.setImage(with: url)
    }
}
