//
//  EmptyKitView.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 21/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit

final class EmptyKitView: UIView {
    @IBOutlet private weak var emptyImageView: UIImageView!
    @IBOutlet private weak var emptyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .white
        emptyLabel.font = .font(with: .regular, size: .medium)
        emptyLabel.textAlignment = .center
        emptyImageView.image = Asset.githubLogo.image
    }
    
    func update(_ title: String) {
        emptyLabel.text = title
    }
}
