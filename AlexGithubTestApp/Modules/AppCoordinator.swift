//
//  AppCoordinator.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 14/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator {
    
    private lazy var networkManager = AlamofireNetworkManager(baseURL: URL(string: "https://api.github.com")!)
    private lazy var dataStoresFactory = DataStoresFactory(networkManager: self.networkManager)
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        // Here we could keep the user logged in, for example by checking to see if the authToken is already set on Keychain
        // but because this is not in the requirements for this POC we are skipping it and asking the user to log in every
        // time they open the app.
        self.startLogin()
    }
    
    private func startLogin() {
        // I usually don't use storyboards in my projects because they have the tendency to couple views
        // together and make maintaining and updating navigation between views difficult. It is much more
        // convenient to use xibs. For this project I am using storyboards because it's a requirement, but I
        // will be keeping the navigation outside of the storyboard (will not be using segues).
        let loginStoryboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
        
        LoginConfigurator.start(using: self.navigationController,
                                oauthManager: GithubOAuthManager(networkManager: self.networkManager),
                                actionsResponder: self,
                                storyboard: loginStoryboard)
    }
    
    private func moveToRepoList() {
        let repoStoryboard = UIStoryboard(name: "RepoStoryboard", bundle: nil)
        
        ReposListConfigurator.start(using: self.navigationController,
                                    dataStore: self.dataStoresFactory.makeRepoDataStore(),
                                    storyboard: repoStoryboard)
    }
}

//MARK: - LoginActionsResponder

extension AppCoordinator: LoginActionsResponder {
    
    func loginSuccesfull() {
        self.moveToRepoList()
    }
}
