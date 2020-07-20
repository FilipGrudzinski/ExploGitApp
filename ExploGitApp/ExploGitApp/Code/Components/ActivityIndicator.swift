//
//  ActivityIndicator.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 20/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit
import PromiseKit

class ActivityIndicator: UIView {
    private enum Constants {
        static let bacgroundColor = UIColor.black.withAlphaComponent(0.2)
        static let opaque: CGFloat = 1.0
    }
    
    private let activityIndicator = UIActivityIndicatorView()
        
    private weak var inView: UIView?
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented yet")
    }
    
    init(_ inView: UIView) {
        self.inView = inView
        super.init(frame: .zero)
        inView.addSubview(self)
        setup()
        isHidden = true
    }
    
    func show() {
        UIView.animate(.promise, duration: .zero) {
            self.alpha = Constants.opaque
        }
        .done { done in
            if done {
                self.isHidden = false
            }
        }
    }
    
    func hide() {
        UIView.animate(.promise, duration: .zero) {
            self.alpha = .zero
        }
        .done { done in
            if done {
                self.isHidden = true
            }
        }
    }
    
    private func setup() {
        guard let inView = inView else {
            return
        }
        
        activityIndicator.startAnimating()
        backgroundColor = Constants.bacgroundColor
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            leadingAnchor.constraint(equalTo: inView.leadingAnchor),
            trailingAnchor.constraint(equalTo: inView.trailingAnchor),
            topAnchor.constraint(equalTo: inView.topAnchor),
            bottomAnchor.constraint(equalTo: inView.bottomAnchor)
        ])
    }
}
