//
//  RequestDtoProtocol.swift
//  Wormhole Kit Framework
//
//  Created by Salvador Mósca on 05/05/16.
//  Copyright © 2016 Salvador Mósca. All rights reserved.
//
import Foundation

extension Url
{
    func buildRequest(withData data: NSData? = nil) -> NSMutableURLRequest
    {
        return NSMutableURLRequest(url: self, dataObj: data, headers: nil)
    }
}
