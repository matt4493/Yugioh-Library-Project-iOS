//
//  Level.swift
//  Yugioh Library
//
//  Created by Matthew White on 1/1/16.
//  Copyright © 2016 CybertechApps. All rights reserved.
//

import Foundation

class Level {
    
    var level : String?
    
    class var sharedInstance : Level {
        struct Static {
            static let instance : Level = Level()
        }
        return Static.instance
    }
    
    var returnedLevel : String? {
        get{
            return self.level
        }
        
        set {
            self.level = newValue
        }
    }
}