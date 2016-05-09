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
    static let create = Routes(route: "baseRouteExample", method: HttpMethods.GET)
}

protocol ServiceProtocol
{
    var route: Routes {get set}
}

extension ServiceProtocol
{
    init()
    {
        self.init()
    }
}

struct Service<T:ServiceProtocol>
{
    func build(params params:NSDictionary? = nil) -> RequestHandler
    {
        let url : Url = Url(route: T().route, queryStringParams: params)
        let request = url.buildRequest()
        return RequestHandler(request:request)
    }
}