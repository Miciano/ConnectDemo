//
//  API.swift
//  ConnectDemo
//
//  Created by Fabio Miciano on 21/12/2018.
//  Copyright © 2018 Fabio Miciano. All rights reserved.
//

import Foundation

enum API {
    enum Login {
        case login(user: String)
    }
    enum Feed {
        case fetchUserFeed(userId: Int)
        case postFeedItem(feedItem: Any)
    }
}
