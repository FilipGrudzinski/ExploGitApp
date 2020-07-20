//
//  CommonModalNavigationController.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 20/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import UIKit

final class CommonModalNavigationController: MainNavigationController {
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        addCloseButton()
    }
    
    private func addCloseButton() {
        topViewController?.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(dismissView))
    }
    
    @objc private func dismissView() {
        dismiss(animated: true)
    }
}
