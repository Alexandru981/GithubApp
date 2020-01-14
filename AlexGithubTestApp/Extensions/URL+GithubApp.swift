//
//  URL+GithubApp.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 13/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import Foundation

extension URL {

    func getQueryParameters() -> [String: String]? {
        guard let keyValuePairs: [(String, String)] = URLComponents(url: self, resolvingAgainstBaseURL: false)?
            .queryItems?
            .compactMap({
            guard let value = $0.value else { return nil }
            return ($0.name, value)
        }) else {
            return nil
        }
        
        return Dictionary(uniqueKeysWithValues: keyValuePairs)
    }
}

