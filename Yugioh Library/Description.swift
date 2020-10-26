//
//  Description.swift
//  Yugioh Library
//
//  Created by Matthew White on 1/1/16.
//  Copyright © 2016 CybertechApps. All rights reserved.
//

import Foundation

class Description {
    
    
    var description : String?
    
    class var sharedInstance : Description {
        struct Static {
            static let instance : Description = Description()
        }
        return Static.instance
    }
    
    var returnedDescription : String? {
        get{
            return self.description
        }
        
        set {
            self.description = newValue
            
        }
    }
}