//
//  HttpStatus.swift
//  Wormhole Kit Framework
//
//  Created by Salvador Mósca on 05/05/16.
//  Copyright © 2016 Salvador Mósca. All rights reserved.
//

import Foundation

public enum HttpMethods: String
{
    case GET = "get"
    case POST = "post"
    case PUT = "put"
    case DELETE = "delete"
    case HEAD = "head"
}

public enum HttpStatus
{
    case Sucess
    case Error
    case Unknown
    case Unreachable
}

public enum ContentType: String
{
    case ApplicationJSON = "application/json"
}