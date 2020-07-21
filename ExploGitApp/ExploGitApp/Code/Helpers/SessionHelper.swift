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
        let tokenId: String? = KeychainManager.get(from: .tokenId)
        
        return tokenId != nil
    }
    
    static func login(_ tokenId: String) {
        KeychainManager.store(tokenId, for: .tokenId)
    }
    
    static func logout() {
        KeychainManager.delete(with: .tokenId)
    }
    
    static func processOAuthStep1Response(url: URL) -> Bool {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if let queryItems = components?.queryItems {
            for queryItem in queryItems {
                guard queryItem.name.lowercased() == "code", let token = queryItem.value, token != .empty else {
                    break
                }
                login(token)
            }
        }
        return userIsLoggedIn
    }
}
