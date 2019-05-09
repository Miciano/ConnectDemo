//
//  ViewController.swift
//  ConnectDemo
//
//  Created by Fabio Miciano on 05/11/18.
//  Copyright © 2018 Fabio Miciano. All rights reserved.
//

import UIKit
import os

class ViewController: UIViewController {

    #if DEBUG
    let requester = MockedRequester()
    #else
    let requester = ServerRequester(useSSL: true, useCache: true)
    #endif
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            
            #if DEBUG
                requester.setMockFile(nameFile: "loginMock", extensionFile: "json")
            #endif
            
            try self.requester.requestWith(endPoint: "users/Miciano", method: .get, parameters: nil) {[weak self] (data, response, error) in
                self?.convertModel(data: data)
            }
            
        } catch {}
    }
    
    public func convertModel(data: Data?) {
        guard let data = data else { return }
        do {
            let decoder = JSONDecoder()
            let model = try decoder.decode(Login.self, from: data)
            print(model)
        } catch {}
    }
}
