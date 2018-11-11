//
//  Server.swift
//  ConnectDemo
//
//  Created by Fabio Miciano on 12/06/2018.
//  Copyright © 2018 Fabio Miciano. All rights reserved.
//

import Foundation

class Server {
    
    func createURLRequestWith(endPoint: String, method: Method, parameters: [String: Any]?) throws -> URLRequest {
        let requestEndPoint = "\(baseURL)\(endPoint)"
        
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
    
    func requestWith<T>(endPoint: String, method: Method, parameters: [String: Any]?, type: T.Type) throws -> T where T: Decodable {
        guard let request = try? self.createURLRequestWith(endPoint: endPoint, method: method, parameters: parameters) else {
            print("\(errorTitle): ERRO OF CREATE URL REQUEST")
            throw Errors.invalidRequest
        }
        
        var dataRequest: Data?
        var responseRequest: URLResponse?
        var errorRequest: Error?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            dataRequest = data
            responseRequest = response
            errorRequest = error
            semaphore.signal()
        }.resume()
        
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        
        if let error = errorRequest {
            throw error
        } else if let httpResponse = responseRequest as? HTTPURLResponse, httpResponse.statusCode == 200, let data = dataRequest {
            let decoder = JSONDecoder()

            return try decoder.decode(type, from: data)
        } else {
            print("\(errorTitle): ERROR ON REQUEST")
            throw Errors.serverError
        }
    }
}
