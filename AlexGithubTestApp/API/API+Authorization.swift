//
//  API+Authorization.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 14/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import Foundation

extension API {
    
    struct Authorization {
        static func getAuthToken(clientId: String, clientSecret: String, code: String) -> Endpoint {
            
            return .init(path: .absolute(URL(string: "https://github.com/login/oauth/access_token")!),
                         method: .post,
                         parameters: .body([
                            "client_id": clientId,
                            "client_secret": clientSecret,
                            "code": code
            ]))
        }
    }
}
