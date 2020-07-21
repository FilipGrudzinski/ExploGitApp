//
//  SessionHelper.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 21/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

final class SessionHelper {
    static var userIsLoggedIn: Bool {
        let tokenId: String? = KeychainManager.get(from: .accessToken)
        
        return tokenId != nil
    }
    
    static func login(_ accessToken: String) {
        KeychainManager.store(accessToken, for: .accessToken)
    }
    
    static func saveTokenToGetAccessToken(_ loginToken: String) {
        KeychainManager.store(loginToken, for: .loginToken)
    }
    
    static func logout() {
        KeychainManager.delete(with: .loginToken)
        KeychainManager.delete(with: .accessToken)
    }
    
    static func processOAuthStep1Response(url: URL) -> Bool {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        var getToken = false
        if let queryItems = components?.queryItems {
            for queryItem in queryItems {
                guard queryItem.name.lowercased() == "code", let token = queryItem.value, token != .empty else {
                    return getToken
                }
                saveTokenToGetAccessToken(token)
                getToken = true
            }
        }
        return getToken
    }
}
