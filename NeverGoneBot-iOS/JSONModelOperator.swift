//
//  JSONModelOperator.swift
//
//  Created by Aadesh Patel.
//  Copyright © 2016 Aadesh Patel. All rights reserved.
//

import UIKit

infix operator ~> {}

public func ~> <T>(inout left: T, right: JSONMap) {
    if (right.mapping == JSONMapping.From) {
        JSONMap.from(&left, value: right.value())
        return
    }
    
    JSONMap.to(left, map: right)
}

public func ~> <T>(inout left: T?, right: JSONMap) {
    if (right.mapping == JSONMapping.From) {
        JSONMap.optionalFrom(&left, value: right.value())
        return
    }
    
    JSONMap.optionalTo(left, map: right)
}

public func ~> <T>(inout left: T!, right: JSONMap) {
    if (right.mapping == JSONMapping.From) {
        JSONMap.optionalFrom(&left, value: right.value())
        return
    }
    
    JSONMap.optionalTo(left, map: right)
}