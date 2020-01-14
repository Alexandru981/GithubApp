//
//  URLRequest+GithubApp.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 14/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import Foundation

extension URLRequest {
    
    init?(baseURL: URL?, endpoint: Endpoint) {
        
        // -- Path
        var requestURL: URL
        switch endpoint.path {
        case .absolute(let url):
            requestURL = url
        case .relative(let path):
            guard let baseURL = baseURL else { return nil }
            requestURL = baseURL.appendingPathComponent(path)
        }
        
        self = URLRequest(url: requestURL)
        
        // -- Method
        self.httpMethod = endpoint.method.rawValue
        
        // -- Headers
        endpoint.headers?.forEach {
            self.addValue($1, forHTTPHeaderField: $0)
        }
        
        // -- Parameters
        switch endpoint.parameters {
        case .some(let parameters):
            switch parameters {
            case .body(let bodyDict):
                guard let bodyData = try? JSONSerialization.data(withJSONObject: bodyDict, options: []) else {
                    break
                }
                
                self.httpBody = bodyData
                
            case .query(let queryDict):
                var urlComponents = URLComponents(url: requestURL, resolvingAgainstBaseURL: false)!
                urlComponents.queryItems = queryDict.map { URLQueryItem(name: $0, value: $1) }
                self = URLRequest(url: urlComponents.url!)
            }
            
        default: break
        }
    }
}
