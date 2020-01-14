//
//  DataStoresFactory.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 14/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import Foundation

class DataStoresFactory {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func makeRepoDataStore(parser: RepoParser = RepoParser()) -> RepoDataStore {
        return _RepoDataStore(networkManager: self.networkManager, parser: parser)
    }
}
