//
//  ApiResponseError.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 20/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

struct ApiResponseError: Decodable, Error {
    
    let message: String
    let errors: [ErrorResponseModel]?
    let documentationUrl: String?
    
    struct ErrorResponseModel: Decodable, Error {
        let resource: String?
        let field: String?
        let code: String?
    }
}
