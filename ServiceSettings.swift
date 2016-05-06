//
//  ServiceSettings.swift
//  Wormhole Kit Framework
//
//  Created by Salvador Mósca on 06/05/16.
//  Copyright © 2016 Salvador Mósca. All rights reserved.
//

import Foundation

struct  ServiceSettings
{
    static let create = Routes(route: "", method: HttpMethods.GET)
}

protocol ServiceProtocol
{
    var route: Routes {get set}
}

extension ServiceProtocol
{
    func to(params: NSDictionary? = nil) -> Url
    {
        return Url(route: route, queryStringParams: params)
    }
}