//
//  GeneralAPIService.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 20/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation
import Moya

enum GeneralAPIService {
    case getAccessToken(String)
    case feed
    case repos(String)
}

extension GeneralAPIService: TargetType {
    var path: String {
        switch self {
        case .getAccessToken:
            return "/login/oauth/access_token"
        case .feed:
            return "/feeds"
        case .repos:
            return "/search/repositories"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .feed, .repos:
            return .get
        case .getAccessToken:
            return .post
        }
    }
    
    var headers: [String: String]? {
        if let token: String = KeychainManager.get(from: .accessToken) {
            return ["Authorization": "Basic \(token)"]
        }
        return nil
    }
    
    var task: Task {
        switch self {
        case .feed, .repos, .getAccessToken:
            if let parameters = parameters {
                return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            }
            return .requestPlain
        }
    }
    
    var parameters: [String: Any]? {
        var params: [String: Any] = [:]
        switch self {
        case let .repos(query):
            params["q"] = query
        case let .getAccessToken(code):
            params["code"] = code
            params["client_secret"] = AuthorizationStrings.clientSecret
            params["client_id"] = AuthorizationStrings.clientID
        default: break
        }
        return params
    }
}
