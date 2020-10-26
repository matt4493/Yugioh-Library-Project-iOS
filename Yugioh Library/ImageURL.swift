//
//  ImageURL.swift
//  Yugioh Library
//
//  Created by matt on 4/17/16.
//  Copyright © 2016 CybertechApps. All rights reserved.
//

import Foundation

class ImageURL {
    
    var imageURL : String?
    
    class var sharedInstance : ImageURL {
        struct Static {
            static let instance : ImageURL = ImageURL()
        }
        return Static.instance
    }
    
    var returnedImageURL : String? {
        get{
            return self.imageURL
        }
        
        set {
            self.imageURL = newValue
        }
    }
}
