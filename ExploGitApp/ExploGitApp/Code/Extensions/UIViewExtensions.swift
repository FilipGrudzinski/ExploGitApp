//
//  UIViewExtensions.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 21/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit

extension UIView {
    func activate(_ constraints: [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
    
    func activeToEdges(_ inset: UIEdgeInsets = .zero) {
        guard let superview = superview else { return }
        
        activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: inset.left),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -inset.right),
            topAnchor.constraint(equalTo: superview.topAnchor, constant: inset.top),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -inset.bottom)])
    }
}
