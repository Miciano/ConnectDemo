//
//  ServerRequester.swift
//  ConnectDemo
//
//  Created by Fabio Miciano on 21/12/2018.
//  Copyright © 2018 Fabio Miciano. All rights reserved.
//

import Foundation


class ServerRequester: Requester {
    let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func createURLRequestWith(endPoint: String, method: Method, parameters: [String : Any]?) throws -> URLRequest {
        let requestEndPoint = "\(baseURL)\(endPoint)"
        
        print("REQUEST ===== \(requestEndPoint)")
        guard let url = URL(string: requestEndPoint) else {
            print("\(errorTitle): INVALID ENDPOINT")
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
    
    
    func requestWith<T>(endPoint: String, method: Method, parameters: [String : Any]?, type: T.Type, completion: @escaping RequesterCompletion) throws {
        guard let request = try? self.createURLRequestWith(endPoint: endPoint, method: method, parameters: parameters) else {
            print("\(errorTitle): ERRO OF CREATE URL REQUEST")
            throw Errors.invalidRequest
        }
        
        self.session.dataTask(with: request) { (data, response, error) in
            completion(data, response, error)
        }.resume()
    }
}
