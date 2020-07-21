//
//  MainViewCache.swift
//  ExploGitApp
//
//  Created by Filip Grudziński on 21/07/2020.
//  Copyright © 2020 Filip Grudziński. All rights reserved.
//

import Foundation

protocol MainViewCacheProtocol: class {
    func getRepositories() -> RepositoryCacheModel?
    func setRepositories(_ ticket: RepositoryCacheModel)
    func clearCache()
}

final class MainViewCache {
    private enum CacheKey: NSString {
        case repository
    }
    
    private let cache = NSCache<NSString, RepositoryCacheModel>()
}

extension MainViewCache: MainViewCacheProtocol {
    func setRepositories(_ repos: RepositoryCacheModel) {
        cache.setObject(repos, forKey: CacheKey.repository.rawValue)
    }
    
    func getRepositories() -> RepositoryCacheModel? {
        return cache.object(forKey: CacheKey.repository.rawValue)
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
}

class RepositoryCacheModel: Decodable {
    let data: [RepositoryResponseModel]
    
    init(data: [RepositoryResponseModel]) {
        self.data = data
    }
}
