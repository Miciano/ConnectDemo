//
//  Feed.swift
//  ConnectDemo
//
//  Created by Fabio Miciano on 05/11/18.
//  Copyright © 2018 Fabio Miciano. All rights reserved.
//

import Foundation

struct Feed: Codable {
    let name: String
    let description: String
    let photo: String
    let likes: Int
}
