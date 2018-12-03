//
//  ViewController.swift
//  ConnectDemo
//
//  Created by Fabio Miciano on 05/11/18.
//  Copyright © 2018 Fabio Miciano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    #if TESTABLE
    let requester = MockedRequester()
    #elseif MOCK
    let requester = MockedRequester()
    #else
    let requester = ConcreteRequester()
    #endif
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let loginMiddleware = LoginMiddleware(requester: self.requester)
        
        do{
            let result = try loginMiddleware.login()
            print("===== \(result)")
        }
        catch {
            
        }
    }


}

