//
//  DeviceModel.swift
//  Yugioh Library
//
//  Created by matt on 5/13/16.
//  Copyright © 2016 CybertechApps. All rights reserved.
//

import Foundation
import UIKit

private let DeviceList = [
    /* 3.5" iPhone 4S */
    "iPhone4,1": "3.5",
    
    /* 4" iPhone 5 */
    "iPhone5,1": "4.0", "iPhone5,2": "4.0",
    
    /* 4" iPhone 5C */
    "iPhone5,3": "4.0", "iPhone5,4": "4.0",
    
    /* 4" iPhone 5S */
    "iPhone6,1": "4.0", "iPhone6,2": "4.0",
    
    /* 4" iPhone SE */
    "iPhone8,4": "4.0",
    
    /* 4" iPod 5th Gen */
    "iPod5,1": "4.0",
    
    /* 4" iPod 6th Gen */
    "iPod7,1": "4.0",
    
    /* 4.7" iPhone 6 */
    "iPhone7,2": "4.7",
    
    /* 4.7" iPhone 6s */
    "iPhone8,1": "4.7",
    
    /* 5.5" iPhone 6 Plus */
    "iPhone7,1": "5.5",
    
    /* 5.5" iPhone 6s Plus */
    "iPhone8,2": "5.5",
    
    /**/
    "": "",
    
    /* 7.9" iPad Mini */
    "iPad2,5": "7.9", "iPad2,6": "7.9", "iPad2,7": "7.9",
    
    /* 7.9" iPad Mini 2 */
    "iPad4,4": "7.9", "iPad4,5": "7.9", "iPad4,6": "7.9",
    
    /* 7.9" iPad Mini 3 */
    "iPad4,7": "7.9", "iPad4,8": "7.9", "iPad4,9": "7.9",
    
    /* 7.9" iPad Mini 4 */
    "iPad5,1": "7.9", "iPad5,2": "7.9",
    
    /* 9.7" iPad 2 */
    "iPad2,1": "9.7", "iPad2,2": "9.7", "iPad2,3": "9.7", "iPad2,4": "9.7",
    
    /* 9.7" iPad 3 */
    "iPad3,1": "9.7", "iPad3,2": "9.7", "iPad3,3": "9.7",
    
    /* 9.7" iPad 4 */
    "iPad3,4": "9.7", "iPad3,5": "9.7", "iPad3,6": "9.7",
    
    /* 9.7" iPad Air */
    "iPad4,1": "9.7", "iPad4,2": "9.7", "iPad4,3": "9.7",
    
    /* 9.7" iPad Air 2 */
    "iPad5,3": "9.7", "iPad5,4": "9.7",
    
    /* 9.7"  iPod Pro */
    "iPad6,3": "9.7", "iPad6,4": "9.7",
    
    /* 12.9" iPod Pro */
    "iPad6,7": "12.9", "iPod6,8": "12.9",
    
    /* Simulator */
    "x86_64": "Simulator", "i386": "Simulator"
]

public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machine = systemInfo.machine
        let mirror = Mirror(reflecting: machine)  // Swift 2.0
        var identifier = ""
        
        
        // Swift 2.0 and later - if you use Swift 2.0 uncomment his loop
        for child in mirror.children where child.value as? Int8 != 0 {
            identifier.append(String(UnicodeScalar(UInt8(child.value as! Int8))))
         }
        
        print("\(identifier)")
        
        return DeviceList[identifier] ?? identifier
    }
}
