//
//  SocketService.swift
//  NeverGoneBot-iOS
//
//  Created by Aadesh Patel on 2/3/16.
//  Copyright © 2016 Aadesh Patel. All rights reserved.
//

import UIKit

public typealias SubscriptionHandler = ([AnyObject], SocketAckEmitter) -> Void

public class SocketService: NSObject {
    private static let URL = "http://URL"
    private static let Socket = SocketIOClient(socketURL: NSURL(string: SocketService.URL)!, options: [.Log(true), .ForcePolling(true)])
    
    public static func connect() {
        SocketService.Socket.connect()
    }
    
    public static func subscribe(topic: String, callback: SubscriptionHandler) {
        SocketService.Socket.on(topic, callback: callback)
    }
    
    public static func publish(topic: String, items: AnyObject...) {
        SocketService.Socket.emit(topic, items)
    }
}
