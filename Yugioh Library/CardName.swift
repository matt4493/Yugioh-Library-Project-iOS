//
//  CardName.swift
//  Yugioh Library
//
//  Created by Matthew White on 1/5/16.
//  Copyright © 2016 CybertechApps. All rights reserved.
//

import Foundation

class CardName {
    
    var name : String?
    
    class var sharedInstance : CardName {
        struct Static {
            static let instance : CardName = CardName()
        }
        return Static.instance
    }
    
    var returnedcardName : String? {
        get{
            return self.name
        }
        
        set {
            self.name = newValue
        }
    }
}