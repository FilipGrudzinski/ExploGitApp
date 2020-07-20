//
//  BundleExtension.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 20/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

extension Bundle {
    static func loadNib<T>(_ owner: T) {
        main.loadNibNamed(String(describing: type(of: owner)), owner: owner, options: nil)
    }
}
