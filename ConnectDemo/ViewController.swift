//
//  ViewController.swift
//  ConnectDemo
//
//  Created by Fabio Miciano on 05/11/18.
//  Copyright © 2018 Fabio Miciano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    #if TESTABLE || MOCK
    let requester = MockedRequester()
    #else
    let requester = ServerRequester()
    #endif
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let loginMiddleware = LoginMiddleware(requester: self.requester)
        
        do{
            let endpoint: API.Login  = .login(user: "Miciano")
            let result = try loginMiddleware.login(endpoint: endpoint)
            print("===== \(result)")
        }
        catch {
            
        }
    }


}

