//
//  Server+Feed.swift
//  ConnectDemo
//
//  Created by Fabio Miciano on 29/06/2018.
//  Copyright © 2018 Fabio Miciano. All rights reserved.
//

import Foundation

extension Server {
    func rewards(idUser:Int, mock: Bool = false) throws -> [Feed] {
        
        let server = mock ? ServerMock() : Server()
        return try server.requestWith(endPoint: "feed/\(idUser)", method: .get, parameters: nil, type: [Feed].self)
    }
}
