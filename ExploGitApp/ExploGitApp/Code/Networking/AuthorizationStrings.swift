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
    static let clientSecret = "854f48136e54cf3ad28f3bb4ae90d4cc52b6e0d4"
    static let callback = "exploGitApp://token"
    static let authorizeURL = "https://github.com/login/oauth/authorize"
    static let accessTokenURL = "https://github.com/login/oauth/access_token"
    static let token = "token"
}
