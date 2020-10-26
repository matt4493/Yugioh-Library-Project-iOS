//
//  Attribute.swift
//  Yugioh Library
//
//  Created by Matthew White on 1/1/16.
//  Copyright © 2016 CybertechApps. All rights reserved.
//

import Foundation

class Attribute {
    
    var attribute : String?
    
    class var sharedInstance : Attribute {
        struct Static {
            static let instance : Attribute = Attribute()
        }
        return Static.instance
    }
    
    var returnedAttribute : String? {
        get{
            return self.attribute
        }
        
        set {
            self.attribute = newValue
        }
    }
}