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
    convenience init(route: Routes, dataObj: NSData?, headers: Dictionary<String, String>?, timeout: Double? = 60)
    {
        self.init()
        
        setUrl(route.url)
        setMethod(route.method)
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
    
    func setUrl(url:String)
    {
        self.URL = NSURL(string: url)!
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
        if headers?.count > 0 {return}
        
        for (key, value) in headers!
        {
            self.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    func appendBody(dataObj: NSData?)
    {
        if dataObj == nil { return }
        self.HTTPBody = dataObj
    }
}
