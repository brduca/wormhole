//
//  RequestHandler.swift
//  Wormhole Kit Framework
//
//  Created by Salvador Mósca on 05/05/16.
//  Copyright © 2016 Salvador Mósca. All rights reserved.
//

import Foundation

typealias successCompletionHandler = (NSData?) -> Void
typealias failCompletionHandler = (HttpStatus, String?) -> Void
typealias alwaysCompletionHandler = () -> Void

class RequestHandler
{
    // Response handlers
    private var sucess: successCompletionHandler?
    private var fail: failCompletionHandler?
    private var always: alwaysCompletionHandler?
    
    private var request: NSURLRequest!
    
    init(request: NSURLRequest)
    {
        self.request = request
    }
    
    func call()
    {
        createProcess().resume()
    }
    
    private func createProcess() -> NSURLSessionTask
    {
        let urlSession = NSURLSession.sharedSession()
        
        let task = urlSession.dataTaskWithRequest(request!){ data, response, error in
            
            self.genericResponseHandler(data, response: response, error: error)
        }
        
        return task
    }
    
    private func genericResponseHandler(data: NSData?, response: NSURLResponse?, error: NSError?)
    {
        dispatch_async(dispatch_get_main_queue())
        {
            if(error.exists)
            {
                if self.fail.exists { self.fail!(HttpStatus.Unknown, "") }
                return
            }
            
            if(response!.isHTTPResponseValid())
            {
                if self.sucess.exists
                {
                    self.sucess!(data)
                }
                return
            }
        }
    }
}

extension RequestHandler
{
    func success(handler: successCompletionHandler) -> RequestHandler
    {
        self.sucess = handler
        return self
    }
    
    func fail(handler: failCompletionHandler) -> RequestHandler
    {
        self.fail = handler
        return self
    }

    func always(handler: alwaysCompletionHandler) -> RequestHandler
    {
        self.always = handler
        return self
    }
}