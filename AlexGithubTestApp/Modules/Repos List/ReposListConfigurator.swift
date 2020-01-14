//
//  ReposListConfigurator.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 14/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import UIKit

class ReposListConfigurator {
    
    static func start(using navigationController: UINavigationController,
                      dataStore: RepoDataStore,
                      storyboard: UIStoryboard) {
        
        let viewController: ReposListViewController = storyboard.instantiate()
        let presenter = _ReposListPresenter(view: viewController)
        let interactor = _ReposListInteractor(presenter: presenter,
                                              dataStore: dataStore)
        
        viewController.interactor = interactor
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
