//
//  SearchViewCell.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 21/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit

final class SearchViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    private func setupView() {
        titleLabel.font = .font(with: .regular, size: .normal)
        titleLabel.textColor = .appWarm
    }
    
    func update(_ model: SearchViewCellItemModel) {
        titleLabel.text = model.title
    }
}