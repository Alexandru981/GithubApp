//
//  AlamofireNetworkManager.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 13/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

class AlamofireNetworkManager {
    
    let baseURL: URL
    let sessionManager: SessionManager
    
    required init(baseURL: URL) {
        self.baseURL = baseURL
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        self.sessionManager = SessionManager(configuration: configuration)
        self.sessionManager.startRequestsImmediately = false
    }
    
}
