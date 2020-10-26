//
//  Card_View.swift
//  Yugioh Library
//
//  Created by Matthew White on 12/22/15.
//  Copyright © 2015 CybertechApps. All rights reserved.
//

import Foundation
import Haneke
import UIKit
import Kingfisher

class Card_View: UIViewController {
    
    let card_name_shared = CardName.sharedInstance
    
                    // CARD VIEW variables - BEGIN
    var card_Name = ""
    var card_Type = ""
    var attribute_Type = ""
    var summon_Requirements = ""
    var description_Text = ""
    var spell_Speed_ = ""
    var level_Stars = ""
    var rank_Stars = ""
    var atk_Points = ""
    var def_Points = ""
    var set_Initials = ""
    var set_Number = ""
    var card_Passcode = ""
    var card_Rarity = ""
    var card_Legality = ""
    
    var RarityTextPlaceHolder = "Rarity: "
    var LegalityTextPlaceHolder = "Legality: "
    
    var levels_convertedToNumber = 99
    var ranks_convertedToNumber = 99
    var atk_convertedToNumber = 99
    var def_convertedToNumber = 99
    
    var levelStar_image_fileName = "level2"
    var rankStar_image_fileName = "rank"
    
    var attributeDark_image_fileName = "DARK"
    var attributeDivine_image_fileName = "DIVINE"
    var attributeEarth_image_fileName = "EARTH"
    var attributeFire_image_fileName = "FIRE"
    var attributeLight_image_fileName = "LIGHT"
    var attributeSpell_image_fileName = "SPELL"
    var attributeTrap_image_fileName = "TRAP"
    var attributeWater_image_fileName = "WATER"
    var attributeWind_image_fileName = "WIND"
    
    var card_image_url = ""
    var placeholderImage = UIImage(imageLiteral: "ic_error")
    
                    // CARD VIEW variables - END
    
                    // CARD VIEW Labels & ImageViews - BEGIN
    @IBOutlet weak var cardName_Label: UILabel!
    @IBOutlet weak var cardType_Label: UILabel!
    
    @IBOutlet weak var attribute_IV: UIImageView!
    
    @IBOutlet weak var card_imageIV: UIImageView!
    
    
    @IBOutlet weak var level_rank_1_IV: UIImageView!
    @IBOutlet weak var level_rank_2_IV: UIImageView!
    @IBOutlet weak var level_rank_3_IV: UIImageView!
    @IBOutlet weak var level_rank_4_IV: UIImageView!
    @IBOutlet weak var level_rank_5_IV: UIImageView!
    @IBOutlet weak var level_rank_6_IV: UIImageView!
    @IBOutlet weak var level_rank_7_IV: UIImageView!
    @IBOutlet weak var level_rank_8_IV: UIImageView!
    @IBOutlet weak var level_rank_9_IV: UIImageView!
    @IBOutlet weak var level_rank_10_IV: UIImageView!
    @IBOutlet weak var level_rank_11_IV: UIImageView!
    @IBOutlet weak var level_rank_12_IV: UIImageView!
    
    
    
    @IBOutlet weak var summon_requirements_Label: UITextView!
    
    @IBOutlet weak var description_Label: UITextView!
    //@IBOutlet weak var description_Label: UILabel!
    
    @IBOutlet weak var set_label: UILabel!
    
    @IBOutlet weak var rarity_Label: UILabel!
    
    @IBOutlet weak var legality_Label: UILabel!
    
    @IBOutlet weak var atk_def_Label: UILabel!
    
    @IBOutlet weak var cardPass_Label: UILabel!
    
                    // CARD VIEW Labels & ImageViews - END
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        summon_requirements_Label.isEditable = false
        description_Label.isEditable = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(Card_View.tappedMe))
        card_imageIV.addGestureRecognizer(tap)
        card_imageIV.isUserInteractionEnabled = true
        
        if self.revealViewController() != nil{
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tappedMe()
    {
        print("Tapped on Image")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        if ((CardName.sharedInstance.returnedcardName?.isEmpty) != nil){
            print((CardName.sharedInstance.returnedcardName)! + ": SUCCESSFUL")
            
            card_Name = CardName.sharedInstance.returnedcardName!
            
            print("P1 - \(card_Name)")
            
            self.Retrieve_Passed_Card_Details()
            
            self.Process_Passed_Card_Details(card_Name)
            
            // Retrieve image
            Card_View.process_AND_return_card_URLS(card_Name) {
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
                
                print("URL - Final URL: \(final_URL)")
                
                if ImageCache.defaultCache.cachedImageExistsforURL(finished_URL!) == true {
                    print("image is already cached.")
                    
                    self.card_imageIV.image = UIImage(imageLiteral: "ic_error")
                    KingfisherManager.sharedManager.retrieveImageWithURL(finished_URL!, optionsInfo: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) -> () in
                        self.card_imageIV.image = image
                        print("Retrieved cached image")
                    })
                    
                }else{
                    self.card_imageIV.kf_setImageWithURL(finished_URL!, placeholderImage: self.placeholderImage, optionsInfo: nil, completionHandler: { image, error, cacheType, imageURL in
                        print("\(self.card_Name): Finished")
                    })
                }
                
                // haneke - Retrieve images from network & cache
                /*let fetcher_net = NetworkFetcher<UIImage>(URL: finished_URL!)
                let fetcher_disk = DiskFetcher<UIImage>(path: check_apost)
                cache.fetch(fetcher: fetcher_disk).onSuccess { image in
                    //cell.card_imageIV.hnk_fetcher.cancelFetch()
                    //print("Image Cache found")
                        self.card_imageIV.contentMode = UIViewContentMode.ScaleAspectFit
                        self.card_imageIV.image = image
                    }.onFailure{ image in
                        //print("Unavailable to find image cache, fetching from network")
                        cache.fetch(fetcher: fetcher_net).onSuccess { image in
                            //print("Network image request SUCCESS")
                                self.card_imageIV.contentMode = UIViewContentMode.ScaleAspectFit
                                self.card_imageIV.image = image
                            
                        }
                }*/

                
                //cell.card_imageIV.hnk_setImageFromURL(finished_URL!)
            }
            
            //print("\(card_Name)" + " : Type: \(card_Type)")
            
        }else{
            
            print("Empty")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    func Process_Passed_Card_Details(_ passedCardName: String){
        
        if card_Type.contains("Synchro") == true {
            self.view.backgroundColor = hexStringToUIColor("#CCCCCC")
            description_Label.backgroundColor = hexStringToUIColor("#CCCCCC")
            summon_requirements_Label.backgroundColor = hexStringToUIColor("#CCCCCC")
            print("Synchro COLOR")
        }else if card_Type.contains("Fusion") == true {
            self.view.backgroundColor = hexStringToUIColor("#a086b7")
            description_Label.backgroundColor = hexStringToUIColor("#a086b7")
            summon_requirements_Label.backgroundColor = hexStringToUIColor("#a086b7")
            print("Card Type: \(card_Type): / Fusion COLOR")
        }
        else if card_Type.contains("Xyz") == true {
            self.view.backgroundColor = hexStringToUIColor("#FFFFFF")
            //self.view.backgroundColor = UIColor.blackColor()
            //cardName_Label.textColor = UIColor.whiteColor()
            //cardType_Label.textColor = UIColor.whiteColor()
            //summon_requirements_Label.textColor = UIColor.whiteColor()
            //description_Label.textColor = UIColor.whiteColor()
            //set_label.textColor = UIColor.whiteColor()
            //atk_def_Label.textColor = UIColor.whiteColor()
            //rarity_Label.textColor = UIColor.whiteColor()
            //legality_Label.textColor = UIColor.whiteColor()
            //cardPass_Label.textColor = UIColor.whiteColor()
            description_Label.backgroundColor = hexStringToUIColor("#FFFFFF")
            summon_requirements_Label.backgroundColor = hexStringToUIColor("#FFFFFF")
            print("Xyz COLOR")
        }
        else if card_Type.contains("Ritual Spell Card") == true {
            self.view.backgroundColor = hexStringToUIColor("#1d9e74")
            description_Label.backgroundColor = hexStringToUIColor("#1d9e74")
            summon_requirements_Label.backgroundColor = hexStringToUIColor("#1d9e74")
            print("Ritual Spell Card COLOR")
        }
        else if card_Type.contains("Ritual") == true {
            self.view.backgroundColor = hexStringToUIColor("#9DB5CC")
            description_Label.backgroundColor = hexStringToUIColor("#9DB5CC")
            summon_requirements_Label.backgroundColor = hexStringToUIColor("#9DB5CC")
            print("Ritual COLOR")
        }
        else if card_Type.contains("Spell Card") == true {
            self.view.backgroundColor = hexStringToUIColor("#1d9e74")
            description_Label.backgroundColor = hexStringToUIColor("#1d9e74")
            summon_requirements_Label.backgroundColor = hexStringToUIColor("#1d9e74")
            print("Spell Card COLOR")
        }
        else if card_Type.contains("Trap Card") == true {
            self.view.backgroundColor = hexStringToUIColor("#BC5A84")
            description_Label.backgroundColor = hexStringToUIColor("#C5A84")
            summon_requirements_Label.backgroundColor = hexStringToUIColor("#C5A84")
            print("Trap Card COLOR")
        }
        else if card_Type.contains("Effect"){
            self.view.backgroundColor = hexStringToUIColor("#FF8B53")
            description_Label.backgroundColor = hexStringToUIColor("#FF8B53")
            summon_requirements_Label.backgroundColor = hexStringToUIColor("#FF8B53")
            print("Effect COLOR")
        }else{
            self.view.backgroundColor = hexStringToUIColor("#FDE68A")
            description_Label.backgroundColor = hexStringToUIColor("#FDE68A")
            summon_requirements_Label.backgroundColor = hexStringToUIColor("#FDE68A")
            print("Maybe NORMAL COLOR")
        }
        
        
        
        let modelName = UIDevice.current.modelName
        
        // Change Card Name Label font size based on device
        if (modelName.contains("5.5") != false) {
            let card_name_length = card_Name.characters.count;
            
            if (card_name_length >= 41){
                self.cardName_Label.font = UIFont(name:"HelveticaNeue-Bold", size: 13.0)
                print("Card name length is very long. DECREASING font size to 13.")
            }else if (card_name_length > 31 && card_name_length < 41){
                self.cardName_Label.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
                print("Card name length is long. DECREASING font size to 16.")
            }else{
                // Card name length is good. Changing font type though
                self.cardName_Label.font = UIFont(name:"HelveticaNeue-Bold", size: 19.0)
                print("Card name length is perfect. Changing font type though.")
            }
            
            
            
        }
        else if (modelName.range(of: "iPad") != nil) {
            self.cardName_Label.font = UIFont(name:"HelveticaNeue-Bold", size: 25.0)
            
        }
        
        // Set Card Name
        if card_Name != ""{
            self.cardName_Label.text = card_Name
        }else{
            self.cardName_Label.text = "Card Name: No card name found."
        }
        
        // Set Card Type
        if card_Type != "" {
            self.cardType_Label.text = card_Type
        }
        
        // Process & Set Attribute ImageView
        if attribute_Type != "" {
            self.Process_AND_Set_Attribute_IV(attribute_Type)
        }else{
            print("Attribute has no value")
        }
        
        // Set Summon Material Requirements
        if summon_Requirements != "null"{
            self.summon_requirements_Label.text = summon_Requirements
        }else{
            self.summon_requirements_Label.text = ""
        }
        
        // Set Description
        if description_Text == "" || description_Text == "NULL"{
            self.description_Label.text = "No effect or flavor text."
        }else{
            self.description_Label.text = description_Text
        }
        
        // Check if card type is Spell or Trap, if neither, set Atk & Def points.
        
        if attribute_Type == "SPELL" || attribute_Type == "TRAP"{
            self.atk_def_Label.text = ""
        }else if atk_Points != "" && def_Points != "" {
            atk_convertedToNumber = Int(atk_Points)!
            def_convertedToNumber = Int(def_Points)!
            
            if atk_convertedToNumber == 9999 || def_convertedToNumber == 9999 {
                var true_atk_value = ""
                var true_def_value = ""
                if atk_convertedToNumber == 9999{
                    true_atk_value = "?"
                }else{
                    true_atk_value = String(atk_convertedToNumber)
                }
                
                if def_convertedToNumber == 9999 {
                    true_def_value = "?"
                }else{
                    true_def_value = String(def_convertedToNumber)
                }
                
                self.atk_def_Label.text = "Atk/Def: \(true_atk_value) / \(true_def_value)"
                self.atk_def_Label.text = "ATK/\(true_atk_value) - DEF/\(true_def_value)"
            }else{
                self.atk_def_Label.text = "Atk/Def: \(atk_convertedToNumber) / \(def_convertedToNumber)"
            }
        }else{
            print("Card Type processing failed. Either not a SPELL/TRAP or atk/def points were empty values")
        }
        
        // Set Set Initials & Number
        
        if set_Initials == "" || set_Number == "" {
            print("Set details have no value")
        }else{
            self.set_label.text = "\(set_Initials) - \(set_Number)"
        }
        
        // Set Rarity
        if card_Rarity != ""{
            self.rarity_Label.text = "Rarity: \(card_Rarity)"
        }else{
            self.rarity_Label.text = "Rarity: Unknown"
        }
        
        // Set Legality
        if card_Legality != "" {
            self.legality_Label.text = "Legality: \(card_Legality)"
        }else{
            self.legality_Label.text = "Legality: Unknown"
        }
        
        // Set Card Passcode/Word
        
        if card_Passcode != "" {
            let cardPasscode_convertedToNumber = Int(card_Passcode)
            
            if cardPasscode_convertedToNumber == 4493{
                self.cardPass_Label.text = "Card does not have a passcode/password."
            }else{
                let card_Passcode_length = card_Passcode.characters.count
                
                if card_Passcode_length == 5 {
                    self.cardPass_Label.text = "000\(card_Passcode)"
                }else if card_Passcode_length == 6{
                    self.cardPass_Label.text = "00\(card_Passcode)"
                }else if card_Passcode_length == 7{
                    self.cardPass_Label.text = "0\(card_Passcode)"
                }else{
                    self.cardPass_Label.text = "\(card_Passcode)"
                }
            }
        }else{
            print("Card passcode/word has no value")
        }
        
        // Check if the levels & ranks string have a value
        
        if level_Stars != "" {
            levels_convertedToNumber = Int(level_Stars)!
            
            if rank_Stars != ""{
                ranks_convertedToNumber = Int(rank_Stars)!
                
                self.Check_levelANDrank_LowToMaxValues(levels_convertedToNumber, passed_Rank: ranks_convertedToNumber)
                
            }else{
                print("Rank has no value")
            }
        }else{
            print("Level has no value")
        }
    }
    
    func Retrieve_Passed_Card_Details(){
        
        card_Name = CardName.sharedInstance.returnedcardName!
        print("Retrieve 1: \(card_Name)")
        card_Type = Type.sharedInstance.returnedType
        print("Retrieve 2: \(card_Type)")
        attribute_Type = Attribute.sharedInstance.returnedAttribute!
        print("Retrieve 3: \(attribute_Type)")
        summon_Requirements = SummonRequirements.sharedInstance.returnedSummonRequirements!
        print("Retrieve 4")
        description_Text = Description.sharedInstance.returnedDescription!
        print("Retrieve 5")
        spell_Speed_ = SpellSpeed.sharedInstance.returnedSpellSpeed!
        print("Retrieve 6")
        level_Stars = Level.sharedInstance.returnedLevel!
        print("Retrieve 7")
        rank_Stars = Rank.sharedInstance.returnedRank!
        print("Retrieve 8")
        atk_Points = Atk.sharedInstance.returnedAtk!
        print("Retrieve 8")
        def_Points = Def.sharedInstance.returnedDef!
        print("Retrieve 9")
        set_Initials = Setini.sharedInstance.returnedSetini!
        print("Retrieve 10")
        set_Number = SetNumber.sharedInstance.returnedSetNumber!
        print("Retrieve 11")
        card_Passcode = CardPass.sharedInstance.returnedCardPass!
        print("Retrieve 12")
        card_Rarity = Rarity.sharedInstance.returnedRarity!
        print("Retrieve 13")
        card_Legality = Legality.sharedInstance.returnedLegality!
        
    }
    
    //   BEGIN      Attribute Function
    
    func Process_AND_Set_Attribute_IV(_ passedAttribute: String){
        if passedAttribute == "LIGHT" {
            self.attribute_IV.image = UIImage(imageLiteral: attributeLight_image_fileName)
        }else if passedAttribute == "DARK" {
            self.attribute_IV.image = UIImage(imageLiteral: attributeDark_image_fileName)
        }
        else if passedAttribute == "DIVINE" {
            self.attribute_IV.image = UIImage(imageLiteral: attributeDivine_image_fileName)
        }
        else if passedAttribute == "EARTH" {
            self.attribute_IV.image = UIImage(imageLiteral: attributeEarth_image_fileName)
        }
        else if passedAttribute == "FIRE" {
            self.attribute_IV.image = UIImage(imageLiteral: attributeFire_image_fileName)
        }
        else if passedAttribute == "SPELL" {
            self.attribute_IV.image = UIImage(imageLiteral: attributeSpell_image_fileName)
        }
        else if passedAttribute == "TRAP" {
            self.attribute_IV.image = UIImage(imageLiteral: attributeTrap_image_fileName)
        }
        else if passedAttribute == "WATER" {
            self.attribute_IV.image = UIImage(imageLiteral: attributeWater_image_fileName)
        }
        else if passedAttribute == "WIND" {
            self.attribute_IV.image = UIImage(imageLiteral: attributeWind_image_fileName)
        }
    }
    
    //   END      Attribute Function
    
    //   BEGIN      Level & Rank Functions
    
    func Check_levelANDrank_LowToMaxValues(_ passed_Level: Int, passed_Rank: Int){
        
        if (passed_Level > 0 && passed_Level < 13) {
            if (passed_Rank == 0) {
                print("LEVEL: \(passed_Level)")
                self.Configure_level_IVs_Against_Passed_level(passed_Level)
            } else {
                self.Configure_level_IVs_Against_Passed_level(99)
            }
        } else if (passed_Rank > 0 && passed_Rank < 13) {
            if (passed_Level == 0) {
                self.Configure_rank_IVs_Against_Passed_Rank(passed_Rank)
            } else {
                self.Configure_rank_IVs_Against_Passed_Rank(99)
            }
        } else if (passed_Level == 0 && passed_Rank == 0) {
            self.Configure_rank_IVs_Against_Passed_Rank(99)
        }
        
    }
    
    func Configure_level_IVs_Against_Passed_level(_ passedLevel: Int){
        print("Card's Level: \(passedLevel)")
        if passedLevel == 1{
            self.Clear_All_LEVELandRANK_IVs()
            self.level_rank_1_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
        }else if passedLevel == 2{
            self.Clear_All_LEVELandRANK_IVs()
            self.level_rank_1_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_2_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
        }else if passedLevel == 3{
            self.Clear_All_LEVELandRANK_IVs()
            self.level_rank_1_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_2_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_3_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
        }else if passedLevel == 4{
            self.Clear_All_LEVELandRANK_IVs()
            self.level_rank_1_IV.image = UIImage(imageLiteral:levelStar_image_fileName)
            self.level_rank_2_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_3_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_4_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
        }else if passedLevel == 5{
            self.Clear_All_LEVELandRANK_IVs()
            self.level_rank_1_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_2_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_3_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_4_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_5_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
        }else if passedLevel == 6{
            self.Clear_All_LEVELandRANK_IVs()
            self.level_rank_1_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_2_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_3_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_4_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_5_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_6_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
        }else if passedLevel == 7{
            self.Clear_All_LEVELandRANK_IVs()
            self.level_rank_1_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_2_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_3_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_4_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_5_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_6_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_7_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
        }else if passedLevel == 8{
            self.Clear_All_LEVELandRANK_IVs()
            self.level_rank_1_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_2_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_3_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_4_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_5_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_6_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_7_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_8_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
        }else if passedLevel == 9{
            self.Clear_All_LEVELandRANK_IVs()
            self.level_rank_1_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_2_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_3_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_4_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_5_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_6_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_7_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_8_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_9_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
        }else if passedLevel == 10{
            self.Clear_All_LEVELandRANK_IVs()
            self.level_rank_1_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_2_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_3_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_4_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_5_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_6_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_7_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_8_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_9_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_10_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            
        }else if passedLevel == 11{
            self.Clear_All_LEVELandRANK_IVs()
            self.level_rank_1_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_2_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_3_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_4_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_5_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_6_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_7_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_8_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_9_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_10_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_11_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
        }else if passedLevel == 12{
            self.Clear_All_LEVELandRANK_IVs()
            self.level_rank_1_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_2_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_3_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_4_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_5_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_6_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_7_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_8_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_9_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_10_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_11_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            self.level_rank_12_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
        }else if passedLevel == 99{
            self.Clear_All_LEVELandRANK_IVs()
        }else{
            self.Clear_All_LEVELandRANK_IVs()
        }
    }
    
    func Configure_rank_IVs_Against_Passed_Rank(_ passedRank: Int){
        if passedRank == 1{
            
            self.Clear_All_LEVELandRANK_IVs()
            self.level_rank_1_IV.image = UIImage(imageLiteral: levelStar_image_fileName)
            
        }else if passedRank == 2{
            
            self.Clear_All_LEVELandRANK_IVs()
            self.level_rank_1_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_2_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            
        }else if passedRank == 3{
            
            self.Clear_All_LEVELandRANK_IVs()
            self.level_rank_1_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_2_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_3_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            
        }else if passedRank == 4{
            
            self.Clear_All_LEVELandRANK_IVs()
            self.level_rank_1_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_2_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_3_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_4_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            
            
        }else if passedRank == 5{
            self.Clear_All_LEVELandRANK_IVs()
            self.level_rank_1_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_2_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_3_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_4_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_5_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            
        }else if passedRank == 6{
            self.Clear_All_LEVELandRANK_IVs()
            self.level_rank_1_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_2_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_3_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_4_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_5_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_6_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            
        }else if passedRank == 7{
            self.Clear_All_LEVELandRANK_IVs()
            self.level_rank_1_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_2_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_3_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_4_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_5_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_6_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_7_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            
        }else if passedRank == 8{
            self.Clear_All_LEVELandRANK_IVs()
            self.level_rank_1_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_2_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_3_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_4_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_5_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_6_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_7_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_8_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            
        }else if passedRank == 9{
            
            self.Clear_All_LEVELandRANK_IVs()
            self.level_rank_1_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_2_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_3_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_4_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_5_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_6_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_7_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_8_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_9_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            
        }else if passedRank == 10{
            
            self.Clear_All_LEVELandRANK_IVs()
            self.level_rank_1_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_2_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_3_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_4_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_5_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_6_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_7_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_8_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_9_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_10_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            
        }else if passedRank == 11{
            
            self.Clear_All_LEVELandRANK_IVs()
            self.level_rank_1_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_2_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_3_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_4_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_5_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_6_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_7_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_8_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_9_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_10_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_11_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            
        }else if passedRank == 12{
            
            self.Clear_All_LEVELandRANK_IVs()
            self.level_rank_1_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_2_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_3_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_4_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_5_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_6_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_7_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_8_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_9_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_10_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_11_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            self.level_rank_12_IV.image = UIImage(imageLiteral: rankStar_image_fileName)
            
        }else if passedRank == 99{
            self.Clear_All_LEVELandRANK_IVs()
        }else{
            self.Clear_All_LEVELandRANK_IVs()
        }
    }
    
    func Clear_All_LEVELandRANK_IVs(){
        print("Levels cleared")
        self.level_rank_1_IV.image = nil
        self.level_rank_2_IV.image = nil
        self.level_rank_3_IV.image = nil
        self.level_rank_4_IV.image = nil
        self.level_rank_5_IV.image = nil
        self.level_rank_6_IV.image = nil
        self.level_rank_7_IV.image = nil
        self.level_rank_8_IV.image = nil
        self.level_rank_9_IV.image = nil
        self.level_rank_10_IV.image = nil
        self.level_rank_11_IV.image = nil
        self.level_rank_12_IV.image = nil
    }
    //   END      Level & Rank Functions
    
    func clear_AllLabels(){
        
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
                    print("URL - Processed URL: \(response.url!.absoluteString)")
                    completionHandler(returnedURL: response.URL!.absoluteString)
                } else {
                    print(error)
                }
            }) 
            
            task.resume()
        }
        
    }
}
