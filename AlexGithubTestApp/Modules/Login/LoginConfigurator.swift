//
//  LoginConfigurator.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 14/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import Foundation
import UIKit

class LoginConfigurator {
    
    static func start(using navigationController: UINavigationController,
                      oauthManager: GithubOAuthManager,
                      actionsResponder: LoginActionsResponder?,
                      storyboard: UIStoryboard) {
        
        let viewController: LoginViewController = storyboard.instantiate()
        let interactor = _LoginInteractor(view: viewController,
                                          oauthManager: oauthManager,
                                          actionsResponder: actionsResponder)
        
        viewController.interactor = interactor
        
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
