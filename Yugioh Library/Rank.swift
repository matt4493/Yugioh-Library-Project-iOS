//
//  Rank.swift
//  Yugioh Library
//
//  Created by Matthew White on 1/1/16.
//  Copyright © 2016 CybertechApps. All rights reserved.
//

import Foundation

class Rank {
    
    var rank : String?
    
    class var sharedInstance : Rank {
        struct Static {
            static let instance : Rank = Rank()
        }
        return Static.instance
    }
    
    var returnedRank : String? {
        get{
            return self.rank
        }
        
        set {
            self.rank = newValue
        }
    }
}