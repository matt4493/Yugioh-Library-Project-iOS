//
//  SetNumber.swift
//  Yugioh Library
//
//  Created by Matthew White on 1/1/16.
//  Copyright © 2016 CybertechApps. All rights reserved.
//

import Foundation

class SetNumber {
    
    var setNumber : String?
    
    class var sharedInstance : SetNumber {
        struct Static {
            static let instance : SetNumber = SetNumber()
        }
        return Static.instance
    }
    
    var returnedSetNumber : String? {
        get{
            return self.setNumber
        }
        
        set {
            self.setNumber = newValue
        }
    }
}