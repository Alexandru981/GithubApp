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
    
    private let networkManager: NetworkManager =
        AlamofireNetworkManager(baseURL: URL(string: "https://api.github.com")!)
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
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
}

//MARK: - LoginActionsResponder

extension AppCoordinator: LoginActionsResponder {
    
    func loginSuccesfull() {
        
    }
}
