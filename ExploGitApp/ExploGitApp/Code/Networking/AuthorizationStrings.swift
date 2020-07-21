//
//  AuthorizationStrings.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 21/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

enum AuthorizationStrings {
    static let clientID = "307fa72bfadd586b227d"
    static let clientSecret = "69f19c38a37c1f79a778d9675d26fb8af8b9503d"
    static let authorizeURL = "https://github.com/login/oauth/authorize?client_id=\(clientID)&scope=repo&state=TEST_STATE"
}
