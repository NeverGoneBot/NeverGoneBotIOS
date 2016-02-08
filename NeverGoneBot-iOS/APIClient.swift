//  Created by Aadesh Patel
//  Copyright © 2015 Aadesh Patel. All rights reserved.
//

import UIKit

public protocol APIRoute {
    var description: String { get }
}

public typealias APIParameters = [String : AnyObject]?
public typealias APISuccessBlock = (([String : AnyObject]) -> Void)?
public typealias APIFailureBlock = ((NSError) -> Void)?

public class APIClient: NSObject {
    private static var HttpReqManager: AFHTTPRequestOperationManager {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static let httpReqManager = AFHTTPRequestOperationManager()
        }
        
        dispatch_once(&Static.onceToken) {
            Static.httpReqManager.requestSerializer = AFJSONRequestSerializer()
            Static.httpReqManager.responseSerializer = AFJSONResponseSerializer()
            Static.httpReqManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
            Static.httpReqManager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Accept")
        }
        
        return Static.httpReqManager
    }
    
    private static let BaseUrl = "http://BASE_URL/"
    
    public static func GET(route: APIRoute, params: APIParameters, success: APISuccessBlock, failure: APIFailureBlock)
    {
        APIClient.HttpReqManager.GET(APIClient.BaseUrl + route.description,
            parameters: params as? AnyObject,
            success: { (operation: AFHTTPRequestOperation, response: AnyObject) -> Void in
                guard let dict = response as? [String : AnyObject] else {
                    return
                }
                
                success?(dict)
            }, failure: { (operation: AFHTTPRequestOperation?, error: NSError) -> Void in
                failure?(error)
        })
    }
    
    public static func POST(route: APIRoute, params: APIParameters, success: APISuccessBlock, failure: APIFailureBlock) {
        APIClient.HttpReqManager.POST(APIClient.BaseUrl + route.description,
            parameters: params!,
            success: { (operation: AFHTTPRequestOperation, response: AnyObject) -> Void in
                guard let dict = response as? [String : AnyObject] else {
                    return
                }
                
                success?(dict)
            }, failure: { (operation: AFHTTPRequestOperation?, error: NSError) -> Void in
                failure?(error)
        })
    }
    
    public static func PUT(route: APIRoute, params: APIParameters, success: APISuccessBlock, failure: APIFailureBlock) {
        APIClient.HttpReqManager.PUT(APIClient.BaseUrl + route.description,
            parameters: params!,
            success: { (operation: AFHTTPRequestOperation, response: AnyObject) -> Void in
                guard let dict = response as? [String : AnyObject] else {
                    return
                }
                
                success?(dict)
            }, failure: { (operation: AFHTTPRequestOperation?, error: NSError) -> Void in
                failure?(error)
        })
    }
    
    public static func PATCH(route: APIRoute, params: APIParameters, success: APISuccessBlock, failure: APIFailureBlock) {
        APIClient.HttpReqManager.PATCH(APIClient.BaseUrl + route.description,
            parameters: params!,
            success: { (operation: AFHTTPRequestOperation, response: AnyObject) -> Void in
                guard let dict = response as? [String : AnyObject] else {
                    return
                }
                
                success?(dict)
            }, failure: { (operation: AFHTTPRequestOperation?, error: NSError) -> Void in
                failure?(error)
        })
    }
}
