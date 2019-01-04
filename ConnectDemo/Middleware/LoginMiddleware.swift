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
        
        try self.requester.requestWith(endPoint: endpoint.path, method: endpoint.method, parameters: endpoint.parameters, type: Login.self) { (data, response, error) in
            
        }
        
        return nil
    }
}
