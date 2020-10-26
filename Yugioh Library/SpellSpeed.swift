//
//  SpellSpeed.swift
//  Yugioh Library
//
//  Created by Matthew White on 1/1/16.
//  Copyright © 2016 CybertechApps. All rights reserved.
//

import Foundation

class SpellSpeed {
    
    var spellSpeed : String?
    
    class var sharedInstance : SpellSpeed {
        struct Static {
            static let instance : SpellSpeed = SpellSpeed()
        }
        return Static.instance
    }
    
    var returnedSpellSpeed : String? {
        get{
            return self.spellSpeed
        }
        
        set {
            self.spellSpeed = newValue
        }
    }
}