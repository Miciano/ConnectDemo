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
    let requester = ServerRequester()
    #endif
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        os_log("%{public}@ INVALID ENDPOINT", log: .init(subsystem: "REQUESTER", category: "CREATE URL REQUEST"), type: .error, errorTitle)
        os_log("%{public}@ MICIANO", log: .init(subsystem: "teste", category: "teste"), type: .debug, errorTitle)
        
        do {
            try self.requester.requestWith(endPoint: "users/Miciano", method: .get, parameters: nil) {[weak self] (data, response, error) in
                guard let response = response as? HTTPURLResponse else { return }
                self?.convertModel(data: data, statusCode: response.statusCode)
            }
        } catch {}
    }
    
    public func convertModel(data: Data?, statusCode: Int) {
        guard let data = data, statusCode == 200 else { return }
        do {
            let decoder = JSONDecoder()
            let model = try decoder.decode(Login.self, from: data)
            print(model)
        } catch {}
    }
}
