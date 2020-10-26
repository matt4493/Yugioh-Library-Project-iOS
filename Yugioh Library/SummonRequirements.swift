//
//  SummonRequirements.swift
//  Yugioh Library
//
//  Created by Matthew White on 1/1/16.
//  Copyright © 2016 CybertechApps. All rights reserved.
//

import Foundation

class SummonRequirements {
    
    var summonRequirements : String?
    
    class var sharedInstance : SummonRequirements {
        struct Static {
            static let instance : SummonRequirements = SummonRequirements()
        }
        return Static.instance
    }
    
    var returnedSummonRequirements : String? {
        get{
            return self.summonRequirements
        }
        
        set {
            self.summonRequirements = newValue
        }
    }
}