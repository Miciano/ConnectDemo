//
//  EndPoint.swift
//  ConnectDemo
//
//  Created by Fabio Miciano on 21/12/2018.
//  Copyright © 2018 Fabio Miciano. All rights reserved.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: Method { get }
    var parameters: [String: Any] { get }
}
