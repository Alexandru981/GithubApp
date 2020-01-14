//
//  UIStoryboard+GithubApp.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 14/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    func instantiate<T: UIViewController>() -> T {
        return self.instantiateViewController(identifier: T.identifier)
    }
}
