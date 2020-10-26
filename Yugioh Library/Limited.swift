//
//  Forbidden.swift
//  IOS8SwiftTabBarControllerTutorial
//
//  Created by Matthew White on 10/8/15.
//  Copyright (c) 2015 Arthur Knopper. All rights reserved.
//

import UIKit
import Foundation
import Haneke
import Kingfisher

class Limited: UITableViewController {
    
    var cards = [[String]]()
    var check_CardDetails_Segue = true
    let CardAdapter_Object = Card_Adapter()
    var card_image_url = ""
    
    var placeholderImage = UIImage(imageLiteral: "ic_error")
    
    @IBOutlet weak var mainButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        cards = [
            // Normal monsters:
            ["Left Arm of the Forbidden One",""],
            ["Left Leg of the Forbidden One", ""],
            ["Right Arm of the Forbidden One", ""],
            ["Right Leg of the Forbidden One", ""],
            ["Qliphort Scout", ""],
            
            // Effect monsters:
            ["Artifact Moralltach", "Effect"],
            ["Black Luster Soldier  Envoy of the Beginning", "Effect"],
            ["Dandylion", "Effect"],
            ["Dark Armed Dragon", "Effect"],
            ["Deep Sea Diva", "Effect"],
            ["Exodia the Forbidden One", "Effect"],
            ["Genex Ally Birdman", "Effect"],
            ["Graff, Malebranche of the Burning Abyss", "Effect"],
            ["Infernity Archfiend", "Effect"],
            ["Inzektor Dragonfly", "Effect"],
            ["Inzektor Hornet", "Effect"],
            ["Luster Pendulum, The Dracoslayer", "Effect"],
            ["Mathematician", "Effect"],
            ["Neo Spacian Grand Mole", "Effect"],
            ["Night Assailant", "Effect"],
            ["Performapal Monkeyboard", "Effect"],
            ["Performapal Skullcrobat Joker", "Effect"],
            ["Red Eyes Darkness Metal Dragon", "Effect"],
            ["Rescue Rabbit", "Effect"],
            ["Thunder King Rai-Oh", "Effect"],
            ["Tour Guide from the Underworld", "Effect"],
            ["Wind Up Magician", "Effect"],
            ["Wisdom Eye Magician", "Effect"],
            
            // Ritual monsters:
            ["Evigishki Gustkraken", "Ritual"],
            ["Evigishki Mind Augus", "Ritual"],
            ["Nekroz of Brionic", "Ritual"],
            ["Nekroz of Unicore", "Ritual"],
            
            // Fusion monsters:
            ["Elder Entity Norden", "Fusion"],
            ["Ritual Beast Ulti Cannahawk", "Fusion"],
            ["Thousand Eyes Restrict", "Fusion"],
            
            // Synchro monsters:
            ["Dewloren, Tiger King of the Ice Barrier", "Synchro"],
            ["Ignister Prominence, the Blasting Dracoslayer", "Synchro"],
            ["Trishula, Dragon of the Ice Barrier", "Synchro"],
            ["T.G. Hyper Librarian", "Synchro"],
            
            // Spell cards:
            ["Book of Moon", "Spell Card"],
            ["Burial from a Different Dimension", "Spell Card"],
            ["Dimensional Fissure", "Spell Card"],
            ["Divine Wind of Mist Valley", "Spell Card"],
            ["Draco Face Off", "Spell Card"],
            ["El Shaddoll Fusion", "Spell Card"],
            ["Final Countdown", "Spell Card"],
            ["Foolish Burial", "Spell Card"],
            ["Gold Sarcophagus", "Spell Card"],
            ["Infernity Launcher", "Spell Card"],
            ["Limiter Removal", "Spell Card"],
            ["Mind Control", "Spell Card"],
            ["Monster Gate", "Spell Card"],
            ["One Day of Peace", "Spell Card"],
            ["One for One", "Spell Card"],
            ["Preparation of Rites", "Spell Card"],
            ["Raigeki", "Spell Card"],
            ["Reasoning", "Spell Card"],
            ["Reinforcement of the Army", "Spell Card"],
            ["Rekindling", "Spell Card"],
            ["Royal Tribute", "Spell Card"],
            ["Saqlifice", "Spell Card"],
            ["Soul Charge", "Spell Card"],
            ["Symbol of Heritage", "Spell Card"],
            ["Upstart Golbin", "Spell Card"],
            
            // Trap Cards:
            ["Bottomless Trap Hole", "Trap Card"],
            ["Compulsory Evacuation Device", "Trap Card"],
            ["Eradicator Epidemic Virus", "Trap Card"],
            ["Infernity Barrier", "Trap Card"],
            ["Macro Cosmos", "Trap Card"],
            ["Magical Explosion", "Trap Card"],
            ["Ring of Destrution", "Trap Card"],
            ["Skill Drain", "Trap Card"],
            ["Solemn Warning", "Trap Card"],
            ["Soul Drain", "Trap Card"],
            ["Torrential Tribute", "Trap Card"],
            ["Vanity's Emptiness", "Trap Card"],
            ["Wall of Revealing Light", "Trap Card"]
        ]
        
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        tableView.contentInset = UIEdgeInsetsMake(statusBarHeight, 0.0, 0.0, 0.0)
        
        if revealViewController() != nil {
            //            revealViewController().rearViewRevealWidth = 62
            mainButton.target = revealViewController()
            mainButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        cards.sort{
            if $0[1] != $1[1] {
                return $0[1] < $1[1]
            }
            else {
                //last names are the same, break ties by first name
                return $0[0] < $1[0]
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return cards.count
    }
    
    override func tableView(_ tableView: UITableView!, didSelectRowAt indexPath: IndexPath) {
        
        //let card_name:CardInfo_Adapter = returnedCardNames[indexPath.row][0] as! CardInfo_Adapter
        
        let card_name = cards[indexPath.row][0]
        
        self.CollectDetails(card_name)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CardInfo_Cell_aboutBanlist = tableView.dequeueReusableCell(withIdentifier: "limitedCell") as! CardInfo_Cell_aboutBanlist
        // Configure the cell...
        
        var card_name = cards[indexPath.row][0]
        var card_type = cards[indexPath.row][1]
        
        cell.card_nameLabel.text = cards[indexPath.row][0]
        cell.tag = indexPath.row
        cell.card_nameLabel.textColor = UIColor.black
        
        Simple_Search.process_AND_return_card_URLS(card_name) {
            returnedURL in
            self.card_image_url = returnedURL
            
            //print("FUNC = \(card_image_url)")
            var check_comma = self.card_image_url.replacingOccurrences(of: "%252C", with: "%2C")
            let check_special = check_comma.replacingOccurrences(of: "", with: "")
            let check_doubleAPOST = check_special.replacingOccurrences(of: "%27%27", with: "_")
            var check_apost = check_doubleAPOST.replacingOccurrences(of: "%27", with: "'")
            var final_URL = check_apost
            
            //print("Apost Replaced = \(check_apost)")
            
            let cache = Shared.imageCache
            
            
            //check_apost = check_apost.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
            //print("Encoded URL = \(check_apost)")
            let finished_URL = URL(string: final_URL)
            
            
            /*var image2 = KingfisherManager.sharedManager.retrieveImageWithURL(check_apost, optionsInfo: .None, progressBlock: nil), completionHandler: { imageURL in
             print("\(card_name): Finished")
             })*/
            
            // Kingfisher image fetching
            if ImageCache.defaultCache.cachedImageExistsforURL(finished_URL!) == true {
                //print("image is already cached.")
                
                if cell.tag == indexPath.row{
                    cell.card_imageIV.image = UIImage(imageLiteral: "ic_error")
                    KingfisherManager.sharedManager.retrieveImageWithURL(finished_URL!, optionsInfo: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
                        cell.card_imageIV.image = image
                        //print("Retrieved cached image")
                    })
                }
                
            }else{
                if cell.tag == indexPath.row{
                    cell.card_imageIV.kf_setImageWithURL(finished_URL!, placeholderImage: self.placeholderImage, optionsInfo: nil, completionHandler: { image, error, cacheType, imageURL in
                        //print("\(card_name): Finished")
                    })
                }
                
            }
            
            
            
            // haneke - Retrieve images from network & cache
            /*let fetcher_net = NetworkFetcher<UIImage>(URL: finished_URL!)
             let fetcher_disk = DiskFetcher<UIImage>(path: check_apost)
             cache.fetch(fetcher: fetcher_disk).onSuccess { image in
             //cell.card_imageIV.hnk_fetcher.cancelFetch()
             //print("Image Cache found")
                if cell.tag == indexPath.row{
                    cell.card_imageIV.image = image
                }
             }.onFailure{ image in
             //print("Unavailable to find image cache, fetching from network")
             cache.fetch(fetcher: fetcher_net).onSuccess { image in
             //print("Network image request SUCCESS")
                if cell.tag == indexPath.row{
                    cell.card_imageIV.image = image
                }
             }
             }*/
            
            
            //cell.card_imageIV.hnk_setImageFromURL(finished_URL!)
        }
        
        print("Card Name: \(card_name), Card Type: \(card_type)")
        if cell.tag == indexPath.row {
            if card_type.contains("Synchro") == true {
                cell.backgroundColor = hexStringToUIColor("#CCCCCC")
                //print("Synchro COLOR")
            }else if card_type.contains("Fusion") == true {
                cell.backgroundColor = hexStringToUIColor("#a086b7")
                //print("Fusion COLOR")
            }
            else if card_type.contains("Xyz") == true {
                cell.card_nameLabel.textColor = UIColor.white
                cell.backgroundColor = UIColor.black
                // print("Xyz COLOR")
            }
            else if card_type.contains("Ritual Spell Card") == true {
                cell.backgroundColor = hexStringToUIColor("#1d9e74")
                //let cache = Shared.imageCache
                //let url = NSURL(string: "http://vignette1.wikia.nocookie.net/yugioh/images/f/fd/BeastlyMirrorRitual-PRC1-EN-SR-1E.png")!
                //cell.card_imageIV.hnk_setImageFromURL(url)
                //print("Ritual Spell Card COLOR")
            }
            else if card_type.contains("Ritual") == true {
                cell.backgroundColor = hexStringToUIColor("#9DB5CC")
                // print("Ritual COLOR")
            }
            else if card_type.contains("Spell Card") == true {
                cell.backgroundColor = hexStringToUIColor("#1d9e74")
                //print("Spell Card COLOR")
            }
            else if card_type.contains("Trap Card") == true {
                cell.backgroundColor = hexStringToUIColor("#BC5A84")
                //print("Trap Card COLOR")
            }
            else if card_type.contains("Effect"){
                cell.backgroundColor = hexStringToUIColor("#FF8B53")
                //print("Effect COLOR")
            }else{
                cell.backgroundColor = hexStringToUIColor("#FDE68A")
                //print("Maybe NORMAL COLOR")
            }
            
        }
        
        return cell
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        if identifier == "card_details"{
            if check_CardDetails_Segue == true{
                print("Segue test 1")
                return true
                
            }else{
                print("Segue test 2")
                return false
                
            }
        }else{
            print("Segue test 3")
            return true
        }
        
        return true
    }
    
    func hexStringToUIColor (_ hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = cString.substring(from: cString.characters.index(cString.startIndex, offsetBy: 1))
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func CollectDetails(_ passedCardName: String){
        var passedCardName = passedCardName
        // Collect Card Details
        
        CardName.sharedInstance.returnedcardName = CardAdapter_Object.getCardName(passedCardName, match_type: "exact")
        Type.sharedInstance.returnedType = CardAdapter_Object.getType(passedCardName, match_type: "exact")
        Attribute.sharedInstance.returnedAttribute = CardAdapter_Object.getAttribute(passedCardName, match_type: "exact")
        SummonRequirements.sharedInstance.returnedSummonRequirements = CardAdapter_Object.getSummonRequirements(passedCardName, match_type: "exact")
        Description.sharedInstance.returnedDescription = CardAdapter_Object.getDescription(passedCardName, match_type: "exact")
        SpellSpeed.sharedInstance.returnedSpellSpeed = CardAdapter_Object.getSpellSpeed(passedCardName, match_type: "exact")
        Level.sharedInstance.returnedLevel = CardAdapter_Object.getLevel(passedCardName, match_type: "exact")
        Rank.sharedInstance.returnedRank = CardAdapter_Object.getRank(passedCardName, match_type: "exact")
        Atk.sharedInstance.returnedAtk = CardAdapter_Object.getAtk(passedCardName, match_type: "exact")
        Def.sharedInstance.returnedDef = CardAdapter_Object.getDef(passedCardName, match_type: "exact")
        Setini.sharedInstance.returnedSetini = CardAdapter_Object.getSetini(passedCardName, match_type: "exact")
        SetNumber.sharedInstance.returnedSetNumber = CardAdapter_Object.getSetNumber(passedCardName, match_type: "exact")
        CardPass.sharedInstance.returnedCardPass = CardAdapter_Object.getCardPass(passedCardName, match_type: "exact")
        Rarity.sharedInstance.returnedRarity = CardAdapter_Object.getRarity(passedCardName, match_type: "exact")
        Legality.sharedInstance.returnedLegality = CardAdapter_Object.getLegality(passedCardName, match_type: "exact")
        
        var check_CardName = CardName.sharedInstance.returnedcardName
        var check_Type = Type.sharedInstance.returnedType
        var check_Attribute = Attribute.sharedInstance.returnedAttribute
        var check_SummonRequirements = SummonRequirements.sharedInstance.returnedSummonRequirements
        var check_Description = Description.sharedInstance.returnedDescription
        var check_SpellSpeed = SpellSpeed.sharedInstance.returnedSpellSpeed
        var check_Level = Level.sharedInstance.returnedLevel
        var check_Rank = Rank.sharedInstance.returnedRank
        var check_Atk = Atk.sharedInstance.returnedAtk
        var check_Def = Def.sharedInstance.returnedDef
        var check_Setini = Setini.sharedInstance.returnedSetini
        var check_SetNumber = SetNumber.sharedInstance.returnedSetNumber
        var check_CardPass = CardPass.sharedInstance.returnedCardPass
        var check_Rarity = Rarity.sharedInstance.returnedRarity
        var check_Legality = Legality.sharedInstance.returnedLegality
        
        if check_CardName != nil && check_Type != "" && check_Attribute != nil && check_SummonRequirements != nil && check_Description != nil && check_SpellSpeed != nil && check_Level != nil && check_Rank != nil && check_Atk != nil && check_Def != nil && check_Setini != nil && check_SetNumber != nil && check_CardPass != nil && check_Rarity != nil && check_Legality != nil {
            
            //self.performSegueWithIdentifier("card_details", sender: self)
            self.Check_CardDetails_Segue(1)
            
        }else{
            let alertController = UIAlertController(title: "Card details could not be loaded.", message:
                "There was an error retrieving a type of data for the selected card. Please report this to me by hitting the Report button. In the meantime, try selecting different cards to isolate if it's an issue with just this one card or a few, and not all.", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,
                handler: nil))
            
            self.Check_CardDetails_Segue(0)
            
            self.present(alertController, animated: true, completion: nil)        }
        
        print("Finished setting instances")
    }
    
    func Check_CardDetails_Segue(_ passedTRUEFALSE_Value: Int) {
        
        if passedTRUEFALSE_Value == 1{
            check_CardDetails_Segue = true
        }else{
            check_CardDetails_Segue = false
        }
        
        
    }
    
    class func process_AND_return_card_URLS(_ passed_CardName: String, completionHandler: @escaping (_ returnedURL: String) -> ()) {
        
        let replace_spaces = passed_CardName.replacingOccurrences(of: " ", with: "+", options: NSString.CompareOptions.literal, range: nil)
        //let replace_special_characters = replace_spaces.stringByReplacingOccurrencesOfString("%C3%9C", withString: "Ü")
        if passed_CardName.contains("Beast Machine King"){
            completionHandler("http://static.api3.studiobebop.net/ygo_data/card_images/Beast_Machine_King_Barbaros_Ür.jpg")
        }else {
            let url = URL(string: "http://yugiohprices.com/api/card_image/" + "\(replace_spaces)")
            //print("http://yugiohprices.com/api/card_image/\(replace_spaces)")
            
            let request = NSMutableURLRequest(url: url!)
            var card_image_url = ""
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error in
                if let response = response, let data = data {
                    //print(response)
                    //print("Response URL = " + response.URL!.absoluteString)
                    
                    completionHandler(returnedURL: response.URL!.absoluteString)
                } else {
                    print(error)
                }
            }) 
            
            task.resume()
        }
        
    }
}
