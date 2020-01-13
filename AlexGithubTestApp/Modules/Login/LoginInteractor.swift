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

class _LoginInteractor {
    private let oauthManager: GithubOAuthManager
    
    init(oauthManager: GithubOAuthManager) {
        self.oauthManager = oauthManager
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.logInSuccessful(notif:)),
                                               name: .GHOAuthSuccessful,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .GHOAuthSuccessful, object: nil)
    }
    
    @objc private func logInSuccessful(notif: Notification) {
        guard let code = notif.userInfo?["code"] else { return }
        
        //TODO:
    }
}

extension _LoginInteractor: LoginInteractor {
    
    func logIn() {
        oauthManager.startOAuth()
    }
}
