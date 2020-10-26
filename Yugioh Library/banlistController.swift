//
//  banlistController.swift
//  Yugioh Library
//
//  Created by Matthew White on 10/8/15.
//  Copyright (c) 2015 CybertechApps. All rights reserved.
//

import UIKit

class banlistController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}