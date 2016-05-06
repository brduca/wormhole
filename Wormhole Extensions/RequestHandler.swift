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

class GenericResponseHandler
{
    private var sucess: successCompletionHandler?
    private var fail: failCompletionHandler?
    private var always: alwaysCompletionHandler?
    
    func genericResponseHandler(data: NSData?, response: NSURLResponse?, error: NSError?)
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

extension GenericResponseHandler
{
    func success(handler: successCompletionHandler) -> GenericResponseHandler
    {
        self.sucess = handler
        return self
    }
    
    func fail(handler: failCompletionHandler) -> GenericResponseHandler
    {
        self.fail = handler
        return self
    }

    func always(handler: alwaysCompletionHandler) -> GenericResponseHandler
    {
        self.always = handler
        return self
    }
}