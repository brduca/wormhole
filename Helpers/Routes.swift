//
//  ServiceDtoProtocol.swift
//  Wormhole Kit Framework
//
//  Created by Salvador Mósca on 06/05/16.
//  Copyright © 2016 Salvador Mósca. All rights reserved.
//

import Foundation

struct Routes
{
    let route: String
    let method: HttpMethods
}

struct Url
{
    let route: Routes
    let queryStringParams: NSDictionary?
}   