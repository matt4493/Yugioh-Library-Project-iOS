//
//  Singleton.swift
//  Yugioh Library
//
//  Created by Matthew White on 12/21/15.
//  Copyright © 2015 CybertechApps. All rights reserved.
//

import Foundation

class Singleton {
    
    var name = [[String]]()
    
    class var sharedInstance : Singleton {
        struct Static {
            static let instance : Singleton = Singleton()
        }
        return Static.instance
    }
    
    var returnedCardNames : [[String]] {
        get{
            return self.name
        }
        
        set {
            self.name = newValue
        }
    }
}