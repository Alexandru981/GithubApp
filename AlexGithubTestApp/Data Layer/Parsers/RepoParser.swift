//
//  RepoParser.swift
//  AlexGithubTestApp
//
//  Created by Alex Miculescu on 14/01/2020.
//  Copyright © 2020 Alex Miculescu. All rights reserved.
//

import Foundation

class RepoParser {
    
    /// Parses the data into Repo objects on a background queue and calls the completion block with the result on the main queue
    func parse(from data: Data, completion: @escaping (Result<[Repo], Error>) -> Void) {
        DispatchQueue.init(label: "repo_parse_queue", qos: .background).async {
            do {
                let repos = try JSONDecoder().decode([_Repo].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(repos))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}


private struct _Repo: Repo {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "full_name"
        case ownerName = "login"
        case ownerImageURL = "avatar_url"
        
        case owner = "owner"
    }
    
    var id: Int
    var name: String
    var ownerName: String
    var ownerImageURL: URL?
}

extension _Repo: Decodable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decode(Int.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
        
        let owner = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .owner)
        
        self.ownerName = try owner.decode(String.self, forKey: .ownerName)
        self.ownerImageURL = try? owner.decode(URL.self, forKey: .ownerImageURL)
    }
}
