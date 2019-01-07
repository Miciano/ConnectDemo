//
//  MockedRequester.swift
//  ConnectDemo
//
//  Created by Fabio Miciano on 21/12/2018.
//  Copyright © 2018 Fabio Miciano. All rights reserved.
//

import Foundation
import os

class MockedRequester: Requester {
    
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func createURLRequestWith(endPoint: String, method: Method, parameters: [String : Any]?) throws -> URLRequest {
        let bundle = Bundle(for: MockedRequester.self)
        guard let url = bundle.url(forResource: "loginMock", withExtension: "json") else {
            os_log("%{public}@ JSON MOCK NOT FIND", log: .init(subsystem: "REQUESTER", category: "LOAD JSON FILE"), type: .error, errorTitle)
            throw Errors.invalidURL
        }

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        if let parameters = parameters {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
        }

        return urlRequest
    }
    
    func requestWith(endPoint: String, method: Method, parameters: [String : Any]?, completion: @escaping RequesterCompletion) throws {
        guard let request = try? self.createURLRequestWith(endPoint: endPoint, method: method, parameters: parameters) else {
            os_log("%{public}@ ERRO OF CREATE URL REQUEST", log: .init(subsystem: "REQUESTER", category: "CREATE URL REQUEST"), type: .error, errorTitle)
            throw Errors.invalidRequest
        }
        
        self.session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }.resume()
    }
}
