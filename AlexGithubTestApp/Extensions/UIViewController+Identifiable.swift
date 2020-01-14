//
//  UIViewController+Identifiable.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 14/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import UIKit

extension UIViewController: Identifiable {
    
    static var identifier: String {
        return String(describing: self)
    }
}
