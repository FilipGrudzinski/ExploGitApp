//
//  RepositoryResponseModel.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 21/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

struct RepositoryResponseModel: Decodable {
    let id: Int
    let nodeId: String?
    let name: String
    let fullName: String?
    let owner: OwnerModel?
    let url: String?
    let htmlUrl: String?
    let language: String
}
