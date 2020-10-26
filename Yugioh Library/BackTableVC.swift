//
//  BackTableVC.swift
//  Yugioh Library
//
//  Created by Matthew White on 9/30/15.
//  Copyright (c) 2015 CybertechApps. All rights reserved.
//

import Foundation

class BackTableVC: UITableViewController  {
    
    var TableArray = [String]()
    
    override func viewDidLoad() {
        TableArray = ["Simple Search","Advance Search", "Banlist", "About YGO Library"]
        
        tableView.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableArray[indexPath.row], for: indexPath)
        
        cell.textLabel?.text = TableArray[indexPath.row]
        cell.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0)
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("You selected cell number: \(indexPath.row)!")
        
        
        if indexPath.row == 3 {
            
            var about_message:String = ""
            
            about_message = "This app was made for just YGO fans and YGO fans only\r\n\n " +
                
                "I made this app because there is no other app like it on the App Store.\r\n The few that are on the App Store are either out-dated or very poorly designed with no concern with the user experience.\r\n\n " +
                
                "Thanks for buying the app. Please spread the word so this will be the best and only real YGO app on the store " +
                
                "This app has a 7k+ database of cards, a banlist, and calculator.\r\n\n " +
                
                "* Simple Search: This search method allows for quick searching by allowing you to choose a specific YGO series, and displaying the list of booster packs, decks, etc from that series.\r\n\n " +
                
                "* Advance Search: This search method allows you to search using more specific criteria such as name, level, card type, atk/def, descriptions, and more. You can also select a booster pack or deck to search, using those specified criteria\r\n\n " +
                
            "* Banlist: This allows you to see a list of each specific portion of the Banlist, which lists all of the respective cards in their respective section, using a cool tab bar navigation.\r\n\n" +
                
            "" +
            
            "Copyright Infringement notice. This app is in no way associated or affilliated with the creators of the YGO trading card game. It belongs solely to them. I'm just a big fan and want to make an easy-to-use but very useful YGO app for all players and fans. This can be very useful in tournaments.\r\n\n I've noticed for years there have been tons of YGO apps on the App Store and Google Play Store, so i just wanted to make the best one out there, using the mind of a player."
            
            let alertController = UIAlertController(title: "About YGO Library", message:
                about_message, preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,
                handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
}
