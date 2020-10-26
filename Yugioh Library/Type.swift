//
//  Type.swift
//  Yugioh Library
//
//  Created by Matthew White on 1/1/16.
//  Copyright © 2016 CybertechApps. All rights reserved.
//

import Foundation

class Type {
    
    var type : String = ""
    
    class var sharedInstance : Type {
        struct Static {
            static let instance : Type = Type()
        }
        return Static.instance
    }
    
    var returnedType : String {
        get{
            return self.type
        }
        
        set {
            self.type = newValue
        }
    }
}