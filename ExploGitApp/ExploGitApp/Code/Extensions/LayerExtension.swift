//
//  LayerExtension.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 20/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit

extension CALayer {
    private enum Constants {
        static let alpha: CGFloat = 0.4
        static let bacgroundAlpha: CGFloat = 0.1
        static let cornerRadius: CGFloat = 4.0
        static let borderWidth: CGFloat = 1.0
    }
    
    func addCommonBorder() {
        self.cornerRadius = Constants.cornerRadius
        self.borderWidth = Constants.borderWidth
        self.borderColor = UIColor.black.withAlphaComponent(Constants.alpha).cgColor
    }
}
