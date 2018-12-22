//
//  ViewController.swift
//  ConnectDemo
//
//  Created by Fabio Miciano on 05/11/18.
//  Copyright © 2018 Fabio Miciano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    #if DEBUG
    let requester = MockedRequester()
    #else
    let requester = ServerRequester()
    #endif
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        do {
            try self.requester.requestWith(endPoint: "users/Miciano", method: .get, parameters: [:], type: Login.self) { (data, response, error) in
                print("DATA = \(data) | RESPONSE = \(response) | ERROR = \(error)")
            }
        } catch {
            
        }
        
    }
}
