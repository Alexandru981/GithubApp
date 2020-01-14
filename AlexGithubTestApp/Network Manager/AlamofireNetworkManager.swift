//
//  AlamofireNetworkManager.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 13/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireNetworkManager {
    
    enum Errors: Error {
        case invalidURLRequest
    }
    
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

//MARK: - NetworkManager

extension AlamofireNetworkManager: NetworkManager {
    
    func execute(_ endpoint: Endpoint, completion: @escaping NetworkManagerResultHandler) {
        guard var urlRequest = URLRequest(baseURL: self.baseURL, endpoint: endpoint) else {
            self.call(completion, with: .failure(Errors.invalidURLRequest))
            return
        }
        
        urlRequest.addDefaultHeaders()
        
        let dataRequest = self.dataRequest(for: urlRequest, completion: completion)
        dataRequest.resume()
    }
}

//MARK: - Helper

private extension AlamofireNetworkManager {
    
    /// Calls the provided completion block with the provided result on the main thread.
    func call(_ completion: @escaping NetworkManagerResultHandler, with result: Swift.Result<Data, Error>) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
    
    func dataRequest(for urlRequest: URLRequestConvertible,
                     completion: @escaping NetworkManagerResultHandler) -> DataRequest {
        
        return self.sessionManager
            .request(urlRequest)
            .validate(contentType: ["application/json", "text/plain", "application/x-www-form-urlencoded"])
            .responseData(completionHandler: {[weak self] response in
                switch response.result {
                case .success(let rawData):
                    self?.call(completion, with: .success(rawData))
                case .failure(let error):
                    // Here we can actually look at the error and add a wrapper around it that will help
                    // with analysing on the upper layers, but for this POC just returning the error seems fine
                    self?.call(completion, with: .failure(error))
                }
            })
    }
}

private extension URLRequest {

    mutating func addDefaultHeaders() {
       
        // If the Authorization header is already set on the request do not override it
        if self.value(forHTTPHeaderField: "Authorization") == nil,
            let authToken = Keychain.standard.authToken {
            self.addValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        }
        
        if self.value(forHTTPHeaderField: "Content-Type") == nil {
            self.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }
}
