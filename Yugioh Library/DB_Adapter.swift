//
//  DB_Adapter.swift
//  Yugioh Library
//
//  Created by Matthew White on 10/23/15.
//  Copyright © 2015 CybertechApps. All rights reserved.
//

import Foundation

let sharedInstance = DB_Adapter()

class DB_Adapter: NSObject {
    
    var database: FMDatabase? = nil
    
    class func getInstance() -> DB_Adapter
    {
        if(sharedInstance.database == nil)
        {
            sharedInstance.database = FMDatabase(path: Util.getPath("yugiohdb.jet"))
        }
        return sharedInstance
    }
    
}