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
    
    enum Errors: Error {
        case parsingFailed
    }
    
    // These values are sensitive and should be stored and shared in as secure manner
    // Because this app is just a POC we will hardcode them here for now
    static let kClientID = "0bba0cc1d117b9ed7e9c"
    static let kClientSecret = "c76a398ac874d5c879159ea8a0960e61164ecbd3"
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
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
    
    
    func logIn(using code: String, completion: @escaping (Error?) -> Void) {
        self.networkManager.execute(API.Authorization.getAuthToken(clientId: GithubOAuthManager.kClientID,
                                                                   clientSecret: GithubOAuthManager.kClientSecret,
                                                                   code: code)) { [weak self] result in
                                                                    switch result {
                                                                    case .success(let data):
                                                                        guard let authToken = self?.extractAuthToken(from: data) else {
                                                                            completion(Errors.parsingFailed)
                                                                            return
                                                                        }
                                                                        
                                                                        Keychain.standard.authToken = authToken
                                                                        
                                                                        completion(nil)
                                                                        
                                                                    case .failure(let error):
                                                                        completion(error)
                                                                    }
                                                        
        }
    }
    
    private func extractAuthToken(from data: Data) -> String? {
        guard let string = String(data: data, encoding: .utf8) else { return nil }
        var urlComponents = URLComponents()
        urlComponents.query = string
        return urlComponents.queryItems?.first(where: { $0.name == "access_token" })?.value
    }
}

