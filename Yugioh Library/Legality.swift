//
//  Legality.swift
//  Yugioh Library
//
//  Created by Matthew White on 1/1/16.
//  Copyright © 2016 CybertechApps. All rights reserved.
//

import Foundation

class Legality {
    
    var legality : String?
    
    class var sharedInstance : Legality {
        struct Static {
            static let instance : Legality = Legality()
        }
        return Static.instance
    }
    
    var returnedLegality : String? {
        get{
            return self.legality!
        }
        
        set {
            self.legality = newValue
        }
    }
}