//
//  Advance_Search.swift
//  Yugioh Library
//
//  Created by Matthew White on 9/30/15.
//  Copyright (c) 2015 CybertechApps. All rights reserved.
//

import Foundation
import UIKit


class Advance_Search : UIViewController {
    
    let Card_Adapter_Object = Card_Adapter()
    var returnedCardNames = [[String]]()
    
    // Button outlets for 'ViewDidLoad' configurations
    
    @IBOutlet var check_criteria: UILabel!
    
    @IBOutlet weak var mainButton: UIBarButtonItem!
    
    @IBOutlet weak var cardTypeB_config: UIButton!
    @IBOutlet var cardSubTypeB_config: UIButton!
    @IBOutlet var monsterTypeB_config: UIButton!
    @IBOutlet var monsterSubTypeB_config: UIButton!
    @IBOutlet var attributeB_config: UIButton!
    @IBOutlet var level_rankB_config: UIButton!
    @IBOutlet var selectedSetB_config: UIButton!
    @IBOutlet var search_cards: UIButton!
    
    
    // Text Field outlets
    @IBOutlet var cardNameTF_config: UITextField!
    @IBOutlet var cardDescriptionTF_config: UITextField!
    @IBOutlet var cardLessThenATK_TF_config: UITextField!
    @IBOutlet var cardGreaterThanATK_TF_config: UITextField!
    @IBOutlet var cardLessThanDEF_TF_config: UITextField!
    @IBOutlet var cardGreaterThanDEF_TF_config: UITextField!
    @IBOutlet weak var cardPassCodeTF_config: UITextField!
    
    // Delcare variables for chosen search criteria
    var main_card_type_critvalue = ""
    var cardsub_type_critvalue = ""
    var monster_spell_trap_type_critvalue = ""
    var monstersecondaryType_critvalue = ""
    var monstersecondaryTypeClear_critvalue = ""
    var attribute_critvalue = ""
    var cardSet_critvalue = ""
    var levelOrRank_critvalue = ""
    var cardname_critvalue = ""
    var lessThanATK_critvalue = ""
    var greaterThanATK_critvalue = ""
    var lessThanDEF_critvalue = ""
    var greaterThanDEF_critvalue = ""
    var passCodeNum = ""
    var description_critvalue = ""
    
    
    var chosen_cardType = ""
    
            // Alert Titles and Messages
    // Primary Card Type
    var cardType_AlterTitle = ""
    var cardType_AlertMessage = ""
    
    // Secondary Card Type(Monster Cards Only(Effect, Ritual, Normal, etc))
    var cardSecondaryCardType_AlertTitle = ""
    var cardSecondaryCardType_AlertMessage = ""
    
    // Monster Card Type
    var cardMonsterCardType_AlertTitle = ""
    var cardMonsterCardType_AlertMessage = ""
    
    // Secondary Monster Card Type
    var cardSecondaryMonsterCardType_AlertTitle = ""
    var cardSecondaryMonsterCardType_AlertMessage = ""
    
    // Attribute Type
    var cardAttributeType_AlertTitle = ""
    var cardAttributeType_AlertMessage = ""
    
    // Level/Rank Type
    var cardLevelRankType_AlertTitle = ""
    var cardLevelRankType_AlertMessage = ""
    
    // Selected Card Set
    var cardSelectedCardSet_AlertTitle = ""
    var cardSelectedCardSet_AlertMessage = ""
    
    override func viewDidLoad() {
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        self.config_buttons_onLoad()
        self.initialize_Alert_Titles_and_Messages()
        
        if revealViewController() != nil {
            //            revealViewController().rearViewRevealWidth = 62
            mainButton.target = revealViewController()
            mainButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    
    
    // Built in method
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Set custom view configurations for all buttons.
    func config_buttons_onLoad(){
        
                                    // All Buttons
        // Primary card type button
        self.cardTypeB_config.layer.cornerRadius = 5
        self.cardTypeB_config.layer.borderWidth = 1
        self.cardTypeB_config.tag = 1
        self.cardTypeB_config.titleLabel?.textAlignment = NSTextAlignment.center
        
        // Sub Card Type button
        self.cardSubTypeB_config.layer.cornerRadius = 5
        self.cardSubTypeB_config.layer.borderWidth = 1
        self.cardSubTypeB_config.tag = 2
        self.cardSubTypeB_config.isEnabled = false
        self.cardSubTypeB_config.setTitleColor(UIColor.gray, for: UIControlState())
        self.cardSubTypeB_config.titleLabel?.textAlignment = NSTextAlignment.center
        
        // Primary Monster button
        self.monsterTypeB_config.layer.cornerRadius = 5
        self.monsterTypeB_config.layer.borderWidth = 1
        self.monsterTypeB_config.tag = 3
        self.monsterTypeB_config.isEnabled = false
        self.monsterTypeB_config.setTitleColor(UIColor.gray, for: UIControlState())
        self.monsterTypeB_config.titleLabel?.textAlignment = NSTextAlignment.center
        
        // Secondary Monster Type button
        self.monsterSubTypeB_config.layer.cornerRadius = 5
        self.monsterSubTypeB_config.layer.borderWidth = 1
        self.monsterSubTypeB_config.tag = 4
        self.monsterSubTypeB_config.isEnabled = false
        self.monsterSubTypeB_config.setTitleColor(UIColor.gray, for: UIControlState())
        self.monsterSubTypeB_config.titleLabel?.textAlignment = NSTextAlignment.center
        
        // Attribute button
        self.attributeB_config.layer.cornerRadius = 5
        self.attributeB_config.layer.borderWidth = 1
        self.attributeB_config.tag = 5
        self.attributeB_config.isEnabled = false
        self.attributeB_config.setTitleColor(UIColor.gray, for: UIControlState())
        self.attributeB_config.titleLabel?.textAlignment = NSTextAlignment.center
        
        // Level/Rank buton
        self.level_rankB_config.layer.cornerRadius = 5
        self.level_rankB_config.layer.borderWidth = 1
        self.level_rankB_config.tag = 6
        self.level_rankB_config.isEnabled = false
        self.level_rankB_config.setTitleColor(UIColor.gray, for: UIControlState())
        self.level_rankB_config.titleLabel?.textAlignment = NSTextAlignment.center
        
        // Selected Card Set button
        self.selectedSetB_config.layer.cornerRadius = 5
        self.selectedSetB_config.layer.borderWidth = 1
        self.selectedSetB_config.tag = 7
        self.selectedSetB_config.setTitleColor(UIColor.cyan, for: UIControlState())
        self.selectedSetB_config.titleLabel?.textAlignment = NSTextAlignment.center
        
        // Search Cards button
        self.search_cards.layer.cornerRadius = 5
        self.search_cards.layer.borderWidth = 1
        self.search_cards.tag = 8
        self.search_cards.setTitleColor(UIColor.cyan, for: UIControlState())
    }

    // Setup all variables for Chosen Search Criteria
    func configure_default_variable_criteria() {
        cardsub_type_critvalue = "Monster Sub Type"
        monster_spell_trap_type_critvalue  = "Card Sub Type"
        monstersecondaryType_critvalue = "Monster Secondary Type"
        attribute_critvalue = "Attribute Clear"
        levelOrRank_critvalue = "Level/Rank Clear"
        cardSet_critvalue = "Card Set Clear"
        
    }
    
    // Enable 'resignFirstResponder' for all text fields when required
    func resignFirstResponder_AllTextField() {
        
        // Card Name
        self.cardNameTF_config.resignFirstResponder()
        
        // Card Description
        self.cardDescriptionTF_config.resignFirstResponder()
        
        // Less Than ATK
        self.cardLessThenATK_TF_config.resignFirstResponder()
        
        // Greater Than ATK
        self.cardGreaterThanATK_TF_config.resignFirstResponder()
        
        // Less Than DEF
        self.cardLessThanDEF_TF_config.resignFirstResponder()
        
        // Greater Than DEF
        self.cardGreaterThanDEF_TF_config.resignFirstResponder()
        
        // Card PassCode
        self.cardPassCodeTF_config.resignFirstResponder()
        
    }
    
    func initialize_Alert_Titles_and_Messages() {
        // Primary Card Type
        cardType_AlterTitle = Card_Adapter_Object.cardType_AlterTitle
        cardType_AlertMessage = Card_Adapter_Object.cardType_AlertMessage
        
        // Secondary Card Type(Monster Cards Only(Effect, Ritual, Normal, etc))
        cardSecondaryCardType_AlertTitle = "12"
        cardSecondaryCardType_AlertMessage = "12"
        
        // Monster Card Type
        cardMonsterCardType_AlertTitle = "Monster Types"
        cardMonsterCardType_AlertMessage = "Search among all main monster types including Warrior, Beast, Machine, & more."
        
        // Secondary Monster Card Type
        cardSecondaryMonsterCardType_AlertTitle = "14"
        cardSecondaryMonsterCardType_AlertMessage = "14"
        
        // Attribute Type
        cardAttributeType_AlertTitle = "15"
        cardAttributeType_AlertMessage = "15"
        
        // Level/Rank Type
        cardLevelRankType_AlertTitle = "16"
        cardLevelRankType_AlertMessage = "16"
        
        // Selected Card Set
        cardSelectedCardSet_AlertTitle = "17"
        cardSelectedCardSet_AlertMessage = "17"
    }
    
    func enable_buttons_when_monster_button_is_selected(){
        cardSubTypeB_config.isEnabled = true
        cardSubTypeB_config.setTitleColor(UIColor.cyan, for: UIControlState())
        
        monsterTypeB_config.setTitle("Monster Type", for: UIControlState())
        monsterTypeB_config.isEnabled = true
        monsterTypeB_config.setTitleColor(UIColor.cyan, for: UIControlState())
        
        monsterSubTypeB_config.isEnabled = true
        monsterSubTypeB_config.setTitleColor(UIColor.cyan, for: UIControlState())
        
        attributeB_config.isEnabled = true
        attributeB_config.setTitleColor(UIColor.cyan, for: UIControlState())
        self.attributeB_config.titleLabel?.textAlignment = NSTextAlignment.center
        
        level_rankB_config.isEnabled = true
        level_rankB_config.setTitleColor(UIColor.cyan, for: UIControlState())
    }
    
    func enable_and_disable_buttons_when_spell_or_trap_button_is_selected(_ card_type: String){
        
        if card_type == "Spell" {
            // Set Title for Card Type and then for Secondary Card Type
            self.cardTypeB_config.setTitle("Spell Cards", for: UIControlState())
            self.monsterTypeB_config.setTitle("Spell Type Clear", for: UIControlState())
            
        } else if card_type == "Trap" {
            self.cardTypeB_config.setTitle("Trap Cards", for: UIControlState())
            self.monsterTypeB_config.setTitle("Trap Type Clear", for: UIControlState())
            }
        
        // Enable Monster Type button and set Title Color
        self.monsterTypeB_config.isEnabled = true
        self.monsterTypeB_config.setTitleColor(UIColor.cyan, for: UIControlState())
        
        // Disable all non-related buttons
        self.cardSubTypeB_config.isEnabled = false
        self.cardSubTypeB_config.setTitleColor(UIColor.gray, for: UIControlState())
        
        self.monsterSubTypeB_config.isEnabled = false
        self.monsterSubTypeB_config.setTitleColor(UIColor.gray, for: UIControlState())
        
        self.attributeB_config.isEnabled = false
        self.attributeB_config.setTitleColor(UIColor.gray, for: UIControlState())
        
        self.level_rankB_config.isEnabled = false
        self.level_rankB_config.setTitleColor(UIColor.gray, for: UIControlState())
        
    }
    
    func reset_all_buttons_to_default(){
        // Card Type button
        self.cardTypeB_config.setTitle("Clear", for: UIControlState())
        
        // Card Sub Type
        self.cardSubTypeB_config.setTitle("Monster Sub Type", for: UIControlState())
        self.cardSubTypeB_config.setTitleColor(UIColor.gray, for: UIControlState())
        self.cardSubTypeB_config.isEnabled = false
        
        // Monster/Spell/Trap Card type
        self.monsterTypeB_config.setTitle("Card Sub Type", for: UIControlState())
        self.monsterTypeB_config.setTitleColor(UIColor.gray, for: UIControlState())
        self.monsterTypeB_config.isEnabled = false
        
        // Secondary Monster Type
        self.monsterSubTypeB_config.setTitle("Monster 2nd Type", for: UIControlState())
        self.monsterSubTypeB_config.setTitleColor(UIColor.gray, for: UIControlState())
        self.monsterSubTypeB_config.isEnabled = false
        
        // Attribute Type
        self.attributeB_config.setTitle("Attribute Clear", for: UIControlState())
        self.attributeB_config.setTitleColor(UIColor.gray, for: UIControlState())
        self.attributeB_config.titleLabel?.textAlignment = NSTextAlignment.center
        self.attributeB_config.isEnabled = false
        
        // Level/Rank Type
        self.level_rankB_config.setTitle("Level/Rank Clear", for: UIControlState())
        self.level_rankB_config.setTitleColor(UIColor.gray, for: UIControlState())
        self.level_rankB_config.isEnabled = false
        
        // Card Set Clear
        self.selectedSetB_config.setTitle("Card Set Clear", for: UIControlState())
        self.selectedSetB_config.setTitleColor(UIColor.cyan, for: UIControlState())
        self.selectedSetB_config.isEnabled = true
    }
    
    func update_button_titles_for_chosen_criteria(_ uiButton_name: String, chosen_criteria: String) {
        
        if uiButton_name == "Spell" {
            if chosen_criteria == "Cancel" {
                //cardSubTypeB_config.titleLabel?.text = cardsub_type_critvalue
            }else if chosen_criteria == "Spell Type Clear" {
                monsterSubTypeB_config.setTitle(chosen_criteria, for: UIControlState())
            }else{
                cardsub_type_critvalue = chosen_criteria
            }
            
            cardSubTypeB_config.setTitle("", for: UIControlState())
        }
        
    }
    
    
    @IBAction func select_MainCardType(_ sender: UIButton) {
        let Selected_Button_AlertController = UIAlertController(title: "", message: "", preferredStyle:UIAlertControllerStyle.alert)
        
        Selected_Button_AlertController.title = cardType_AlterTitle
        Selected_Button_AlertController.message = cardType_AlertMessage
        
        for card_type in self.Card_Adapter_Object.cardTypes_DEFAULT {
            Selected_Button_AlertController.addAction(UIAlertAction(title: card_type, style:
                UIAlertActionStyle.default)
                { action -> Void in
                    if card_type == "Monster" {
                        self.cardTypeB_config.setTitle("Monster Cards", for: UIControlState())
                        self.enable_buttons_when_monster_button_is_selected()
                        self.chosen_cardType = "Monster"
                    }else if card_type == "Spell" {
                        
                        self.enable_and_disable_buttons_when_spell_or_trap_button_is_selected("Spell")
                        self.chosen_cardType = "Spell"
                        
                    }else if card_type == "Trap" {
                        
                        self.enable_and_disable_buttons_when_spell_or_trap_button_is_selected("Trap")
                        self.chosen_cardType = "Trap"
                        
                    } else if card_type == "Cancel" {
                        
                    }
                    else {
                        self.reset_all_buttons_to_default()
                    }
                })
        }
        
        self.present(Selected_Button_AlertController, animated: true, completion: nil)    }
    
    @IBAction func select_MonsterSubCardType(_ sender: UIButton) {
        
        let Selected_Button_AlertController = UIAlertController(title: "", message: "", preferredStyle:UIAlertControllerStyle.alert)
        
        Selected_Button_AlertController.title = cardSecondaryCardType_AlertTitle
        Selected_Button_AlertController.message = cardSecondaryCardType_AlertMessage
        
        for SecondaryCardType in self.Card_Adapter_Object.subCardTypes {
            Selected_Button_AlertController.addAction(UIAlertAction(title: SecondaryCardType, style:
                UIAlertActionStyle.default)
                { action -> Void in
                    //self.update_button_titles_for_chosen_criteria("Secondary Card Type", chosen_criteria: SecondaryCardType)
                    
                    if SecondaryCardType == "Cancel" {
                        
                    }else if SecondaryCardType == "Search all below monster card types" {
                        
                        self.cardSubTypeB_config.setTitle("Search All", for: UIControlState())
                        self.cardsub_type_critvalue = ""
                    }else {
                        self.cardSubTypeB_config.setTitle(SecondaryCardType, for: UIControlState())
                        self.cardsub_type_critvalue = SecondaryCardType
                    }
                    
                    
                })
        }
        
        self.present(Selected_Button_AlertController, animated: true, completion: nil)
    }
    
    @IBAction func select_Monster_Spell_Trap_Type(_ sender: UIButton) {
        
        if chosen_cardType == "Monster" {
            
            let Selected_Button_AlertController = UIAlertController(title: "", message: "", preferredStyle:UIAlertControllerStyle.alert)
            
            Selected_Button_AlertController.title = cardMonsterCardType_AlertTitle
            Selected_Button_AlertController.message = cardMonsterCardType_AlertMessage
            
            for monster_type in self.Card_Adapter_Object.sub_TYPES_MONSTER{
                Selected_Button_AlertController.addAction(UIAlertAction(title: monster_type, style:
                    UIAlertActionStyle.default)
                    { action -> Void in
                        
                        if monster_type == "Cancel" {
                            
                        }else if monster_type == "Search All Primary Monster Types" {
                            self.monsterTypeB_config.setTitle("Search All M", for: UIControlState())
                            self.monster_spell_trap_type_critvalue = ""
                        }else {
                            self.monsterTypeB_config.setTitle(monster_type, for: UIControlState())
                            self.monster_spell_trap_type_critvalue = monster_type
                        }
                    })
            }
            
            self.present(Selected_Button_AlertController, animated: true, completion: nil)
            
        } else if chosen_cardType == "Spell" {
            let Selected_Button_AlertController = UIAlertController(title: "", message: "", preferredStyle:UIAlertControllerStyle.alert)
            
            Selected_Button_AlertController.title = cardMonsterCardType_AlertTitle
            Selected_Button_AlertController.message = cardMonsterCardType_AlertMessage
            
            for spell_type in self.Card_Adapter_Object.subTypes_SPELL{
                Selected_Button_AlertController.addAction(UIAlertAction(title: spell_type, style:
                    UIAlertActionStyle.default)
                    { action -> Void in
                        if spell_type == "Cancel" {
                            
                        }else if spell_type == "Search All Spell Types" {
                            self.monsterTypeB_config.setTitle("Search All S", for: UIControlState())
                            self.monster_spell_trap_type_critvalue = ""
                        }else {
                            self.monsterTypeB_config.setTitle(spell_type, for: UIControlState())
                            self.monster_spell_trap_type_critvalue = spell_type
                        }
                    })
            }
            
            self.present(Selected_Button_AlertController, animated: true, completion: nil)
            
        } else if chosen_cardType == "Trap" {
            
            let Selected_Button_AlertController = UIAlertController(title: "", message: "", preferredStyle:UIAlertControllerStyle.alert)
            
            Selected_Button_AlertController.title = cardMonsterCardType_AlertTitle
            Selected_Button_AlertController.message = cardMonsterCardType_AlertMessage
            
            for trap_type in self.Card_Adapter_Object.sub_TYPES_TRAP {
                Selected_Button_AlertController.addAction(UIAlertAction(title: trap_type, style:
                    UIAlertActionStyle.default)
                    { action -> Void in
                        if trap_type == "Cancel" {
                            
                        }else if trap_type == "Search All Trap Types" {
                            self.monsterTypeB_config.setTitle("Search All T", for: UIControlState())
                            self.monster_spell_trap_type_critvalue = ""
                        }else {
                            self.monsterTypeB_config.setTitle(trap_type, for: UIControlState())
                            self.monster_spell_trap_type_critvalue = trap_type
                        }
                    })
            }
            
            self.present(Selected_Button_AlertController, animated: true, completion: nil)
        }

        
    }
    
    
    @IBAction func select_MonsterSecondaryType(_ sender: UIButton) {
        
        let Selected_Button_AlertController = UIAlertController(title: "", message: "", preferredStyle:UIAlertControllerStyle.alert)
        
        Selected_Button_AlertController.title = cardSecondaryMonsterCardType_AlertTitle
        Selected_Button_AlertController.message = cardSecondaryMonsterCardType_AlertMessage
        
        for SecondaryType in self.Card_Adapter_Object.sub_TYPES_SECONDARY_MONSTER {
            Selected_Button_AlertController.addAction(UIAlertAction(title: SecondaryType, style:
                UIAlertActionStyle.default)
                { action -> Void in
                    if SecondaryType == "Cancel" {
                        
                    }else if SecondaryType == "Search All Secondary Monster Types" {
                        self.monsterSubTypeB_config.setTitle("Search All", for: UIControlState())
                        self.monstersecondaryType_critvalue = ""
                    }else {
                        self.monsterSubTypeB_config.setTitle(SecondaryType, for: UIControlState())
                        self.monstersecondaryType_critvalue = SecondaryType
                    }
                })
        }
        
        self.present(Selected_Button_AlertController, animated: true, completion: nil)
        
    }
    
    @IBAction func select_Attribute(_ sender: UIButton) {
        
        let Selected_Button_AlertController = UIAlertController(title: "", message: "", preferredStyle:UIAlertControllerStyle.alert)
        
        Selected_Button_AlertController.title = cardAttributeType_AlertTitle
        Selected_Button_AlertController.message = cardAttributeType_AlertMessage
        
        for attribute_type in self.Card_Adapter_Object.ATTRIBUTES {
            Selected_Button_AlertController.addAction(UIAlertAction(title: attribute_type, style:
                UIAlertActionStyle.default)
                { action -> Void in
                    if attribute_type == "Cancel" {
                        
                    }else if attribute_type == "Search All Attributes" {
                        self.attributeB_config.setTitle("Search All", for: UIControlState())
                        self.attribute_critvalue = ""
                    }else {
                        self.attributeB_config.setTitle(attribute_type, for: UIControlState())
                        self.attribute_critvalue = attribute_type
                    }
                })
        }
        
        self.present(Selected_Button_AlertController, animated: true, completion: nil)
        
    }
    
    @IBAction func select_LevelRank(_ sender: UIButton) {
        
        let Selected_Button_AlertController = UIAlertController(title: "", message: "", preferredStyle:UIAlertControllerStyle.alert)
        
        Selected_Button_AlertController.title = cardLevelRankType_AlertTitle
        Selected_Button_AlertController.message = cardLevelRankType_AlertMessage
        
        for level_rank in self.Card_Adapter_Object.arrayOfLevel_Rank {
            Selected_Button_AlertController.addAction(UIAlertAction(title: level_rank, style:
                UIAlertActionStyle.default)
                { action -> Void in
                    if level_rank == "Cancel" {
                        
                    }else if level_rank == "Search All Levels & Ranks" {
                        self.level_rankB_config.setTitle("Search All", for: UIControlState())
                        self.levelOrRank_critvalue = ""
                    }else {
                        self.level_rankB_config.setTitle(level_rank, for: UIControlState())
                        self.levelOrRank_critvalue = level_rank
                    }
                })
        }
        
        self.present(Selected_Button_AlertController, animated: true, completion: nil)
        
    }
    
    @IBAction func select_CardSet(_ sender: UIButton) {
        
        let Selected_Button_AlertController = UIAlertController(title: "", message: "", preferredStyle:UIAlertControllerStyle.alert)
        
        Selected_Button_AlertController.title = cardSelectedCardSet_AlertTitle
        Selected_Button_AlertController.message = cardSelectedCardSet_AlertMessage
        
        for selected_card_set in self.Card_Adapter_Object.arrayOfSets {
            Selected_Button_AlertController.addAction(UIAlertAction(title: selected_card_set, style:
                UIAlertActionStyle.default)
                { action -> Void in
                    if selected_card_set == "Cancel" {
                        
                    }else if selected_card_set == "All Booster Sets" {
                        self.selectedSetB_config.setTitle("Search All Sets, decks, etc", for: UIControlState())
                        self.cardSet_critvalue = ""
                    }else {
                        self.selectedSetB_config.setTitle(selected_card_set, for: UIControlState())
                        self.cardSet_critvalue = selected_card_set
                    }
                })
        }
        
        self.present(Selected_Button_AlertController, animated: true, completion: nil)
        
    }
    
    @IBAction func search_for_cards(_ sender: UIButton) {
        
        // Retrieve user entered CARD NAME
        if cardNameTF_config.text! == "" {
            cardname_critvalue = ""
        }else {
            cardname_critvalue = cardNameTF_config.text!
        }
        
        // Retrieve user entered DESCRIPTION
        if cardDescriptionTF_config.text! == "" {
            description_critvalue = ""
        }else {
            description_critvalue = cardDescriptionTF_config.text!
        }
        
        // Retrieve user CHOSEN MAIN CARD TYPE
        if cardTypeB_config.titleLabel?.text == "Clear" {
            main_card_type_critvalue = ""
        }else {
            main_card_type_critvalue = cardTypeB_config.titleLabel!.text!
        }
        
        // Retrieve user CHOSEN MONSTER SUB TYPE
        if cardSubTypeB_config.titleLabel?.text == "Monster Sub Type" || cardSubTypeB_config.titleLabel?.text == "Search All" {
            cardsub_type_critvalue = ""
        }else {
            cardsub_type_critvalue = cardSubTypeB_config.titleLabel!.text!
        }
        
        // Retrieve user CHOSEN CARD SUB TYPE(SPELL, TRAP OR MONSTER)
        if monsterTypeB_config.titleLabel?.text == "Monster Type" || monsterTypeB_config.titleLabel?.text == "Search All M" {
            
            monster_spell_trap_type_critvalue = ""
            
        }else if monsterTypeB_config.titleLabel?.text == "Spell Type Clear" || monsterTypeB_config.titleLabel?.text == "Search All S"{
            
            monster_spell_trap_type_critvalue = "Spell"
            
        }else if monsterTypeB_config.titleLabel?.text == "Trap Type Clear" || monsterTypeB_config.titleLabel?.text == "Search All T"{
            
            monster_spell_trap_type_critvalue = "Trap"
            
        }else if monsterTypeB_config.titleLabel?.text == "Card Sub Type" {
            monster_spell_trap_type_critvalue = ""
        }else {
            monster_spell_trap_type_critvalue = monsterTypeB_config.titleLabel!.text!
        }
        
        // Retrieve user CHOSEN MONSTER SECONDARY TYPE
        if monsterSubTypeB_config.titleLabel?.text == "Monster 2nd Type" || monsterSubTypeB_config.titleLabel?.text == "Search All" {
            
            monstersecondaryType_critvalue = ""
            monstersecondaryTypeClear_critvalue = "Monster 2nd Type Clear"
            
        }else {
            monstersecondaryType_critvalue = monsterSubTypeB_config.titleLabel!.text!
            monstersecondaryTypeClear_critvalue = monsterSubTypeB_config.titleLabel!.text!
        }
        
        // Retrieve user CHOSEN ATTRIBUTE TYPE
        if attributeB_config.titleLabel?.text == "Attribute Clear" || attributeB_config.titleLabel?.text == "Search All" {
            
            attribute_critvalue = ""
            
        }else {
            
            attribute_critvalue = attributeB_config.titleLabel!.text!
        }
        
        // Retrieve user CHOSEN LEVEL OR RANK
        if level_rankB_config.titleLabel?.text == "Level/Rank Clear" || level_rankB_config.titleLabel?.text == "Search All" {
            
            levelOrRank_critvalue = ""
            
        }else {
            
            levelOrRank_critvalue = level_rankB_config.titleLabel!.text!
            
        }
        
        // Retrieve user entered LESS THAN ATK
        if cardLessThenATK_TF_config.text == "" {
            lessThanATK_critvalue = "0"
        }else{
            if cardLessThenATK_TF_config.text == "0" {
                lessThanATK_critvalue = "1"
            }else{
                lessThanATK_critvalue = cardLessThenATK_TF_config.text!
            }
            
        }
        
        // Retrieve user entered GREATER THAN ATK
        if cardGreaterThanATK_TF_config.text == "" {
            greaterThanATK_critvalue = "30000"
        }else {
            if cardGreaterThanATK_TF_config.text == "0" {
                greaterThanATK_critvalue = "1"
            }else{
                greaterThanATK_critvalue = cardGreaterThanATK_TF_config.text!
            }
            
        }
        
        // Retrieve user entered LESS THAN DEF
        if cardLessThanDEF_TF_config.text == "" {
            lessThanDEF_critvalue = "0"
        }else {
            if cardLessThanDEF_TF_config.text == "0" {
                lessThanDEF_critvalue = "1"
            }else{
                lessThanDEF_critvalue = cardLessThanDEF_TF_config.text!
            }
            
        }
        
        // Retrieve user entered GREATER THAN DEF
        if cardGreaterThanDEF_TF_config.text == "" {
            greaterThanDEF_critvalue = "30000"
        }else {
            if cardGreaterThanDEF_TF_config.text == "0" {
                greaterThanDEF_critvalue = "1"
            }else{
                greaterThanDEF_critvalue = cardGreaterThanDEF_TF_config.text!
            }
            
        }
        
        // Retrieve user entered PASSCODE
        if cardPassCodeTF_config.text == "" {
            passCodeNum = ""
        }else {
            passCodeNum = cardPassCodeTF_config.text!
        }
        
        // Retrieve user entered CARD SET
        if selectedSetB_config.titleLabel?.text == "Card Set Clear" || selectedSetB_config.titleLabel?.text == "Search All Sets, decks, etc" {
            cardSet_critvalue = ""
            print("Selected Set: N/A")
        }else {
            
            cardSet_critvalue = selectedSetB_config.titleLabel!.text!
            print("Selected Set: \(cardSet_critvalue)")
        }
        
        var returnedCardNames = [[String]]()
        let CardAdapter_Object = Card_Adapter()
        
        /*returnedCardNames = CardAdapter_Object.getAllSimilarCardsForAdvanceSearch(main_card_type_critvalue,
            card_name: cardname_critvalue,
            description: description_critvalue,
            card_sub_type: cardsub_type_critvalue,
            main_card_type: monster_spell_trap_type_critvalue,
            card_secondary_type: monstersecondaryType_critvalue,
            card_secondary_type_clearCheck: monstersecondaryType_critvalue,
            attribute_type: attribute_critvalue,
            level_rank_stars: levelOrRank_critvalue,
            lessThanATK: lessThanATK_critvalue,
            greaterThanATK: greaterThanATK_critvalue,
            lessThanDEF: lessThanDEF_critvalue,
            greaterThanDEF: greaterThanDEF_critvalue,
            passCodeNum: passCodeNum,
            setname: cardSet_critvalue)*/
        
        /*returnedCardNames = CardAdapter_Object.getAllSimilarCardsForAdvanceSearch(main_card_type_critvalue,
        card_name: cardname_critvalue,
        description: description_critvalue,
        card_sub_type: cardsub_type_critvalue,
        main_card_type: monster_spell_trap_type_critvalue,
        card_secondary_type: monstersecondaryType_critvalue,
        card_secondary_type_clearCheck: "",
        attribute_type: "",
        level_rank_stars: "",
        lessThanATK: "",
        greaterThanATK: "",
        lessThanDEF: "",
        greaterThanDEF: "",
        passCodeNum: passCodeNum,
        setname: cardSet_critvalue)*/
        
        print(main_card_type_critvalue)
        returnedCardNames = CardAdapter_Object.test(main_card_type_critvalue,
            card_name: cardname_critvalue,
            description: description_critvalue,
            card_sub_type: cardsub_type_critvalue,
            main_card_type: monster_spell_trap_type_critvalue,
            card_secondary_type: monstersecondaryType_critvalue,
            card_secondary_type_clearCheck: monstersecondaryTypeClear_critvalue,
            attribute_type: attribute_critvalue,
            level_rank_stars: levelOrRank_critvalue,
            lessThanATK: lessThanATK_critvalue,
            greaterThanATK: greaterThanATK_critvalue,
            lessThanDEF: lessThanDEF_critvalue,
            greaterThanDEF: greaterThanDEF_critvalue,
            passCodeNum: passCodeNum,
            setname: cardSet_critvalue)
        
        if returnedCardNames[0][0] == "No results found."  {
            print("No Results 55")
            let alertController = UIAlertController(title: "No cards found", message:
                "Try searching again with different criteria. If you know for sure a card(s) exist, please use the Help menu to report it to me.", preferredStyle: UIAlertControllerStyle.alert)
            
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,
                handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }else{
            
        }
        
        Singleton.sharedInstance.returnedCardNames = returnedCardNames
        
        tabBarController?.selectedIndex = 1
    }
    
}
