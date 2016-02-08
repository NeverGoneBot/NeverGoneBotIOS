//
//  User.swift
//  NeverGoneBot-iOS
//
//  Created by Aadesh Patel on 2/3/16.
//  Copyright © 2016 Aadesh Patel. All rights reserved.
//

import UIKit

public final class User: JSONModel, NSCoding {
    public var id: String!
    public var username: String!
    
    public static var currentUser: User! {
        set {
            KeychainWrapper.sharedKeychain().setData(NSKeyedArchiver.archivedDataWithRootObject(newValue), forKey: "current_user")
        }
        get {
            if let data = KeychainWrapper.sharedKeychain().dataForKey("current_user") {
                let user = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? User
                
                return user
            }
            
            return nil
        }
    }
    
    required public init() {
        
    }
    
    public func map(jsonMap: JSONMap) {
        self.id ~> jsonMap["_id"]
        self.username ~> jsonMap["username"]
    }
    
    @objc public required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObjectForKey("id") as? String
        self.username = aDecoder.decodeObjectForKey("username") as? String
    }
    
    @objc public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.id, forKey: "id")
        aCoder.encodeObject(self.username, forKey: "username")
    }

}
