//
//  Login.swift
//  ConnectDemo
//
//  Created by Fabio Miciano on 05/11/18.
//  Copyright © 2018 Fabio Miciano. All rights reserved.
//

import Foundation

struct Login: Codable {
    let login: String
    let id: Int
    let repos: Int
    let followers: Int
    
    private enum CodingKeys: String, CodingKey {
        case login
        case id
        case repos = "public_repos"
        case followers
    }
}

struct User: Codable {
    let id: Int
    let name: String
    let profile: String
}
