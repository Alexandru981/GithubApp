//
//  Keychain.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 14/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

// -- Keys
private let kAuthTokenKey = "GHAuthTokenKeychainKey"

class Keychain {
    
    static let standard = Keychain()
    
    private init() { }
    
    var authToken: String? {
        get { KeychainWrapper.standard.string(forKey: kAuthTokenKey) }
        set {
            if let authToken = newValue { KeychainWrapper.standard.set(authToken, forKey: kAuthTokenKey) }
            else { KeychainWrapper.standard.removeObject(forKey: kAuthTokenKey) }
        }
    }
}
