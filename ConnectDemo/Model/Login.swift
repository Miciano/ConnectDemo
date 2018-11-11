//
//  Login.swift
//  ConnectDemo
//
//  Created by Fabio Miciano on 05/11/18.
//  Copyright © 2018 Fabio Miciano. All rights reserved.
//

import Foundation

struct Login: Codable {
    let user: User
}

struct User: Codable {
    let id: Int
    let name: String
    let profile: String
}
