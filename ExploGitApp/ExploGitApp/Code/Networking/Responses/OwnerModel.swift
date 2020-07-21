//
//  OwnerModel.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 21/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

struct OwnerModel: Decodable {
    let login: String?
    let id: Int?
    let nodeId: String?
    let avatarUrl: String?
    let gravatarID: String?
    let url: String?
    let receivedEventsUrl: String?
    let type: String?
}
