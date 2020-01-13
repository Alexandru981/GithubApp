//
//  GithubOAuthManager.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 13/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import Foundation
import UIKit

class GithubOAuthManager {
    
    // These values are sensitive and should be stored and shared in as secure manner
    // Because this app is just a POC we will hardcode them here for now
    static let kClientID = "0bba0cc1d117b9ed7e9c"
    static let kClientSecret = "c76a398ac874d5c879159ea8a0960e61164ecbd3"
    
    func startOAuth() {
        guard let url = self.buildOAuthURL() else {
            return
        }
        
        guard UIApplication.shared.canOpenURL(url) else { return }
        
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    private func buildOAuthURL() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "github.com"
        components.path = "/login/oauth/authorize"
        components.queryItems = [
            URLQueryItem(name: "scope", value: "repo"),
            URLQueryItem(name: "client_id", value: GithubOAuthManager.kClientID)
        ]
        
        return components.url
    }
}

