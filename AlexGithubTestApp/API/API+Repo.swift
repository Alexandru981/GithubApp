//
//  API+Repo.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 14/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import Foundation

extension API {
    
    struct Repo {
        
        static func fetch() -> Endpoint {
            return .init(path: .relative("/user/repos"),
                         parameters: .query(["sort": "full_name"]))
        }
    }
}
