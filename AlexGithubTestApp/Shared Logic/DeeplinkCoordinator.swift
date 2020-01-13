//
//  DeeplinkCoordinator.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 13/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import Foundation
import UIKit

class DeeplinkCoordinator {
    
    enum Path {
        case login(code: String)
    }
    
    static let shared = DeeplinkCoordinator()
    
    private init() { }
    
    func handle(_ urlContexts: Set<UIOpenURLContext>) {
        guard let supportedUrls = self.filterSupportedURLs(from: urlContexts) else { return }
        supportedUrls.forEach {
            switch $0.host ?? "" {
            case "oauth":
                self.handleOAuth(with: $0.getQueryParameters())
                
            default:
                // Can scale here
                return
            }
        }
    }
    
    private func filterSupportedURLs(from urlContexts: Set<UIOpenURLContext>) -> [URL]? {
        let supportedURLs = urlContexts
            .filter { $0.url.absoluteString.hasPrefix("alexgithubtestapp://") }
            .map { $0.url }
        return supportedURLs.isEmpty ? nil : supportedURLs
    }
    
    private func handleOAuth(with parameters: [String: String]?) {
        guard let code = parameters?["code"] else { return }
        NotificationCenter.default.post(name: .GHOAuthSuccessful, object: nil, userInfo: ["code": code])
    }
}
