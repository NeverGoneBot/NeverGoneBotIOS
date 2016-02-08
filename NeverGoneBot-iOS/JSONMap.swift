//
//  JSONMap.swift
//
//  Created by Aadesh Patel.
//  Copyright © 2016 Aadesh Patel. All rights reserved.
//

import UIKit

public typealias JSON = [String : AnyObject]

public enum JSONMapping {
    case To, From
}

public class JSONMap {
    public let mapping: JSONMapping!
    
    private var key: String?
    private var val: AnyObject?
    private var json = [String : AnyObject]()
    
    public init(mapping: JSONMapping, json: [String : AnyObject]) {
        self.mapping = mapping
        self.json = json
    }
    
    public func value<T>() -> T? {
        return self.val as? T
    }
    
    public func JSON() -> [String : AnyObject] {
        return self.json
    }
    
    public subscript(key: String) -> JSONMap {
        get {
            self.key = key
            self.val = self.json[key]
        
            return self
        }
    }
    
    public func setValue(value: AnyObject, forKey key: String) {
        self.json[key] = value
    }
}

extension JSONMap {
    public static func from<T>(inout left: T, value: T?) {
        guard let v = value else { return }
        left = v
    }
    
    public static func optionalFrom<T>(inout left: T?, value: T?) {
        guard let v = value else { return }
        left = v
    }
    
    public static func optionalFrom<T>(inout left: T!, value: T?) {
        guard let v = value else { return }
        left = v
    }
    
    public static func to<T>(left: T, map: JSONMap) {
        guard let k = map.key, let v = left as? AnyObject else { return }
        map.setValue(v, forKey: k)
    }
    
    public static func optionalTo<T>(left: T?, map: JSONMap) {
        guard let v = left else { return }
        JSONMap.to(v, map: map)
    }
}
