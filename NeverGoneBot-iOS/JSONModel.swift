//
//  JSONModel.swift
//
//  Created by Aadesh Patel.
//  Copyright © 2016 Aadesh Patel. All rights reserved.
//

import UIKit

public protocol JSONModel {
    init()
    func map(jsonMap: JSONMap)
    
    @warn_unused_result
    func toJSON() -> JSON
    
    @warn_unused_result
    static func fromJSON(json: JSON) -> Self
}

public extension JSONModel {
    @warn_unused_result
    public func toJSON() -> [String : AnyObject] {
        let map = JSONMap(mapping: .To, json: [:])
        self.map(map)
        
        return map.JSON()
    }
    
    @warn_unused_result
    public static func fromJSON(json: [String : AnyObject]) -> Self {
        let map = JSONMap(mapping: .From, json: json)
        let s = Self()
        s.map(map)
        
        return s
    }
}