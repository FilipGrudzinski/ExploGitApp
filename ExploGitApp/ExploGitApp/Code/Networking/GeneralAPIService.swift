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
    case feed
    case repos(query: String)
    case details
}

extension GeneralAPIService: TargetType {
    var path: String {
        switch self {
        case .feed:
            return ""
        case .repos:
            return "/search/repositories"
        case .details:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .feed:
            return .get
        case .repos:
            return .get
        case .details:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .feed, .details, .repos:
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
        default: break
        }
        return params
    }
}
