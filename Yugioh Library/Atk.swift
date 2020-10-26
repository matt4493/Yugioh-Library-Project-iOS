//
//  Atk.swift
//  Yugioh Library
//
//  Created by Matthew White on 1/1/16.
//  Copyright © 2016 CybertechApps. All rights reserved.
//

import Foundation

class Atk {
    
    var atk : String?
    
    class var sharedInstance : Atk {
        struct Static {
            static let instance : Atk = Atk()
        }
        return Static.instance
    }
    
    var returnedAtk : String? {
        get{
            return self.atk
        }
        
        set {
            self.atk = newValue
        }
    }
}