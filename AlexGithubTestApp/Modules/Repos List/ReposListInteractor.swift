//
//  ReposListInteractor.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 14/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import Foundation

protocol ReposListInteractor {
    func fetchRepos()
}

class _ReposListInteractor {
    
    private let presenter: ReposListPresenter
    private let dataStore: RepoDataStore
    
    init(presenter: ReposListPresenter, dataStore: RepoDataStore) {
        self.presenter = presenter
        self.dataStore = dataStore
    }
}

//MARK: - ReposListInteractor

extension _ReposListInteractor: ReposListInteractor {
    
    func fetchRepos() {
        self.presenter.set(isLoading: true)
        self.dataStore.fetchRepos { [weak self] result in
            self?.presenter.set(isLoading: false)
            self?.presenter.present(result)
        }
    }
}
