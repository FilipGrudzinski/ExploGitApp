//
//  BaseTargetType.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 20/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation
import Moya

extension TargetType {
    var baseURL: URL { URL(string: "https://api.github.com")! }
    var headers: [String : String]? { ["Content-Type": "application/json"] }
    var sampleData: Data { Data() }
}
