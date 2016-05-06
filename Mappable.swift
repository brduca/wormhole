//
//  Mappable.swift
//  Wormhole Kit Framework
//
//  Created by Salvador Mósca on 06/05/16.
//  Copyright © 2016 Salvador Mósca. All rights reserved.
//

import Foundation

protocol Mappable
{
    init(map: Map)
}

class Map
{
    var dictionary: NSDictionary
    
    init (dictionary: NSDictionary)
    {
        self.dictionary = dictionary
    }
}

struct CreateInstanceOf<T:Mappable>
{
    func from(json: NSData) -> T
    {
        let dictionary: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(json, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
        let map = Map(dictionary: dictionary)
        return T(map: map)
    }
}

