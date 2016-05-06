//
//  RequestDtoProtocol.swift
//  Wormhole Kit Framework
//
//  Created by Salvador Mósca on 05/05/16.
//  Copyright © 2016 Salvador Mósca. All rights reserved.
//

import Foundation
import UIKit

extension Url
{
    func createRequest(withData data: NSData? = nil) -> GenericResponseHandler
    {
        let handler = GenericResponseHandler()
        NSMutableURLRequest(url: self, dataObj: data, headers: nil).continueWith(handler)
        return handler
    }
}
