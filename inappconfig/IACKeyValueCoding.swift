//
//  KeyValueCoding.swift
//  inappconfig
//
//  Created by Mecklenburg, William on 2/27/15.
//  Copyright (c) 2015 Scott A. Guyer. All rights reserved.
//

import Foundation


/*
Protocol for classes who implement the key value coding required for persisting
data in the app. Modelled after the informal protocol NSKeyValueCoding
*/
public protocol IACKeyValueCoding {
    func valueForKey(key: String) -> AnyObject?
    func setValue(value: AnyObject?, forKey: String)
}