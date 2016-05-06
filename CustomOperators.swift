//
//  MappableOperators.swift
//  Wormhole Kit Framework
//
//  Created by Salvador Mósca on 06/05/16.
//  Copyright © 2016 Salvador Mósca. All rights reserved.
//

import Foundation

/// Mapping operators
infix operator * {}

func * (left: Map, right: String) -> Int
{
    return left.dictionary[right] as! Int
}

func * (left: Map, right: String) -> String
{
    return left.dictionary[right] as! String
}


/// Task starter operator
postfix operator !! { }

postfix func !! (left: NSURLSessionTask)
{
    left.resume()
}

func foo()
{
    
}