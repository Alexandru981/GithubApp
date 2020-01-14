//
//  RepoDataStore.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 14/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import Foundation

protocol RepoDataStore {
    func fetchRepos(completion: @escaping (Result<[Repo], Error>) -> Void)
}

class _RepoDataStore {
    private let networkManager: NetworkManager
    private let parser: RepoParser
    
    // Usualy in the data store I also include a PersostentStore. This is a opaque type that persists the data using
    // an underlying data base which can be anything (CoreData, Realm, etc), but because this is not a requirement of
    // the POC and because of limited time I have decided to not persist the data.
    
    init(networkManager: NetworkManager, parser: RepoParser) {
        self.networkManager = networkManager
        self.parser = parser
    }
}

extension _RepoDataStore: RepoDataStore {
    
    func fetchRepos(completion: @escaping (Result<[Repo], Error>) -> Void) {
        self.networkManager.execute(API.Repo.fetch()) { [weak self] result in

            guard let sself = self else { return }
            
            switch result {
            case .success(let data):
                sself.parser.parse(from: data, completion: completion)
                // Here is where I would usually persist the data. After parsing it I would pass it to the persistent store,
                // which in turn would save it.
                
            case .failure(let error): completion(.failure(error))
                
            }
        }
                            
    }
}
