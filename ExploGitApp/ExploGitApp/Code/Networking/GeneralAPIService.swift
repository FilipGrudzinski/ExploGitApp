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
    case userRepositories
    case repos(String)
}

extension GeneralAPIService: TargetType {
    var path: String {
        switch self {
        case .userRepositories:
            return "/user/repos"
        case .repos:
            return "/search/repositories"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .userRepositories, .repos:
            return .get
        }
    }
    
    var headers: [String: String]? {
        if let token: String = KeychainManager.get(from: .accessToken) {
            return ["Authorization": "token \(token)"]
        }
        return nil
    }
    
    var task: Task {
        switch self {
        case .userRepositories, .repos:
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
        default: ()
        }
        return params
    }
}
