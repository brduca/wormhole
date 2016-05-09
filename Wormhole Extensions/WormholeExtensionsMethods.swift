//
//  WormholeExtensionsMethods.swift
//  Wormhole Kit Framework
//
//  Created by Salvador Mósca on 05/05/16.
//  Copyright © 2016 Salvador Mósca. All rights reserved.
//

import Foundation

extension Optional
{
    var exists:Bool { get { return self != nil } }
    
    func or(defaultValue: Wrapped) -> Wrapped
    {
        switch(self)
        {
     
        case .None:
            return defaultValue
            
        case .Some(let value):
            return value
        }
    }
}

extension NSURLResponse
{
    func isHTTPResponseValid() -> Bool
    {
        if let response = self as? NSHTTPURLResponse
        {
            return (response.statusCode >= 200 && response.statusCode <= 299)
        }
        
        return false
    }
}

extension String
{
    mutating func appendQueryString(dictionary: NSDictionary?) -> String
    {
        if !dictionary.exists {return self }
        
        var parts = [String]()
        
        for (key, value) in dictionary!
        {
            if ((value is String) && ((value as! String) != ""))
            {
                let encoded = value.stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())! as NSString
                parts.append("\(key)=\(encoded)")
                continue
                
            }
            
            if (value is Int || value is Double || value is Float)
            {
                parts.append("\(key)=\(value)")
                continue
            }
        }
        
        return self + "?" + parts.joinWithSeparator("&")
    }
}