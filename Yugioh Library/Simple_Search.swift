//
//  Simple_Search.swift
//  Yugioh Library
//
//  Created by Matthew White on 9/30/15.
//  Copyright (c) 2015 CybertechApps. All rights reserved.
//

import Foundation
import Haneke
import UIKit
import Kingfisher

class Simple_Search : UIViewController , UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    
   
    @IBOutlet var nav_menu: UINavigationItem!
    
    @IBOutlet weak var mainButton: UIBarButtonItem!
    
    @IBOutlet weak var cardResults: UITableView!
    
    @IBOutlet weak var card_nameLabel: UILabel!
    
    let CardAdapter_Object = Card_Adapter()
    
    var rows1: [MyCellData] = []
    var card_image_url = ""
    
    var returnedCardNames = [[String]]()
    var returnedCardTypes = NSMutableArray()
    
    // alertBoosterController variables to be setup depending on series chosen
    var alertBoosterC_Title = String()
    var alertBoosterC_Message = String()
    var alertBoosterC_SetArray = [String]()
    
    var placeholderImage = UIImage(imageLiteral: "ic_error")
    
    // Text Field Variables
    @IBOutlet weak var card_nameEntry: UITextField!
    var entered_card_name = String()
    
    
    // Arrays to contain series and booster sets
    
    var text = ""
    
    @IBOutlet weak var selectedSeriesO: UIButton!
    
    @IBOutlet weak var selectedSetO: UIButton!
    
    var selected_series = ""
    
    var selected_set = ""
    
    var check_CardDetails_Segue = true
    
    @IBAction func selectedSeries(_ sender: UIButton) {
        let alertSeriesController = UIAlertController(title: "Select a Yugi series", message: "Select a specific Yu-Gi-Oh! series or even a series of packs or decks.", preferredStyle:UIAlertControllerStyle.alert)
        
        for series_name in self.CardAdapter_Object.arrayOfSeries{
            alertSeriesController.addAction(UIAlertAction(title: series_name, style: UIAlertActionStyle.default)
                { action -> Void in
                    self.text = self.CardAdapter_Object.arrayOfSeries[0]
                    self.retrieve_selectedSeries(series_name)
                    self.retrieve_selectedSet((self.selectedSetO.titleLabel?.text)!)
                    
                    if self.card_nameEntry.text != nil{
                        if self.card_nameEntry.text != "" {
                            self.entered_card_name = self.card_nameEntry.text!
                        }else {
                            self.entered_card_name = ""
                        }
                    }
                    
                    self.determine_search_conditions(self.entered_card_name, chosen_series: self.selected_series, chosen_set: self.selected_set)
                })
        }
        
        
        
        self.present(alertSeriesController, animated: true, completion: nil)
    }
    
    @IBAction func selectedSet(_ sender: UIButton) {
        
        
    self.setup_boosteralertbox_based_on_series_chosen((self.selectedSeriesO.titleLabel?.text)!)
        
        let alertBoosterController = UIAlertController(title: alertBoosterC_Title, message: alertBoosterC_Message, preferredStyle:UIAlertControllerStyle.alert)
        
        for set_name in self.alertBoosterC_SetArray {
            alertBoosterController.addAction(UIAlertAction(title: set_name, style: UIAlertActionStyle.default)
                { action -> Void in
                    if set_name == "Cancel" {
                    
                    }else{
                        self.nav_menu.title = set_name
                    }
                    self.nav_menu.title = set_name
                    self.text = self.alertBoosterC_SetArray[0]
                    self.retrieve_selectedSet(set_name)
                    self.retrieve_selectedSeries((self.selectedSeriesO.titleLabel?.text)!)
                    
                    if self.card_nameEntry.text != nil{
                        if self.card_nameEntry.text != "" {
                            self.entered_card_name = self.card_nameEntry.text!
                        }else {
                            self.entered_card_name = ""
                        }
                    }
                    
                    
                    self.determine_search_conditions(self.entered_card_name ,chosen_series: self.selected_series, chosen_set: self.selected_set)
                })
        }
        
        self.present(alertBoosterController, animated: true, completion: nil)
        
        ///print(Type.sharedInstance.returnedType + "EGERGE")
        
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    // BEGIN - Poplulate TableView with card results using Array of returned card results
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return returnedCardNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell:CardInfo_Cell = tableView.dequeueReusableCell(withIdentifier: "cardCell") as! CardInfo_Cell
        
        
        
        //let card_name:CardInfo_Adapter = returnedCardNames[indexPath.row][0] as! CardInfo_Adapter
        
        var card_name = returnedCardNames[indexPath.row][0]
        var card_type = returnedCardNames[indexPath.row][1]
        CardName.sharedInstance.returnedcardName = card_name
        
        
        //print("SIMPLE SEARCH - String Array SELECT Test 1")
        
        cell.card_nameLabel.text = card_name
        cell.tag = indexPath.row
        cell.card_nameLabel.textColor = UIColor.black
        //cell.data = self.rows1[indexPath.row]
        
        
        
        Simple_Search.process_AND_return_card_URLS(CardName.sharedInstance.returnedcardName!) {
            returnedURL in
            self.card_image_url = returnedURL
            
            //print("FUNC = \(card_image_url)")
            var check_comma = self.card_image_url.replacingOccurrences(of: "%252C", with: "%2C")
            let check_special = check_comma.replacingOccurrences(of: "", with: "")
            let check_doubleAPOST = check_special.replacingOccurrences(of: "%27%27", with: "_")
            var check_apost = check_doubleAPOST.replacingOccurrences(of: "%27", with: "'")
            //var set_image = "http://static.api3.studiobebop.net/ygo_data/set_images/Shining_Victories.jpg"
            var final_URL = check_apost
            
            //print("Apost Replaced = \(check_apost)")
            
            let cache = Shared.imageCache
            
            
            //check_apost = check_apost.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
            //print("Encoded URL = \(check_apost)")
            let finished_URL = URL(string: final_URL)
            
            
            /*var image2 = KingfisherManager.sharedManager.retrieveImageWithURL(check_apost, optionsInfo: .None, progressBlock: nil), completionHandler: { imageURL in
                print("\(card_name): Finished")
            })*/
            
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
            
            //print("456456456")
            
            // haneke - Retrieve images from network & cache
            /*let fetcher_net = NetworkFetcher<UIImage>(URL: finished_URL!)
            let fetcher_disk = DiskFetcher<UIImage>(path: check_apost)
            cache.fetch(fetcher: fetcher_disk).onSuccess { image in
                //cell.card_imageIV.hnk_fetcher.cancelFetch()
                //print("Image Cache found")
                
                if cell.tag == indexPath.row{
                    cell.card_imageIV.image = image
                }
                cell.card_imageIV.image = image
                
                print("Successful image cache")
                
                }.onFailure{ image in
                    //print("Unavailable to find image cache, fetching from network")
                    cache.fetch(fetcher: fetcher_net).onSuccess { image in
                        //print("Network image request SUCCESS")
                        if cell.tag == indexPath.row{
                            cell.card_imageIV.image = image
                        }
                        cell.card_imageIV.image = image
                        print("Disk fetch failed")
                        }.onFailure{ image in
                            
                            print("network fetch failed")
                            
                            }
            }*/

            
            cell.card_imageIV.hnk_setImageFromURL(finished_URL!)
        }
        
        //print("Card Name: \(card_name), Card Type: \(card_type)")
        if cell.tag == indexPath.row {
            if card_type.contains("Synchro") == true {
                cell.backgroundColor = hexStringToUIColor("#CCCCCC")
                //print("Synchro COLOR")
            }else if card_type.contains("Fusion") == true {
                cell.backgroundColor = hexStringToUIColor("#a086b7")
                //print("Fusion COLOR")
            }
            else if card_type.contains("Xyz/") == true {
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
        
        //print("Card Name: \(card_name) && Card Type: \(card_type)")
        
        //cell.card_imageIV = image
        
        return cell
    }
    // END - Poplulate TableView with card results using Array of returned card results
    
    func tableView(_ tableView: UITableView!, didSelectRowAt indexPath: IndexPath) {
        
        //let card_name:CardInfo_Adapter = returnedCardNames[indexPath.row][0] as! CardInfo_Adapter
        
        let card_name = returnedCardNames[indexPath.row][0]
        
        self.CollectDetails(card_name)
        
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
    
    // BEGIN - If user typed in a card name
    func textFieldDidChange(_ textField: UITextField) {
        if self.card_nameEntry.text != nil{
            if self.card_nameEntry.text != "" {
                self.entered_card_name = self.card_nameEntry.text!
            }else {
                self.entered_card_name = ""
            }
        }
        
        self.selected_series = (self.selectedSeriesO.titleLabel?.text)!
        self.selected_set = (self.selectedSetO.titleLabel?.text)!
        
        self.determine_search_conditions(self.entered_card_name ,chosen_series: self.selected_series, chosen_set: self.selected_set)
    }
    // END   - If user typed in a card name
    
    // Built in method
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        Card_Adapter.getInstance().getPacksTest()
        
        if self.card_nameEntry.text != nil{
            if self.card_nameEntry.text != "" {
                self.entered_card_name = self.card_nameEntry.text!
                
                self.selected_series = (self.selectedSeriesO.titleLabel?.text)!
                self.selected_set = (self.selectedSetO.titleLabel?.text)!
                
                self.determine_search_conditions(self.entered_card_name ,chosen_series: self.selected_series, chosen_set: self.selected_set)
            }else {
                self.getCardNames()
            }
        }else{
            self.getCardNames()
        }
        
        
    }
    
    func getCardNames()
    {
        returnedCardNames = [[String]]()
        //print("SIMPLE SEARCH - ALL NAMES - String Array PULL Test 1")
        returnedCardNames = Card_Adapter.getInstance().getAllSimilarCardNamesByUserEntry("", passedSeriesName: "null", passedSetName: "null")
        //print("SIMPLE SEARCH - ALL NAMES - String Array PULL Test 2")
        cardResults.reloadData()
        
        //construct_image_url("", passed_SetNumber: "")
        //print("SIMPLE SEARCH - ALL NAMES - String Array PULL Test 3")
        
        //self.process_AND_return_card_URLS()
    }

    func construct_image_url(_ passed_SetInitial: String, passed_SetNumber: String) -> String{
        var passed_SetInitial = passed_SetInitial
        
        var Url = ""
        var modified_setNumber = ""
        let searchCharacter: Character = ";"
        
        passed_SetInitial = "DOB;LOB"
        if passed_SetInitial.lowercased().characters.contains(searchCharacter) {
            print("Successfully split initials and numbers")
        }else{
            print("Failed to split initials and numbers")
        }
        
        return "test"
    }
    
    override func viewDidLoad() {
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        
        if revealViewController() != nil {
            //            revealViewController().rearViewRevealWidth = 62
            mainButton.target = revealViewController()
            mainButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

        selectedSeriesO.layer.cornerRadius = 5
        selectedSeriesO.layer.borderWidth = 1
        
        selectedSetO.layer.cornerRadius = 5
        selectedSetO.layer.borderWidth = 1
        
        self.cardResults.delegate = self
        self.cardResults.dataSource = self
        self.card_nameEntry.delegate = self
        
        card_nameEntry.addTarget(self, action: #selector(Simple_Search.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        
        
        nav_menu.title = "Simple Search"
            }
    
    
    func retrieve_selectedSeries(_ chosen_series: String) {
        
        if chosen_series == "Cancel" {
            
            }
        else{
            selectedSeriesO.setTitle(chosen_series, for: UIControlState())
            selected_series = chosen_series
        }
    }
    
    func retrieve_selectedSet(_ chosen_set: String) {
        
        if chosen_set == "Cancel"{
            
        }
        else{
            
            selectedSetO.setTitle(chosen_set, for: UIControlState())
            selected_set = chosen_set
        }
    }
    
    // Determine the user options selected to search for the correct card results
    func determine_search_conditions(_ enter_card_name: String, chosen_series: String, chosen_set: String) {
        if chosen_series == "All Series" && chosen_set == "All Booster Sets" {
            
            returnedCardNames.removeAll()
            returnedCardNames = Card_Adapter.getInstance().getAllSimilarCardNamesByUserEntry(entered_card_name, passedSeriesName: "null", passedSetName: "null")
            cardResults.reloadData()
            
        } else if chosen_series == "All Series" && chosen_set != "All Booster Sets" {
            
            returnedCardNames.removeAll()
            returnedCardNames = Card_Adapter.getInstance().getAllSimilarCardNamesByUserEntry(entered_card_name, passedSeriesName: "null", passedSetName: chosen_set)
            cardResults.reloadData()
            
        } else if chosen_series != "All Series" && chosen_set == "All Booster Sets" {
            
            returnedCardNames.removeAll()
            returnedCardNames = Card_Adapter.getInstance().getAllSimilarCardNamesByUserEntry(entered_card_name, passedSeriesName: chosen_series, passedSetName: "null")
            cardResults.reloadData()
            
        } else if chosen_series != "All Series" && chosen_set != "All Booster Sets" {
            
            returnedCardNames.removeAll()
            returnedCardNames = Card_Adapter.getInstance().getAllSimilarCardNamesByUserEntry(entered_card_name, passedSeriesName: chosen_series, passedSetName: chosen_set)
            cardResults.reloadData()
            
        }
    }
    
    func setup_boosteralertbox_based_on_series_chosen(_ series_chosen: String) {
        if series_chosen == "All Series" {
            alertBoosterC_Title = ""
            alertBoosterC_Message = ""
            alertBoosterC_SetArray = self.CardAdapter_Object.arrayOfSets
        } else if series_chosen == "ARC-V" {
            alertBoosterC_Title = "Select a pack from the ARC-V Series."
            alertBoosterC_Message = "This list contains all the booster packs, special packs, collector tins, and more from the ARC-V series. The list is ordered by release date."
            alertBoosterC_SetArray = self.CardAdapter_Object.sets_ARCV
        } else if series_chosen == "Zexal" {
            alertBoosterC_Title = ""
            alertBoosterC_Message = ""
            alertBoosterC_SetArray = self.CardAdapter_Object.sets_ZEXAL
        } else if series_chosen == "5D" {
            alertBoosterC_Title = ""
            alertBoosterC_Message = ""
            alertBoosterC_SetArray = self.CardAdapter_Object.sets_5D
        } else if series_chosen == "GX" {
            alertBoosterC_Title = ""
            alertBoosterC_Message = ""
            alertBoosterC_SetArray = self.CardAdapter_Object.sets_GX
        } else if series_chosen == "Yugi" {
            alertBoosterC_Title = ""
            alertBoosterC_Message = ""
            alertBoosterC_SetArray = self.CardAdapter_Object.sets_YUGI
        } else if series_chosen == "Structure Decks" {
            alertBoosterC_Title = ""
            alertBoosterC_Message = ""
            alertBoosterC_SetArray = self.CardAdapter_Object.sets_STRUCTURE_DECKS
        } else if series_chosen == "Starter Decks" {
            alertBoosterC_Title = ""
            alertBoosterC_Message = ""
            alertBoosterC_SetArray = self.CardAdapter_Object.sets_STARTER_DECKS
        } else if series_chosen == "Duelist Packs" {
            alertBoosterC_Title = ""
            alertBoosterC_Message = ""
            alertBoosterC_SetArray = self.CardAdapter_Object.sets_DUELIST_PACKS
        } else if series_chosen == "Hidden Arsenal" {
            alertBoosterC_Title = ""
            alertBoosterC_Message = ""
            alertBoosterC_SetArray = self.CardAdapter_Object.sets_HIDDEN_ARSENALS
        } else if series_chosen == "Other" {
            alertBoosterC_Title = ""
            alertBoosterC_Message = ""
            alertBoosterC_SetArray = self.CardAdapter_Object.sets_OTHER
        }
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
                "There was an error retrieving a type of data for the selected card. Please report this to me by hitting the Report button. In the meantime, try selecting different cards to isolate if it's an issue with just this one card, a few or something else.", preferredStyle: UIAlertControllerStyle.alert)
            
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
