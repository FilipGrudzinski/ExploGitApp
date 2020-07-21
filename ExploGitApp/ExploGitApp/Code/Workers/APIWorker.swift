//
//  APIWorker.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 20/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Moya
import Alamofire
import PromiseKit

protocol APIWorkerProtocol {
    func fetchFeeds() -> Promise<FeedsResponse>
    func fetchReposSearch(_ query: String) -> Promise<ReposSearchResponse>
}

final class APIWorker: APIWorkerProtocol {
    let provider = MoyaProvider<GeneralAPIService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    func fetchFeeds() -> Promise<FeedsResponse> {
        return provider.request(.feed, type: FeedsResponse.self)
    }
    
    func fetchReposSearch(_ query: String) -> Promise<ReposSearchResponse> {
        return provider.request(.repos(query: query), type: ReposSearchResponse.self)
    }
}
