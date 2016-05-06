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
    convenience init(url: Url, dataObj: NSData?, headers: Dictionary<String, String>?, timeout: Double? = 60)
    {
        self.init()
        
        setUrl(url.route.route, params: url.queryStringParams)
        setMethod(url.route.method)
        appendHeaders(headers)
        appendBody(dataObj)
        setTimeout(timeout!)
    }
    
    func continueWith(genericHandler: GenericResponseHandler) -> NSURLSessionTask
    {
        return self.createProcess(genericHandler.genericResponseHandler)
    }
    
    internal func createProcess(responseHandler: (NSData?, NSURLResponse?, NSError?) -> Void) -> NSURLSessionTask
    {
        let urlSession = NSURLSession.sharedSession()
        
        let task = urlSession.dataTaskWithRequest(self){ data, response, error in
            
            responseHandler(data, response, error)
        }
        
       return task
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
