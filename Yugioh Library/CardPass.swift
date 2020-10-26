//
//  CardPass.swift
//  Yugioh Library
//
//  Created by Matthew White on 1/1/16.
//  Copyright © 2016 CybertechApps. All rights reserved.
//

import Foundation

class CardPass {
    
    var cardPass : String?
    
    class var sharedInstance : CardPass {
        struct Static {
            static let instance : CardPass = CardPass()
        }
        return Static.instance
    }
    
    var returnedCardPass : String? {
        get{
            return self.cardPass
        }
        
        set {
            self.cardPass = newValue
        }
    }
}