//
//  Rarity.swift
//  Yugioh Library
//
//  Created by Matthew White on 1/1/16.
//  Copyright © 2016 CybertechApps. All rights reserved.
//

import Foundation

class Rarity {
    
    var rarity: String?
    
    class var sharedInstance : Rarity {
        struct Static {
            static let instance : Rarity = Rarity()
        }
        return Static.instance
    }
    
    var returnedRarity : String? {
        get{
            return self.rarity
        }
        
        set {
            self.rarity = newValue
        }
    }
}