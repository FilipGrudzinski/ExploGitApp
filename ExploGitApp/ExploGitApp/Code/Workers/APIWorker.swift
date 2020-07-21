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
    func getAccessToken(_ code: String)
}

final class APIWorker: APIWorkerProtocol {
    let provider = MoyaProvider<GeneralAPIService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    func fetchFeeds() -> Promise<FeedsResponse> {
        return provider.request(.feed, type: FeedsResponse.self)
    }
    
    func fetchReposSearch(_ query: String) -> Promise<ReposSearchResponse> {
        return provider.request(.repos(query), type: ReposSearchResponse.self)
    }
    
    func getAccessToken(_ code: String) {
        let getTokenPath = "https://github.com/login/oauth/access_token"
        let tokenParams = ["client_id": AuthorizationStrings.clientID, "client_secret": AuthorizationStrings.clientSecret, "code": code]
        
        Alamofire.request(getTokenPath, method: .post, parameters: tokenParams, encoding: JSONEncoding.default).responseString { response in
            if let data = response.result.value {
                let fristSplit =  data.split(separator: "&")
                for item in fristSplit {
                    let secondSplit = item.split(separator: "=")
                    if secondSplit.count == 2 {
                        let key = secondSplit[0].lowercased()
                        switch key {
                        case "access_token":
                            SessionHelper.login(String(secondSplit[1]))
                        default: ()
                        }
                    }
                }
            }
        }
    }
}
