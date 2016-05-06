//
//  Serializable.swift
//  Wormhole Kit Framework
//
//  Created by Salvador Mósca on 06/05/16.
//  Copyright © 2016 Salvador Mósca. All rights reserved.
//

import Foundation

protocol Serializable
{
    func toJson() -> NSData!
    
    func toJsonString() -> NSString!
}

public class Serialize: NSObject, Serializable {
    
    private func toDictionary() -> NSDictionary {
        
        let aClass: AnyClass? = self.dynamicType
        var propertiesCount: CUnsignedInt = 0
        let propertiesInAClass: UnsafeMutablePointer<objc_property_t> = class_copyPropertyList(aClass, &propertiesCount)
        let propertiesDictionary: NSMutableDictionary = NSMutableDictionary()
        
        for i in 0 ..< Int(propertiesCount) {
            
            let property = propertiesInAClass[i]
            let propName = NSString(CString: property_getName(property), encoding: NSUTF8StringEncoding)!
            let propValue: AnyObject! = self.valueForKey(propName as String);
            
            if propValue is Serializable {
                propertiesDictionary.setValue((propValue as! Serialize).toDictionary(), forKey: propName as String)
            } else if propValue is Array<Serializable> {
                var subArray = Array<NSDictionary>()
                for item in (propValue as! Array<Serialize>) {
                    subArray.append(item.toDictionary())
                }
                propertiesDictionary.setValue(subArray, forKey: propName as String)
            } else if propValue is NSData {
                propertiesDictionary.setValue((propValue as! NSData).base64EncodedStringWithOptions([]), forKey: propName as String)
            } else if propValue is Int {
                propertiesDictionary.setValue(propValue, forKey: propName as String)
                
            } else if propValue is Bool {
                propertiesDictionary.setValue((propValue as! Bool).boolValue, forKey: propName as String)
                
            } else {
                propertiesDictionary.setValue(propValue, forKey: propName as String)
            }
            
        }
        
        propertiesInAClass.dealloc(Int(propertiesCount))
        
        return propertiesDictionary
    }
    
    public func toJson() -> NSData! {
        let dictionary = self.toDictionary()
        do {
            return try NSJSONSerialization.dataWithJSONObject(dictionary, options: NSJSONWritingOptions(rawValue: 0))
        } catch _ {
            return nil
        }
    }
    
    public func toJsonString() -> NSString! {
        return NSString(data: self.toJson(), encoding: NSUTF8StringEncoding)
    }
    
}