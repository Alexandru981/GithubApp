//
//  Endpoint.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 13/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import Foundation

enum Path {
    case relative(String)
    case absolute(URL)
}

enum Parameters {
    case body([String: Any])
    case query([String: String])
}

typealias HTTPHeaders = [String: String]

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
    case put = "PUT"
}

struct Endpoint {
    let path: Path
    let method: HTTPMethod
    let headers: HTTPHeaders?
    let parameters: Parameters?
    
    init(path: Path, method: HTTPMethod = .get, headers: HTTPHeaders? = nil, parameters: Parameters? = nil) {
        self.path = path
        self.method = method
        self.headers = headers
        self.parameters = parameters
    }
}
