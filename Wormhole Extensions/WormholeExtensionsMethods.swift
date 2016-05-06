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

postfix operator !! { }

postfix func !! (left: NSURLSessionTask)
{
    left.resume()
}