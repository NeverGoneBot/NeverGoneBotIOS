//
//  UserService.swift
//  NeverGoneBot-iOS
//
//  Created by Aadesh Patel on 2/3/16.
//  Copyright © 2016 Aadesh Patel. All rights reserved.
//

import UIKit

public enum UserServiceRoute: APIRoute {
    private static let baseRoute = "users/"
    
    case Create
    case Update(String)
    case Authenticate
    case Get(String)
    case AddProfilePhoto
    
    public var description: String {
        get {
            var route = UserServiceRoute.baseRoute
            
            switch(self) {
            case .Get(let userId):
                route += "\(userId)/"
            case .Update(let userId):
                route += "\(userId)/"
            case .Authenticate:
                route += "login/"
            default:
                route += ""
            }
            
            return route
        }
    }
}

public class UserService: NSObject {
    public static func createUser(user: User, withPassword password: String) {
        APIClient.POST(UserServiceRoute.Create,
            params: ["username": user.username, "password": password],
            success: nil,
            failure: nil)
    }
    
    public static func updateUser(user: User) {
        APIClient.PUT(UserServiceRoute.Update(user.id),
            params: ["username": user.username],
            success: nil,
            failure: nil)
    }
    
    public static func authenticateUser(username: String!, password: String!, success: APISuccessBlock, failure: APIFailureBlock) {
        APIClient.POST(UserServiceRoute.Authenticate,
            params: ["username": username, "password": password],
            success: success,
            failure: failure)
    }
    
    public static func getUser(user: User) {
        APIClient.GET(UserServiceRoute.Get(user.id),
            params: nil,
            success: { (response: [String : AnyObject]) -> Void in
                user.username = response["username"] as? String
            }, failure: nil)
    }
}
