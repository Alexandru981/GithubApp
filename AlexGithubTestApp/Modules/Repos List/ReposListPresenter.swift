//
//  ReposListPresenter.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 14/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import Foundation

protocol ReposListPresenter {
    func present(_ result: Result<[Repo], Error>)
    func set(isLoading: Bool)
}

class _ReposListPresenter {
    
    private weak var view: ReposListView?
    
    init(view: ReposListView) {
        self.view = view
    }
}

extension _ReposListPresenter: ReposListPresenter {
    
    func present(_ result: Result<[Repo], Error>) {
        switch result {
        case .success(let repos): self.view?.present(repos.map(ReposListViewData.init))
        case .failure(let error): self.view?.present(error)
        }
    }
    
    func set(isLoading: Bool) {
        self.view?.set(isLoading: isLoading)
    }
}

private extension ReposListViewData {
    init(_ repo: Repo) {
        self.name = repo.name
        self.ownerName = repo.ownerName
        self.ownerImageURL = repo.ownerImageURL
    }
}
