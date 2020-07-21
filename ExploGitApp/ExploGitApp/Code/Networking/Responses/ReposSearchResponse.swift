//
//  ReposSearchResponse.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 20/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

struct ReposSearchResponse: Decodable {
    let totalCount: Int
    let incompleteResults: Bool
    var items: [Repository]
    
    struct Repository: Decodable {
        let id: Int
        let nodeId: String?
        let name: String?
        let fullName: String?
        let owner: Owner?
        let url: String?
        let htmlUrl: String?
        let language: String
        
        struct Owner: Decodable {
            let login: String?
            let id: Int?
            let nodeId: String?
            let avatarUrl: String?
            let gravatarID: String?
            let url: String?
            let receivedEventsUrl: String?
            let type: String?
        }
    }
}
