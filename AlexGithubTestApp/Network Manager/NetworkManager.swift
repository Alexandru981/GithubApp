//
//  NetworkManager.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 13/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import Foundation

typealias NetworkManagerResultHandler = (Result<Data, Error>) -> Void

protocol NetworkManager {
    
    /// Executes the provided `request` asynchronously.
    /// When finished the `completion` closure is called on the main queue. (Should inject the queue but we are using the main queue for this POC)
    func execute(_ endpoint: Endpoint, completion: @escaping NetworkManagerResultHandler)
}
