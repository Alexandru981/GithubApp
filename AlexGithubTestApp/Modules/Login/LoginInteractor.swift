//
//  LoginInteractor.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 13/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import Foundation

protocol LoginInteractor: class {
    func logIn()
}

protocol LoginActionsResponder: class {
    func loginSuccesfull()
}

class _LoginInteractor {
    private let view: LoginView?
    private let oauthManager: GithubOAuthManager
    private weak var actionsResponder: LoginActionsResponder?
    
    init(view: LoginView, oauthManager: GithubOAuthManager, actionsResponder: LoginActionsResponder?) {
        self.view = view
        self.oauthManager = oauthManager
        self.actionsResponder = actionsResponder
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.logInSuccessful(notif:)),
                                               name: .GHOAuthSuccessful,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .GHOAuthSuccessful, object: nil)
    }
    
    @objc private func logInSuccessful(notif: Notification) {
        guard let code = notif.userInfo?["code"] as? String else { return }
        
        self.oauthManager.logIn(using: code) { [weak self] error in
            if let error = error {
                self?.view?.present(error: error)
                return
            }
            
            self?.actionsResponder?.loginSuccesfull()
        }
    }
}

extension _LoginInteractor: LoginInteractor {
    
    func logIn() {
        self.oauthManager.startOAuth()
    }
}
