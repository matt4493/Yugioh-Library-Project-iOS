//
//  About YGO Library.swift
//  Yugioh Library
//
//  Created by Matthew White on 10/8/15.
//  Copyright (c) 2015 CybertechApps. All rights reserved.
//

import UIKit

class AboutYGOLibrary: UIViewController {
    
    
    
    
    var about_message:String = ""
    
    @IBAction func buttonTapped(_ sender: AnyObject) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        about_message = "This app was made for just YGO fans and YGO fans only\r\n\n " +
            
        "This app has a 7k+ database of cards, a banlist, and calculator.\r\n\n " +
            
        "* Simple Search: This search method allows for quick searching by allowing you to choose a specific Yu-Gi-Oh! series, and displaying the list of booster packs, decks, etc from that series.\r\n\n " +
            
        "* Advance Search: This search method allows you to search using more specific criteria such as name, level, card type, atk/def, descriptions, and more. You can also select a booster pack or deck to search, using those specified criteria\r\n\n " +
        
        "* Banlist: This allows you to see a list of each specific portion of the Banlist, which lists all of the respective cards in their respective section, using a cool tab bar navigation."
        
        
        
        let alertController = UIAlertController(title: "About YGO Library", message:
            about_message, preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,
            handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
