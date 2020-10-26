//
//  Def.swift
//  Yugioh Library
//
//  Created by Matthew White on 1/1/16.
//  Copyright © 2016 CybertechApps. All rights reserved.
//

import Foundation

class Def {
    
    var def : String?
    
    class var sharedInstance : Def {
        struct Static {
            static let instance : Def = Def()
        }
        return Static.instance
    }
    
    var returnedDef : String? {
        get{
            return self.def
        }
        
        set {
            self.def = newValue
        }
    }
}