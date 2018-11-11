//
//  ServerProtocol.swift
//  ConnectDemo
//
//  Created by Fabio Miciano on 12/06/2018.
//  Copyright © 2018 Itaú. All rights reserved.
//

import Foundation

protocol ServerProtocol {
    func createURLRequestWith(endPoint: String, method: Method, parameters: Encodable?) throws -> URLRequest
    //    func createRequestWith(parameters: [String: Any])
}
