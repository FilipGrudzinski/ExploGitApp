//
//  MoyaExtensions.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 20/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Moya
import PromiseKit

extension MoyaProvider where Target: TargetType {
    func request<U: Decodable>(_ target: Target, type: U.Type) -> Promise<U> {
        return Promise { resolver in
            request(target) { result in
                switch result {
                case let .success(response):
                    do {
                        do {
                            let errorResponse: ApiResponseError = try response.decode()
                            resolver.reject(errorResponse)
                        } catch {
                            let model: U = try response.decode()
                            resolver.fulfill(model)
                        }
                    } catch {
                        print(error)
                        do {
                            let errorResponse: ApiResponseError = try response.decode()
                            resolver.reject(errorResponse)
                        } catch {
                            resolver.reject(error)
                        }
                    }
                case let .failure(error):
                    resolver.reject(error)
                }
            }
        }
    }
}

extension Moya.Response {
    func decode<T: Decodable>() throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
}
