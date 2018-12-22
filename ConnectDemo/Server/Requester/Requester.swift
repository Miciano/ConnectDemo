//
//  Requester.swift
//  ConnectDemo
//
//  Created by Fabio Miciano on 21/12/2018.
//  Copyright © 2018 Fabio Miciano. All rights reserved.
//

import Foundation

typealias RequesterCompletion = (Data?, URLResponse?, Error?)->Void

protocol Requester {
    func createURLRequestWith(endPoint: String, method: Method, parameters: [String: Any]?) throws -> URLRequest
    func requestWith<T>(endPoint: String, method: Method, parameters: [String: Any]?, type: T.Type, completion: @escaping RequesterCompletion) throws
}
