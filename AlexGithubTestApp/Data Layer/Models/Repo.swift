//
//  Repo.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 14/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import Foundation

protocol Repo {
    var id: Int { get }
    var name: String { get }
    var ownerName: String { get }
    var ownerImageURL: URL? { get }
}
