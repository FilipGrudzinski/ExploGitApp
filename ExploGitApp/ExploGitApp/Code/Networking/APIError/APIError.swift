//
//  APIError.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 20/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

enum APIError: Int, Decodable {
    case invalidAPIKey = 1
    case notDefined = 999999
    
    init(from decoder: Decoder) throws {
        let int = try decoder.singleValueContainer().decode(Int.self)
        guard let apiError = APIError(rawValue: int) else {
            self = .notDefined
            return
        }
        self = apiError
    }
}
