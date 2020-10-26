//
//  setini.swift
//  Yugioh Library
//
//  Created by Matthew White on 1/1/16.
//  Copyright © 2016 CybertechApps. All rights reserved.
//

import Foundation

class Setini {
    
    var setini : String?
    
    class var sharedInstance : Setini {
        struct Static {
            static let instance : Setini = Setini()
        }
        return Static.instance
    }
    
    var returnedSetini : String? {
        get{
            return self.setini
        }
        
        set {
            self.setini = newValue
        }
    }
}