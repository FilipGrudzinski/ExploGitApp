//
//  ApiResponseError.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 20/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

struct ApiResponseError: Decodable, Error {
    let error: ErrorResponseModel
    
    struct ErrorResponseModel: Decodable, Error {
        
        let code: APIError
    }
}
