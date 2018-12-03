//
//  Server+Login.swift
//  ConnectDemo
//
//  Created by Fabio Miciano on 14/06/2018.
//  Copyright © 2018 Fabio Miciano. All rights reserved.
//

import Foundation

protocol Requester {
    func createURLRequestWith(endPoint: String, method: Method, parameters: [String: Any]?) throws -> URLRequest?
    func requestWith<T>(endPoint: String, method: Method, parameters: [String: Any]?, type: T.Type) throws -> T? where T: Decodable
}

class MockedRequester: Requester {
    func createURLRequestWith(endPoint: String, method: Method, parameters: [String: Any]?) throws -> URLRequest? {
        return nil
    }

    func requestWith<T>(endPoint: String, method: Method, parameters: [String: Any]?, type: T.Type) throws -> T? where T: Decodable {
        return nil
    }
}

class ConcreteRequester: Requester {
    func createURLRequestWith(endPoint: String, method: Method, parameters: [String: Any]?) throws -> URLRequest? {
        return nil
    }
    
    func requestWith<T>(endPoint: String, method: Method, parameters: [String: Any]?, type: T.Type) throws -> T? where T: Decodable {
        return nil
    }
}

class LoginMiddleware {
    
    let requester: Requester
    
    init(requester: Requester) {
        self.requester = requester
    }
    
    func login() throws -> Login? {
        return try self.requester.requestWith(endPoint: "login", method: .post, parameters: [:], type: Login.self)
    }
}

protocol Endpoint {
    var path: String { get }
    var method: Method { get }
    var parameters: [String: Any] { get }
}

enum API {
    enum Login {
        case login(account: String, password: String, deviceId: String)
    }
    enum Feed {
        case fetchUserFeed(userId: Int)
        case postFeedItem(feedItem: Any)
    }
}

extension API.Login: Endpoint {
    var path: String {
        switch self {
        case .login:
            return "login"
        }
    }
    
    var method: Method {
        switch self {
        case .login:
            return .post
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case .login(let account, let password, let deviceId):
            return ["account": account, "password": password, "deviceid": deviceId]
        }
    }
}

extension Server {
    func login(mock: Bool = false) throws -> Login {
        
        //BLOCO APENAS PARA TESTE   
        struct PostLogin: Codable {
            var account = "123456789"
            var password = "1234"
            var deviceId = ""
            
            func toDictionary()->[String: Any] {
                return ["account": self.account, "password": self.password, "deviceid": self.deviceId]
            }
        }
        
        let server = mock ? ServerMock() : Server()
        return try server.requestWith(endPoint: "login", method: .post , parameters: PostLogin().toDictionary(), type: Login.self)
    }
}
