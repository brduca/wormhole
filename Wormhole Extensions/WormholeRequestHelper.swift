//
//  HttpHelper.swift
//  Wormhole Kit Framework
//
//  Created by Salvador Mósca on 05/05/16.
//  Copyright © 2016 Salvador Mósca. All rights reserved.
//

import Foundation

extension NSMutableURLRequest
{
    convenience init(url: Url, dataObj: NSData?, headers: Dictionary<String, String>?)
    {
        self.init()
        
        setUrl(url.route.route, params: url.queryStringParams)
        setMethod(url.route.method)
        appendHeaders(headers)
        appendBody(dataObj)
        setTimeout(GlobalServiceSettings.serviceTimeout)
    }
    
    func setUrl(route:String, params: NSDictionary?)
    {
        var route = route
        self.URL = NSURL(string: route.appendQueryString(params))!
    }
    
    func setMethod(method: HttpMethods)
    {
        self.HTTPMethod = method.rawValue
    }
    
    func setTimeout(timeout: Double)
    {
        self.timeoutInterval = timeout
    }
    
    func appendHeaders(headers: Dictionary<String, String>?)
    {
        if !headers.exists {return}
        
        for (key, value) in headers!
        {
            self.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    func appendBody(dataObj: NSData?)
    {
        if !dataObj.exists { return }
        self.HTTPBody = dataObj
    }
}
