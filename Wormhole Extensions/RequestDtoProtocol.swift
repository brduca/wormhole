//
//  RequestDtoProtocol.swift
//  Wormhole Kit Framework
//
//  Created by Salvador Mósca on 05/05/16.
//  Copyright © 2016 Salvador Mósca. All rights reserved.
//

import Foundation
import UIKit

struct Routes
{
    let url: String
    let method: HttpMethods
}

extension Routes
{
    func createRequest() -> GenericResponseHandler
    {
        let handler = GenericResponseHandler()
        NSMutableURLRequest(route: self, dataObj: nil, headers: nil).continueWith(handler)
        return handler
    }
}
