//
//  KeyValueCoding.swift
//  inappconfig
//
//  Created by Mecklenburg, William on 2/27/15.
//  Copyright (c) 2015 Scott A. Guyer. All rights reserved.
//

import Foundation

public protocol IACKeyValueCoding {
    func valueForKey(key: String) -> AnyObject?
    func setValue(value: AnyObject?, forKey: String)
}