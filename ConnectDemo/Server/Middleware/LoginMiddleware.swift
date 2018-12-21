//
//  LoginMiddleware.swift
//  ConnectDemo
//
//  Created by Fabio Miciano on 21/12/2018.
//  Copyright © 2018 Fabio Miciano. All rights reserved.
//

import Foundation

class LoginMiddleware {
    let requester: Requester
    
    init(requester: Requester) {
        self.requester = requester
    }
    
    func login(endpoint: Endpoint) throws -> Login? {
        return try self.requester.requestWith(endPoint: endpoint.path, method: endpoint.method, parameters: endpoint.parameters, type: Login.self)
    }
}

extension API.Login: Endpoint {
    var path: String {
        switch self {
        case .login(let user):
            return "https://api.github.com/users/\(user)"
        }
    }
    
    var method: Method {
        switch self {
        case .login:
            return .get
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case .login:
            return [:]
        }
    }
}
