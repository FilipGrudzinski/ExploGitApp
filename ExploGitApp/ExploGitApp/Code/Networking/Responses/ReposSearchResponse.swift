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
    var items: [RepositoryResponseModel]
}
