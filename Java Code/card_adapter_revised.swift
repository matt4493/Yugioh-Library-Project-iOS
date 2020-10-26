//
//  Card_Adapter.swift
//  Yugioh Library
//
//  Created by Matthew White on 10/13/15.
//  Copyright (c) 2015 CybertechApps. All rights reserved.
//

import Foundation

let sharedInstance1 = Card_Adapter()

class Card_Adapter: NSObject {
    
    var database: FMDatabase? = nil
    
    class func getInstance() -> Card_Adapter
    {
        if(sharedInstance1.database == nil)
        {
            sharedInstance1.database = FMDatabase(path: Util.getPath("yugiohdb.jet"))
        }
        return sharedInstance1
    }
    
    func getaCard() -> String{
        var returnedCardName = ""
        sharedInstance1.database!.open()
        
        let check_cardSet : FMResultSet! = sharedInstance1.database!.executeQuery("SELECT card_name FROM cards where card_name like \"%%\"", withArgumentsInArray: nil)
        
        if check_cardSet  != nil {
            while check_cardSet.next() {
                returnedCardName = check_cardSet.stringForColumn("card_name")
            }
            sharedInstance1.database!.close()
            print(returnedCardName)
            return returnedCardName
        }
        print("Could not find Card")
        return "Could not find Card"
    }
    
    // Get all packs
    func getAlllPackNames() -> [String] {
        var returnedSetNames = [String]()
        
        var row_values = [String]()
        var array_increment = 0
        
        sharedInstance1.database!.open()
        let check_resultSet: FMResultSet! = sharedInstance1.database!.executeQuery("SELECT full_set_name FROM sets", withArgumentsInArray: nil)
        let final_resultSet: FMResultSet! = sharedInstance1.database!.executeQuery("SELECT full_set_name FROM sets", withArgumentsInArray: nil)
        
        if check_resultSet.next() != false {
            if final_resultSet != nil {
                while final_resultSet.next() {
                    let returnedSetName : CardInfo_Adapter = CardInfo_Adapter()
                    returnedSetName.SetName = final_resultSet.stringForColumn("full_set_name")
                    
                    returnedSetNames.append(returnedSetName.SetName)
                }
                sharedInstance1.database!.close()
                return returnedSetNames
            }else{
                print("No card results at all.")
            }
        }
        
        let no_sets : CardInfo_Adapter = CardInfo_Adapter()
        no_sets.SetName = "No sets found."
        returnedSetNames.append(no_sets.SetName)
        sharedInstance1.database!.close()
        return returnedSetNames
        
    }
    
    // Test retrieveing sets
    func getPacksTest(){
        var returnedSetNames = [String]()
        
        var row_values = [String]()
        var array_increment = 0
        
        sharedInstance1.database!.open()
        let check_resultSet: FMResultSet! = sharedInstance1.database!.executeQuery("SELECT full_set_name FROM sets", withArgumentsInArray: nil)
        let final_resultSet: FMResultSet! = sharedInstance1.database!.executeQuery("SELECT full_set_name FROM sets", withArgumentsInArray: nil)
        
        if check_resultSet.next() != false {
            if final_resultSet != nil {
                while final_resultSet.next() {
                    let returnedSetName : CardInfo_Adapter = CardInfo_Adapter()
                    returnedSetName.SetName = final_resultSet.stringForColumn("full_set_name")
                    //print("Retrieved Card Set: \(returnedSetName.SetName)")
                    returnedSetNames.append(returnedSetName.SetName)
                }
                sharedInstance1.database!.close()
                
            }else{
                print("No card results at all.")
            }
        }
    }
    // Method to retrieve card results of Simple Search
    func getAllSimilarCardNamesByUserEntry(passedCardName: String, passedSeriesName: String, passedSetName: String) -> [[String]] {
    
        var returnedSimilarNames = [[String]]()
        var returnedCardSet = String()
        
        var row_values = [String]()
        var array_increment = 0
        
        // Retrieve cards results - If User wants All Series & Booster Sets
        if passedSeriesName == "null" && passedSetName == "null" {
            sharedInstance1.database!.open()
            let check_resultSet: FMResultSet! = sharedInstance1.database!.executeQuery("SELECT DISTINCT card_name, card_type FROM cards WHERE card_name like \"%\(passedCardName)%\" ORDER BY card_name ASC", withArgumentsInArray: nil)
            
            let resultSet: FMResultSet! = sharedInstance1.database!.executeQuery("SELECT DISTINCT card_name, card_type FROM cards WHERE card_name like \"%\(passedCardName)%\" ORDER BY card_name ASC", withArgumentsInArray: nil)
            
            if check_resultSet.next() != false {
                if resultSet != nil {
                    while resultSet.next() {
                        let returnedCardName : CardInfo_Adapter = CardInfo_Adapter()
                        returnedCardName.CardName = resultSet.stringForColumn("card_name")
                        returnedCardName.CardType = resultSet.stringForColumn("card_type")
                        //print("CARD ADAPTER - String Array PULL Test 1")
                        //print("Card Name:\(resultSet.stringForColumn("card_name")) ::: Card Type: \(resultSet.stringForColumn("card_type"))")
                        //print("Increment level: \(array_increment)")
                        
                        row_values.append(returnedCardName.CardName)
                        row_values.append(returnedCardName.CardType)
                        returnedSimilarNames.append(row_values)
                        
                        row_values.removeAll()
                    }
                    sharedInstance1.database!.close()
                    return returnedSimilarNames
                }else {
                    print("No Card Results at all.")
                }
            }else {
                
            }
            
            
            
        } // Retrieve cards results - If User chose All Series but chose a specific Booster Set
        else if passedSeriesName == "null" && passedSetName != "null" {
            
            sharedInstance1.database!.open()
            
            let check_returnedCardSet_query: FMResultSet! = sharedInstance1.database!.executeQuery("SELECT set_ini, full_set_name FROM sets WHERE full_set_name like \"%\(passedSetName)%\"", withArgumentsInArray: nil)
            
            let returnedCardSet_query: FMResultSet! = sharedInstance1.database!.executeQuery("SELECT set_ini, full_set_name FROM sets WHERE full_set_name like \"%\(passedSetName)%\"", withArgumentsInArray: nil)
            
            //returnedCardSet = returnedCardSet_query.stringForColumn("set_ini")
            
            if check_returnedCardSet_query.next() != false {
                returnedCardSet_query.next()
                returnedCardSet = returnedCardSet_query.stringForColumn("set_ini")
                
                let check_resultSet : FMResultSet! = sharedInstance1.database!.executeQuery("SELECT DISTINCT card_name, card_type FROM cards WHERE setini like \"%\(returnedCardSet)%\" AND card_name like \"%\(passedCardName)%\" ORDER BY card_name ASC", withArgumentsInArray: nil)
                
                let resultSet : FMResultSet! = sharedInstance1.database!.executeQuery("SELECT DISTINCT card_name, card_type FROM cards WHERE setini like \"%\(returnedCardSet)%\" AND card_name like \"%\(passedCardName)%\" ORDER BY card_name ASC", withArgumentsInArray: nil)
                
                
                if check_resultSet.next() != false {
                    if resultSet != nil {
                        while resultSet.next() {
                            let returnedCardName : CardInfo_Adapter = CardInfo_Adapter()
                            returnedCardName.CardName = resultSet.stringForColumn("card_name")
                            returnedCardName.CardType = resultSet.stringForColumn("card_type")
                            //print("CARD ADAPTER - String Array PULL Test 1")
                            //print("Card Name:\(resultSet.stringForColumn("card_name")) ::: Card Type: \(resultSet.stringForColumn("card_type"))")
                            //print("Increment level: \(array_increment)")
                            
                            row_values.append(returnedCardName.CardName)
                            row_values.append(returnedCardName.CardType)
                            returnedSimilarNames.append(row_values)
                            
                            row_values.removeAll()
                        }
                        sharedInstance1.database!.close()
                        return returnedSimilarNames
                    }
                }else {
                    print("No set initials found for set \(passedSetName).", terminator: "")
                }
            }
                
                
            
        } // Retrieve cards results - If User chose a series but wants All Booster sets
        else if passedSeriesName != "null" && passedSetName == "null" {
            print("Specific series but all sets", terminator: "")
            print(passedSeriesName, terminator: "")
            sharedInstance1.database!.open()
            let check_resultSet: FMResultSet! = sharedInstance1.database!.executeQuery("SELECT DISTINCT card_name, card_type FROM cards WHERE card_name like \"%\(passedCardName)%\" AND series_name like \"%\(passedSeriesName)%\" ORDER BY card_name ASC", withArgumentsInArray: nil)
            
            let resultSet: FMResultSet! = sharedInstance1.database!.executeQuery("SELECT DISTINCT card_name, card_type FROM cards WHERE card_name like \"%\(passedCardName)%\" AND series_name like \"%\(passedSeriesName)%\" ORDER BY card_name ASC", withArgumentsInArray: nil)
            
            if check_resultSet.next() != false {
                if resultSet != nil {
                    while resultSet.next() {
                        let returnedCardName : CardInfo_Adapter = CardInfo_Adapter()
                        returnedCardName.CardName = resultSet.stringForColumn("card_name")
                        returnedCardName.CardType = resultSet.stringForColumn("card_type")
                        //print("CARD ADAPTER - String Array PULL Test 1")
                        //print("Card Name:\(resultSet.stringForColumn("card_name")) ::: Card Type: \(resultSet.stringForColumn("card_type"))")
                        //print("Increment level: \(array_increment)")
                        
                        row_values.append(returnedCardName.CardName)
                        row_values.append(returnedCardName.CardType)
                        returnedSimilarNames.append(row_values)
                        
                        row_values.removeAll()
                    }
                    sharedInstance1.database!.close()
                    return returnedSimilarNames
                }else {
                    print("No Card Results at all.", terminator: "")
                }            }else {
                
            }
            
        } // Retrieve cards results - If User chose a series & booster set
        else if passedSeriesName != "null" && passedSetName != "null" {
            print("Specific Series & Booster", terminator: "")
            sharedInstance1.database!.open()
            
            let check_returnedCardSet_query: FMResultSet! = sharedInstance1.database!.executeQuery("SELECT set_ini, full_set_name FROM sets WHERE full_set_name like \"%\(passedSetName)%\"", withArgumentsInArray: nil)
            
            let returnedCardSet_query: FMResultSet! = sharedInstance1.database!.executeQuery("SELECT set_ini, full_set_name FROM sets WHERE full_set_name like \"%\(passedSetName)%\"", withArgumentsInArray: nil)
            
            //returnedCardSet = returnedCardSet_query.stringForColumn("set_ini")
            
            if check_returnedCardSet_query.next() != false {
                returnedCardSet_query.next()
                returnedCardSet = returnedCardSet_query.stringForColumn("set_ini")
                
                let check_resultSet : FMResultSet! = sharedInstance1.database!.executeQuery("SELECT DISTINCT card_name, card_type FROM cards WHERE setini like \"%\(returnedCardSet)%\" AND card_name like \"%\(passedCardName)%\" ORDER BY card_name ASC", withArgumentsInArray: nil)
                
                let resultSet : FMResultSet! = sharedInstance1.database!.executeQuery("SELECT DISTINCT card_name, card_type FROM cards WHERE setini like \"%\(returnedCardSet)%\" AND card_name like \"%\(passedCardName)%\"  ORDER BY card_name ASC", withArgumentsInArray: nil)
                
                
                if check_resultSet.next() != false {
                    if resultSet != nil {
                        while resultSet.next() {
                            let returnedCardName : CardInfo_Adapter = CardInfo_Adapter()
                            returnedCardName.CardName = resultSet.stringForColumn("card_name")
                            returnedCardName.CardType = resultSet.stringForColumn("card_type")
                            //print("CARD ADAPTER - String Array PULL Test 1")
                            //print("Card Name:\(resultSet.stringForColumn("card_name")) ::: Card Type: \(resultSet.stringForColumn("card_type"))")
                            //print("Increment level: \(array_increment)")
                            
                            row_values.append(returnedCardName.CardName)
                            row_values.append(returnedCardName.CardType)
                            returnedSimilarNames.append(row_values)
                            
                            row_values.removeAll()
                        }
                        sharedInstance1.database!.close()
                        return returnedSimilarNames
                    }
                }else {
                    print("No set initials found for set \(passedSetName).", terminator: "")
                }
            }
            
        }
        
        let NoResults : CardInfo_Adapter = CardInfo_Adapter()
        NoResults.CardName = "No results found."
        NoResults.CardType = "No Card Type found."
        print("No results found.")
        
        row_values.append(NoResults.CardName)
        row_values.append(NoResults.CardType)
        
        returnedSimilarNames.append(row_values)
        
        row_values.removeAll()
        
        return returnedSimilarNames
    }
    
    func gefe() -> Array<String> {
        
        var returnedSimilarNames: Array<String> = []
        
        // you are not using this here.
        //var returnedCardSet:String!
        
        
        returnedSimilarNames.append("No results")
        
        
        return returnedSimilarNames
    }
    
    func test(main_card_type_checkvalue: String, card_name: String, description: String, card_sub_type: String, main_card_type: String, card_secondary_type: String, card_secondary_type_clearCheck: String, attribute_type: String, level_rank_stars: String,
        lessThanATK: String, greaterThanATK: String, lessThanDEF: String, greaterThanDEF: String,
        passCodeNum: String, setname: String) -> [[String]] {
            
        var returnedSimilarNames = [[String]]()
        var row_values = [String]()
        var array_increment = 0
        var NoResults = [[String]]()
        var returnedCardSet = String()
        var sql_query_similar_cards = ""
    
        var setname = "Enemy of Justice"
        print(main_card_type_checkvalue + " CHECKING VALUE")
            
        if setname != "" {
            sharedInstance1.database!.open()
            print("Test 1")
            let check_returnedCardSet_query: FMResultSet! = sharedInstance1.database!.executeQuery("SELECT set_ini FROM sets WHERE full_set_name like \"%\(setname)%\"", withArgumentsInArray: nil)
            print("Test 2")
            let returnedCardSet_query: FMResultSet! = sharedInstance1.database!.executeQuery("SELECT set_ini FROM sets WHERE full_set_name like \"%\(setname)%\"", withArgumentsInArray: nil)
            print("Test 4")
            
            if check_returnedCardSet_query.next() != false {
                returnedCardSet_query.next()
                returnedCardSet = returnedCardSet_query.stringForColumn("set_ini")
                print("Test 5")
                
                if main_card_type_checkvalue == "Monster Cards" {
                    print(main_card_type + " ::: " + card_secondary_type + " ::: " + card_sub_type)
                    print(" ::: " + card_secondary_type_clearCheck)
                    
                    if card_sub_type == "Normal" {
                        if card_secondary_type_clearCheck == "Monster 2nd Type Clear" {
                            sql_query_similar_cards = "SELECT card_name, card_type FROM cards WHERE description like \"%"
                                + description
                                + "%\" AND "
                                + "(card_type not like \"pendulum\" AND card_type not like \"%Fusion%\" AND card_type not like \"%Effect%\" AND card_type not like \"%Ritual%\" AND "
                                + "card_type not like \"%Xyz%\" AND card_type not like \"%Synchro%\" AND card_type not like \"%Union%\" AND "
                                + "card_type not like \"%Spirit%\" AND card_type not like \"%Toon%\" AND card_type not like \"%trap%\" AND "
                                + "card_type not like \"%spell%\" AND card_type not like \"%Tuner%\") OR "
                                + "(card_name='Water Spirit' OR card_name='Flamvell Guard' OR card_name='Genex Controller' OR card_name='Tuner Warrior' OR "
                                + "card_name='Ally Mind') AND "
                                + "attribute_type like \"%"
                                + attribute_type
                                + "%\" AND "
                                + "(level_stars like \"%"
                                + level_rank_stars
                                + "%\" OR rank_stars like \"%"
                                + level_rank_stars
                                + "%\") AND "
                                + "(atk_points >= "
                                + lessThanATK
                                + " AND atk_points <= "
                                + greaterThanATK
                                + ") AND "
                                + "(def_points >= "
                                + lessThanDEF
                                + " AND def_points <= "
                                + greaterThanDEF
                                + ") AND "
                                + "setini like \"%"
                                + returnedCardSet
                                + "%\" AND "
                                + "card_number like \"%"
                                + passCodeNum
                                + "%\" ORDER BY card_name ASC;";
                            
                            //print(sql_query_similar_cards)
                        }else if card_secondary_type == "Tuner" {
                            sql_query_similar_cards = "SELECT card_name, card_type FROM cards WHERE description like \"%"
                                + description
                                + "%\" AND "
                                + "(card_name='Water Spirit' OR card_name='Flamvell Guard' OR card_name='Genex Controller' OR card_name='Tuner Warrior' OR "
                                + "card_name='Ally Mind') AND "
                                + "card_type like \"%"
                                + main_card_type
                                + "%\" AND "
                                + "attribute_type like \"%"
                                + attribute_type
                                + "%\" AND "
                                + "(level_stars like \"%"
                                + level_rank_stars
                                + "%\" OR rank_stars like \"%"
                                + level_rank_stars
                                + "%\") AND "
                                + "(atk_points >= "
                                + lessThanATK
                                + " AND atk_points <= "
                                + greaterThanATK
                                + ") AND "
                                + "(def_points >= "
                                + lessThanDEF
                                + " AND def_points <= "
                                + greaterThanDEF
                                + ") AND "
                                + "setini like \"%"
                                + returnedCardSet
                                + "%\" AND "
                                + "card_number like \"%"
                                + passCodeNum
                                + "%\" ORDER BY card_name ASC;";
                            
                            //print(sql_query_similar_cards)
                        }else{
                            sql_query_similar_cards = "SELECT card_name, card_type FROM cards WHERE card_name like \"%"
                                + card_name
                                + "%\" AND "
                                + "description like \"%"
                                + description
                                + "%\" AND "
                                + "(description not like \"%Add%\" OR description not like \"%You can pay%\" OR description not like \"%Once per turn%\""
                                + " AND description not like \"%Special Summon%\""
                                + " AND description not like \"%During your Main Phase%\" OR description not like \"%While in Attack Position%\""
                                + " AND description not like \"%While in Defense Position%\" OR description not like \"%you can add%\""
                                + " AND description not like \"%Synchro Material Monster%\" OR description not like \"%sent to the Graveyard%\""
                                + " AND description not like \"%sent from the%\" OR description not like \"%when this%\" OR description not like \"%when this card%\""
                                + " AND description not like \"%if this card%\" OR description not like \"%while this card%\" OR description not like \"%if your%\""
                                + " AND description not like \"%when you take%\" OR description not like \"%when this removed%\" OR description not like \"%all face-up%\""
                                + " AND description not like \"%during either player's%\" OR description not like \"%during damage calculation%\" OR description not like \"%this card%\") "
                                + "AND "
                                + "card_type like \"%"
                                + ""
                                + "%\" AND card_type like \"%"
                                + main_card_type
                                + "%\" AND "
                                + "card_type not like \"pendulum\" AND card_type not like \"%Fusion%\" AND card_type not like \"%Effect%\" AND card_type not like \"%Ritual%\" AND "
                                + "card_type not like \"%Xyz%\" AND card_type not like \"%Synchro%\" AND card_type not like \"%Union%\" AND "
                                + "card_type not like \"%Spirit%\" AND card_type not like \"%Toon%\" AND card_type not like \"%Gemini%\" AND "
                                + "card_type not like \"%Normal%\" AND "
                                + "card_type like \"%"
                                + card_secondary_type
                                + "%\" AND attribute_type like \"%"
                                + attribute_type
                                + "%\" AND "
                                + "level_stars like \"%"
                                + level_rank_stars
                                + "%\" AND "
                                + "(atk_points >= "
                                + lessThanATK
                                + " AND atk_points <= "
                                + greaterThanATK
                                + ") AND "
                                + "(def_points >= "
                                + lessThanDEF
                                + " AND def_points <= "
                                + greaterThanDEF
                                + ") AND "
                                + "setini like \"%"
                                + returnedCardSet
                                + "%\" AND "
                                + "card_number like \"%"
                                + passCodeNum
                                + "%\" ORDER BY card_name ASC;";
                            
                            //print(sql_query_similar_cards)
                        }
                    }else if (card_sub_type == "Effect"){
                        print("Effect")
                    }
                    
                } else if main_card_type_checkvalue == "Spell Cards" {
                    print("Test 6")
                    sql_query_similar_cards = "SELECT card_name, card_type FROM cards WHERE card_name like \"%"
                        + "\(card_name)"
                        + "%\" AND "
                        + "description like \"%"
                        + "\(description)"
                        + "%\" AND "
                        + "card_type like \"%"
                        + "\(card_sub_type)"
                        + "%\" AND card_type like \"%"
                        + "\(main_card_type)"
                        + "%\" AND "
                        + "card_type not like \"%Spellcaster%\" AND card_type not like \"%Trap Card%\" AND "
                        + "card_type like \"%"
                        + "\(card_secondary_type)"
                        + "%\" AND "
                        + "setini like \"%"
                        + "\(returnedCardSet)"
                        + "%\" AND "
                        + "card_number like \"%"
                        + passCodeNum
                        + "%\" ORDER BY card_name ASC;";
                    
                    //print(sql_query_similar_cards)
                } else if main_card_type_checkvalue == "Trap Cards" {
                    print("Test 7")
                    sql_query_similar_cards = "SELECT card_name, card_type FROM cards WHERE card_name like \"%"
                        + "\(card_name)"
                        + "%\" AND "
                        + "description like \"%"
                        + "\(description)"
                        + "%\" AND "
                        + "card_type like \"%"
                        + "\(card_sub_type)"
                        + "%\" AND card_type like \"%"
                        + "\(main_card_type)"
                        + "%\" AND "
                        + "card_type not like \"%Spell Card%\" AND "
                        + "card_type like \"%"
                        + "\(card_secondary_type)"
                        + "%\" AND "
                        + "setini like \"%"
                        + "\(returnedCardSet)"
                        + "%\" AND "
                        + "card_number like \"%"
                        + passCodeNum
                        + "%\" ORDER BY card_name ASC;";
                } else {
                    sql_query_similar_cards = "SELECT card_name, card_type FROM cards WHERE card_name like \"%"
                        + "\(card_name)"
                        + "%\" AND "
                        + "description like \"%"
                        + "\(description)"
                        + "%\" AND "
                        + "card_type like \"%"
                        + "\(card_sub_type)"
                        + "%\" AND card_type like \"%"
                        + "\(main_card_type)"
                        + "%\" AND "
                        + "card_type like \"%"
                        + "\(card_secondary_type)"
                        + "%\" AND attribute_type like \"%"
                        + "\(attribute_type)"
                        + "%\" AND "
                        + "level_stars like \"%"
                        + "\(level_rank_stars)"
                        + "%\" AND rank_stars like \"%"
                        + "\(level_rank_stars)"
                        + "%\" AND "
                        + "atk_points >= "
                        + "\(lessThanATK)"
                        + " AND atk_points <= "
                        + "\(greaterThanATK)"
                        + " AND "
                        + "def_points >= "
                        + "\(lessThanDEF)"
                        + " AND def_points <= "
                        + "\(greaterThanDEF)"
                        + " AND "
                        + "setini like \"%"
                        + "\(returnedCardSet)"
                        + "%\" AND "
                        + "card_number like \"%"
                        + "\(passCodeNum)"
                        + "%\" ORDER BY card_name ASC;";
                    //print(sql_query_similar_cards)
                    
                }
                
                let check_similarCards_query: FMResultSet! = sharedInstance1.database!.executeQuery(sql_query_similar_cards, withArgumentsInArray: nil)
                print("Test 9")
                let similarCards_query: FMResultSet! = sharedInstance1.database!.executeQuery(sql_query_similar_cards, withArgumentsInArray: nil)
                
                print("Test 10")
                if check_similarCards_query.next() != false {
                    while similarCards_query.next() {
                        var returnedCardName = similarCards_query.stringForColumn("card_name")
                        var returnedCardType = similarCards_query.stringForColumn("card_type")
                        
                        row_values.append(returnedCardName)
                        row_values.append(returnedCardType)
                        returnedSimilarNames.append(row_values)
                        
                        row_values.removeAll()
                    }
                    sharedInstance1.database!.close()
                    return returnedSimilarNames
                }
            }
        }else{
            returnedSimilarNames[0][0] = "No Results"
            return NoResults
        }
        
        returnedSimilarNames[0][0] = "No Results"
        return NoResults
    }

    func getAllSimilarCardsForAdvanceSearch(main_card_type_checkvalue: String, card_name: String, description: String, card_sub_type: String, main_card_type: String, card_secondary_type: String,
        card_secondary_type_clearCheck: String, attribute_type: String, level_rank_stars: String,
        lessThanATK: String, greaterThanATK: String, lessThanDEF: String, greaterThanDEF: String,
        passCodeNum: String, setname: String) -> Array<String> {
        
            
        var returnedSimilarNames : Array<String> = []
        var NoResults : Array<String> = []
        var sql_query_similar_cards = ""
        NoResults.append("No results found.")
        var returnedCardSet = String()
        
        
            if setname != "" {
                sharedInstance1.database!.open()
                print("Test 1")
                let check_returnedCardSet_query: FMResultSet! = sharedInstance1.database!.executeQuery("SELECT set_ini FROM sets WHERE full_set_name like \"%\(setname)%\"", withArgumentsInArray: nil)
                print("Test 2")
                let returnedCardSet_query: FMResultSet! = sharedInstance1.database!.executeQuery("SELECT set_ini FROM sets WHERE full_set_name like \"%\(setname)%\"", withArgumentsInArray: nil)
                print("Test 4")
                if check_returnedCardSet_query.next() != false {
                    returnedCardSet_query.next()
                    returnedCardSet = returnedCardSet_query.stringForColumn("set_ini")
                    print("Test 5")
                    if main_card_type_checkvalue == "Monster" {
                        
                    } else if main_card_type_checkvalue == "Spell" {
                        print("Test 6")
                        sql_query_similar_cards = "SELECT card_name FROM cards WHERE card_name like \"%"
                            + "\(card_name)"
                            + "%\" AND "
                            + "description like \"%"
                            + "\(description)"
                            + "%\" AND "
                            + "card_type like \"%"
                            + "\(card_sub_type)"
                            + "%\" AND card_type like \"%"
                            + "\(main_card_type)"
                            + "%\" AND "
                            + "card_type not like \"%Spellcaster%\" AND card_type not like \"%Trap Card%\" AND "
                            + "card_type like \"%"
                            + "\(card_secondary_type)"
                            + "%\" AND "
                            + "setini like \"%"
                            + "\(returnedCardSet)"
                            + "%\" AND "
                            + "card_number like \"%"
                            + passCodeNum
                            + "%\" ORDER BY card_name ASC;";
                    } else if main_card_type_checkvalue == "Trap" {
                        print("Test 7")
                    } else {
                        print("Test 8")
                    }
                    
                    let check_similarCards_query: FMResultSet! = sharedInstance1.database!.executeQuery(sql_query_similar_cards, withArgumentsInArray: nil)
                    print("Test 9")
                    let similarCards_query: FMResultSet! = sharedInstance1.database!.executeQuery(sql_query_similar_cards, withArgumentsInArray: nil)
                    print("Test 10")
                    if check_similarCards_query.next() != false {
                        while similarCards_query.next() {
                            var returnedCardName = similarCards_query.stringForColumn("card_name")
                            print("Got first spell name")
                            returnedSimilarNames.append(returnedCardName)
                        }
                        sharedInstance1.database!.close()
                        return returnedSimilarNames
                    }
            
            }else {
                print("Test 11")
            }
                print("Test 12")
                print(setname)
        return NoResults
     }
            print("Test 13")
          return NoResults
    }
    
    func getCardType(passedName: String) -> String {
        
        let null_results = "No card type found"
        
        var returnedCardType = String()
        
        sharedInstance1.database!.open()
        
        var string_query = "SELECT card_type FROM cards WHERE card_name = \"\(passedName)\""
        
        //print(string_query)
        
        let check_retrieveCardType: FMResultSet! = sharedInstance1.database!.executeQuery("SELECT card_type FROM cards WHERE card_name = \"\(passedName)\"", withArgumentsInArray: nil)
        
        let retrieveCardType: FMResultSet! = sharedInstance1.database!.executeQuery("SELECT card_type FROM cards WHERE card_name = \"\(passedName)\"", withArgumentsInArray: nil)
        
        if check_retrieveCardType.next() != false {
            if retrieveCardType != nil {
                while retrieveCardType.next() {
                    returnedCardType = retrieveCardType.stringForColumn("card_type")
                    
                }
                sharedInstance1.database!.close()
                return returnedCardType
            }else {
                return null_results
            }
        }
        
        return null_results
    }
    
    func getCardName(passedName: String, match_type: String) -> String{
        var returnedCardName = ""
        sharedInstance1.database!.open()
        
        var check_cardSet: FMResultSet!
        
        
        if match_type == "like"{
            
           check_cardSet  = sharedInstance1.database!.executeQuery("SELECT card_name FROM cards where card_name like \"%\(passedName)%\"", withArgumentsInArray: nil)
            
        }else if match_type == "exact"{
            check_cardSet = sharedInstance1.database!.executeQuery("SELECT card_name FROM cards where card_name = \"\(passedName)\"", withArgumentsInArray: nil)
        }
        
        
        
        if check_cardSet  != nil {
            while check_cardSet.next() {
                returnedCardName = check_cardSet.stringForColumn("card_name")
            }
            sharedInstance1.database!.close()
            print(returnedCardName)
            return returnedCardName
        }
        print("Could not find Card")
        return "Could not find Card"
    }
    
    func getType(passedName: String, match_type: String) -> String{
        var returnedType = ""
        sharedInstance1.database!.open()
        
        var check_cardSet: FMResultSet!
        
        
        if match_type == "like"{
            
            check_cardSet  = sharedInstance1.database!.executeQuery("SELECT card_name, card_type FROM cards where card_name like \"%\(passedName)%\"", withArgumentsInArray: nil)
            
        }else if match_type == "exact"{
            check_cardSet = sharedInstance1.database!.executeQuery("SELECT card_name, card_type FROM cards where card_name = \"\(passedName)\"", withArgumentsInArray: nil)
        }
        
        if check_cardSet  != nil {
            while check_cardSet.next() {
                returnedType = check_cardSet.stringForColumn("card_type")
            }
            sharedInstance1.database!.close()
            print(returnedType)
            return returnedType
        }
        print("Could not find Card")
        return "Could not find Card"
    }
    
    func getAttribute(passedName: String, match_type: String) -> String{
        var returnedAttribute = ""
        sharedInstance1.database!.open()
        
        var check_cardSet: FMResultSet!
        
        
        if match_type == "like"{
            
            check_cardSet  = sharedInstance1.database!.executeQuery("SELECT card_name, attribute_type FROM cards where card_name like \"%\(passedName)%\"", withArgumentsInArray: nil)
            
        }else if match_type == "exact"{
            check_cardSet = sharedInstance1.database!.executeQuery("SELECT card_name, attribute_type FROM cards where card_name = \"\(passedName)\"", withArgumentsInArray: nil)
        }
        
        if check_cardSet  != nil {
            while check_cardSet.next() {
                returnedAttribute = check_cardSet.stringForColumn("attribute_type")
            }
            sharedInstance1.database!.close()
            print(returnedAttribute)
            return returnedAttribute
        }
        print("Could not find Card Attribute")
        return "Could not find Card Attribute"
    }
    
    func getSummonRequirements(passedName: String, match_type: String) -> String{
        var returnedSummonRequirements = ""
        sharedInstance1.database!.open()
        
        var check_cardSet: FMResultSet!
        
        
        if match_type == "like"{
            
            check_cardSet  = sharedInstance1.database!.executeQuery("SELECT card_name, summon_material_requirements FROM cards where card_name like \"%\(passedName)%\"", withArgumentsInArray: nil)
            
        }else if match_type == "exact"{
            check_cardSet = sharedInstance1.database!.executeQuery("SELECT card_name, summon_material_requirements FROM cards where card_name = \"\(passedName)\"", withArgumentsInArray: nil)
        }
        
        if check_cardSet  != nil {
            while check_cardSet.next() {
                returnedSummonRequirements = check_cardSet.stringForColumn("summon_material_requirements")
            }
            sharedInstance1.database!.close()
            print(returnedSummonRequirements)
            return returnedSummonRequirements
        }
        print("Could not find Card SummonRequirements")
        return "Could not find Card SummonRequirements"
    }
    
    func getDescription(passedName: String, match_type: String) -> String{
        var returnedDescription = ""
        sharedInstance1.database!.open()
        
        var check_cardSet: FMResultSet!
        
        
        if match_type == "like"{
            
            check_cardSet  = sharedInstance1.database!.executeQuery("SELECT card_name, description FROM cards where card_name like \"%\(passedName)%\"", withArgumentsInArray: nil)
            
        }else if match_type == "exact"{
            check_cardSet = sharedInstance1.database!.executeQuery("SELECT card_name, description FROM cards where card_name = \"\(passedName)\"", withArgumentsInArray: nil)
        }
        
        if check_cardSet  != nil {
            while check_cardSet.next() {
                returnedDescription = check_cardSet.stringForColumn("description")
            }
            sharedInstance1.database!.close()
            print(returnedDescription)
            return returnedDescription
        }
        print("Could not find Card Description")
        return "Could not find Card Description"
    }
    
    func getSpellSpeed(passedName: String, match_type: String) -> String{
        var returnedSpellSpeed = ""
        sharedInstance1.database!.open()
        
        var check_cardSet: FMResultSet!
        
        if match_type == "like"{
            
            check_cardSet  = sharedInstance1.database!.executeQuery("SELECT card_name, spell_speed FROM cards where card_name like \"%\(passedName)%\"", withArgumentsInArray: nil)
            
        }else if match_type == "exact"{
            check_cardSet = sharedInstance1.database!.executeQuery("SELECT card_name, spell_speed FROM cards where card_name = \"\(passedName)\"", withArgumentsInArray: nil)
        }
        
        if check_cardSet  != nil {
            while check_cardSet.next() {
                returnedSpellSpeed = check_cardSet.stringForColumn("spell_speed")
            }
            sharedInstance1.database!.close()
            print(returnedSpellSpeed)
            return returnedSpellSpeed
        }
        print("Could not find Card SpellSpeed")
        return "Could not find Card SpellSpeed"
    }
    
    func getLevel(passedName: String, match_type: String) -> String{
        var returnedLevel = ""
        sharedInstance1.database!.open()
        
        var check_cardSet: FMResultSet!
        
        if match_type == "like"{
            
            check_cardSet  = sharedInstance1.database!.executeQuery("SELECT card_name, level_stars FROM cards where card_name like \"%\(passedName)%\"", withArgumentsInArray: nil)
            
        }else if match_type == "exact"{
            check_cardSet = sharedInstance1.database!.executeQuery("SELECT card_name, level_stars FROM cards where card_name = \"\(passedName)\"", withArgumentsInArray: nil)
        }
        
        if check_cardSet  != nil {
            while check_cardSet.next() {
                returnedLevel = check_cardSet.stringForColumn("level_stars")
            }
            sharedInstance1.database!.close()
            print(returnedLevel)
            return returnedLevel
        }
        print("Could not find Card Level")
        return "Could not find Card Level"
    }
    
    func getRank(passedName: String, match_type: String) -> String{
        var returnedRank = ""
        sharedInstance1.database!.open()
        
        var check_cardSet: FMResultSet!
        
        
        if match_type == "like"{
            
            check_cardSet  = sharedInstance1.database!.executeQuery("SELECT card_name, rank_stars FROM cards where card_name like \"%\(passedName)%\"", withArgumentsInArray: nil)
            
        }else if match_type == "exact"{
            check_cardSet = sharedInstance1.database!.executeQuery("SELECT card_name, rank_stars FROM cards where card_name = \"\(passedName)\"", withArgumentsInArray: nil)
        }
        
        if check_cardSet  != nil {
            while check_cardSet.next() {
                returnedRank = check_cardSet.stringForColumn("rank_stars")
            }
            sharedInstance1.database!.close()
            print(returnedRank)
            return returnedRank
        }
        print("Could not find Card Rank")
        return "Could not find Card Rank"
    }
    
    func getAtk(passedName: String, match_type: String) -> String{
        var returnedAtk = ""
        sharedInstance1.database!.open()
        
        var check_cardSet: FMResultSet!
        
        
        if match_type == "like"{
            
            check_cardSet  = sharedInstance1.database!.executeQuery("SELECT card_name, atk_points FROM cards where card_name like \"%\(passedName)%\"", withArgumentsInArray: nil)
            
        }else if match_type == "exact"{
            check_cardSet = sharedInstance1.database!.executeQuery("SELECT card_name, atk_points FROM cards where card_name = \"\(passedName)\"", withArgumentsInArray: nil)
        }
        
        if check_cardSet  != nil {
            while check_cardSet.next() {
                returnedAtk = check_cardSet.stringForColumn("atk_points")
            }
            sharedInstance1.database!.close()
            print(returnedAtk)
            return returnedAtk
        }
        print("Could not find Card Atk")
        return "Could not find Card Atk"
    }
    
    func getDef(passedName: String, match_type: String) -> String{
        var returnedDef = ""
        sharedInstance1.database!.open()
        
        var check_cardSet: FMResultSet!
        
        
        if match_type == "like"{
            
            check_cardSet  = sharedInstance1.database!.executeQuery("SELECT card_name, def_points FROM cards where card_name like \"%\(passedName)%\"", withArgumentsInArray: nil)
            
        }else if match_type == "exact"{
            check_cardSet = sharedInstance1.database!.executeQuery("SELECT card_name, def_points FROM cards where card_name = \"\(passedName)\"", withArgumentsInArray: nil)
        }
        
        if check_cardSet  != nil {
            while check_cardSet.next() {
                returnedDef = check_cardSet.stringForColumn("def_points")
            }
            sharedInstance1.database!.close()
            print(returnedDef)
            return returnedDef
        }
        print("Could not find Card Def")
        return "Could not find Card Def"
    }
    
    func getSetini(passedName: String, match_type: String) -> String{
        var returnedSetini = ""
        sharedInstance1.database!.open()
        
        var check_cardSet: FMResultSet!
        
        
        if match_type == "like"{
            
            check_cardSet  = sharedInstance1.database!.executeQuery("SELECT card_name, setini FROM cards where card_name like \"%\(passedName)%\"", withArgumentsInArray: nil)
            
        }else if match_type == "exact"{
            check_cardSet = sharedInstance1.database!.executeQuery("SELECT card_name, setini FROM cards where card_name = \"\(passedName)\"", withArgumentsInArray: nil)
        }
        
        if check_cardSet  != nil {
            while check_cardSet.next() {
                returnedSetini = check_cardSet.stringForColumn("setini")
            }
            sharedInstance1.database!.close()
            print(returnedSetini)
            return returnedSetini
        }
        print("Could not find Card Setini")
        return "Could not find Card Setini"
    }
    
    func getSetNumber(passedName: String, match_type: String) -> String{
        var returnedSetNumber = ""
        sharedInstance1.database!.open()
        
        var check_cardSet: FMResultSet!
        
        
        if match_type == "like"{
            
            check_cardSet  = sharedInstance1.database!.executeQuery("SELECT card_name, set_number FROM cards where card_name like \"%\(passedName)%\"", withArgumentsInArray: nil)
            
        }else if match_type == "exact"{
            check_cardSet = sharedInstance1.database!.executeQuery("SELECT card_name, set_number FROM cards where card_name = \"\(passedName)\"", withArgumentsInArray: nil)
        }
        
        if check_cardSet  != nil {
            while check_cardSet.next() {
                returnedSetNumber = check_cardSet.stringForColumn("set_number")
            }
            sharedInstance1.database!.close()
            print(returnedSetNumber)
            return returnedSetNumber
        }
        print("Could not find Card SetNumber")
        return "Could not find Card SetNumber"
    }
    
    func getCardPass(passedName: String, match_type: String) -> String{
        var returnedCardPass = ""
        sharedInstance1.database!.open()
        
        var check_cardSet: FMResultSet!
        
        
        if match_type == "like"{
            
            check_cardSet  = sharedInstance1.database!.executeQuery("SELECT card_name, card_number FROM cards where card_name like \"%\(passedName)%\"", withArgumentsInArray: nil)
            
        }else if match_type == "exact"{
            check_cardSet = sharedInstance1.database!.executeQuery("SELECT card_name, card_number FROM cards where card_name = \"\(passedName)\"", withArgumentsInArray: nil)
        }
        
        if check_cardSet  != nil {
            while check_cardSet.next() {
                returnedCardPass = check_cardSet.stringForColumn("card_number")
            }
            sharedInstance1.database!.close()
            print(returnedCardPass)
            return returnedCardPass
        }
        print("Could not find Card CardPass")
        return "Could not find Card CardPass"
    }
    
    func getRarity(passedName: String, match_type: String) -> String{
        var returnedRarity = ""
        sharedInstance1.database!.open()
        
        var check_cardSet: FMResultSet!
        
        
        if match_type == "like"{
            
            check_cardSet  = sharedInstance1.database!.executeQuery("SELECT card_name, rarity FROM cards where card_name like \"%\(passedName)%\"", withArgumentsInArray: nil)
            
        }else if match_type == "exact"{
            check_cardSet = sharedInstance1.database!.executeQuery("SELECT card_name, rarity FROM cards where card_name = \"\(passedName)\"", withArgumentsInArray: nil)
        }
        
        if check_cardSet  != nil {
            while check_cardSet.next() {
                returnedRarity = check_cardSet.stringForColumn("rarity")
            }
            sharedInstance1.database!.close()
            print(returnedRarity)
            return returnedRarity
        }
        print("Could not find Card Rarity")
        return "Could not find Card Rarity"
    }
    
    func getLegality(passedName: String, match_type: String) -> String{
        var returnedLegality = ""
        sharedInstance1.database!.open()
        
        var check_cardSet: FMResultSet!
        
        
        if match_type == "like"{
            
            check_cardSet  = sharedInstance1.database!.executeQuery("SELECT card_name, legal_state FROM cards where card_name like \"%\(passedName)%\"", withArgumentsInArray: nil)
            
        }else if match_type == "exact"{
            check_cardSet = sharedInstance1.database!.executeQuery("SELECT card_name, legal_state FROM cards where card_name = \"\(passedName)\"", withArgumentsInArray: nil)
        }
        
        if check_cardSet  != nil {
            while check_cardSet.next() {
                returnedLegality = check_cardSet.stringForColumn("legal_state")
            }
            sharedInstance1.database!.close()
            print(returnedLegality)
            return returnedLegality
        }
        print("Could not find Card Legality")
        return "Could not find Card Legality"
    }
    
    func construct_image_url(var passed_SetInitial: String, passed_SetNumber: String) -> String{
        
        let url = NSURL(string: "http://yugiohprices.com/api/card_iamge/cyber stein")!
        let request = NSMutableURLRequest(URL: url)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if let response = response, data = data {
                print(response)
                print(String(data: data, encoding: NSUTF8StringEncoding))
            } else {
                print(error)
            }
        }
        
        task.resume()
        
        return ""
    }
    
    // Initiate array of YUGI Series
    var arrayOfSeries = [
        "Cancel",
        "All Series",
        "ARC-V",
        "Zexal",
        "5D",
        "GX",
        "Yugi",
        "Structure Decks",
        "Starter Decks",
        //"Duelist Packs",
        "Hidden Arsenal",
        "Other"
    ]
    
    // Initiate array of all Booster Sets
    var arrayOfSets = ["Cancel", "All Booster Sets",
        "Shining Victories",
        "Duelist Pack: Battle City",
        "Dragons of Legend 2",
        "Star Pack ARC-V",
        "Crossed Souls",
        "The Secret Forces",
        "Secrets of Eternity",
        "Noble Knights of the Round Table",
        "The New Challengers",
        "Duelist Alliance ",
        "Battle Pack 3: Monster league",
        "Primal Origin",
        "Dragons of Legend",
        "Legacy of the Valiant",
        "Shadow Specters",
        "Judgment of the Light",
        "Number Hunters",
        "Lord of the Tachyon Galaxy",
        "Hidden Arsenal 7: Knight of Stars",
        "Cosmo Blazer",
        "Abyss Rising",
        "Return of the Duelist",
        "Hidden Arsenal 6: Omega Xyz",
        "Galactic Overlord",
        "Order of Chaos",
        "Hidden Arsenal 5: Steelswarm Invasion",
        "Photon Shockwave",
        "Generation Force",
        "Extreme Victory",
        "Hidden Arsenal 4: Trishula\'s Triumph",
        "Storm of Ragnarok",
        "Hidden Arsenal 3",
        "Starstrike Blast",
        "Duelist Revolution",
        "Hidden Arsenal 2",
        "The Shining Darkness",
        "Absolute Powerforce",
        "Hidden Arsenal",
        "Stardust Overdrive",
        "Ancient Prophecy",
        "Raging Battle",
        "Crimson Crisis",
        "Crossroads of Chaos",
        "The Duelist Genesis",
        "Light of Destruction",
        "Phantom Darkness",
        "Gladiator\'s Assault",
        "Tactical Evolution",
        "Force of the Breaker",
        "Strike of Neos",
        "CyberDark Impact",
        "Power of the Duelist",
        "Enemy of Justice",
        "Shadow of Infinity",
        "Elemental Energy",
        "Cybernetic Revolution",
        "The Lost Millennium",
        "Flaming Eternity",
        "Rise of Destiny",
        "Soul of the Duelist",
        "Ancient Sanctuary",
        "Invasion of Chaos",
        "Dark Crisis",
        "Magician\'s Force",
        "Pharaonic Guardian",
        "Legacy of Darkness",
        "Labyrinth of Nightmare",
        "Pharaoh\'s Servant",
        "Spell Ruler",
        "Metal Raiders",
        "Legend of Blue Eyes White Dragon",
        "Shonen Jump",
        "Dark Legion Starter Deck",
        "Saber Force Starter Deck",
        "Super Starter: Space-Time Showdown",
        "Starter Deck: Yugi Reloaded",
        "Starter Deck: Kaiba Reloaded",
        "Super Starter: V for Victory",
        "Starter Deck: Xyz Symphony",
        "Starter Deck: Dawn of the Xyz",
        "Yu-Gi-Oh! 5D\'s Duelist Toolbox",
        "Yu-Gi-Oh! 5D\'s Starter Deck 2009",
        "Yu-Gi-Oh! 5D\'s Starter Deck",
        "Starter Deck: Jaden Yuki",
        "Starter Deck: Syrus Truesdale",
        "Yugi Starter Deck",
        "Starter Deck: Kaiba Evolution",
        "Starter Deck: Yugi Evolution",
        "Starter Deck: Pegasus",
        "Starter Deck: Joey",
        "Starter Deck: Kaiba",
        "Starter Deck: Yugi",
        "HERO Strike",
        "Geargia Rampage",
        "Realm of Light",
        "Cyber Dragon Revolution",
        "Saga of Blue-Eyes White Dragon",
        "Onslaught of the Fire Kings",
        "Realm of the Sea Emperor",
        "Samurai Warlords",
        "Dragons Collide",
        "Gates of the Underworld",
        "Lost Sanctuary",
        "Dragunity Legion",
        "Marik",
        "Machina Mayhem",
        "Warrior\'s Strike",
        "Spellcaster\'s Command",
        "Zombie World",
        "Dark Emperor",
        "Rise of the Dragon Lords",
        "Machine Re-volt",
        "Dinosaur\'s Rage",
        "Lord of the Storm",
        "Invincible Fortress",
        "Spellcaster\'s Judgement",
        "Warrior\'s Triumph",
        "Blaze of Destruction",
        "Fury from the Deep",
        "Zombie Madness",
        "Dragon\'s Roar"
]
    
    // Initiate array of all ARC-V Booster Sets
    var sets_ARCV = [
        "Cancel",
        "All Booster Sets",
        "Shining Victories",
        "Duelist Pack: Battle City",
        "Dragons of Legend 2",
        "Star Pack ARC-V",
        "Crossed Souls",
        "The Secret Forces",
        "Secrets of Eternity",
        "Noble Knights of the Round Table",
        "The New Challengers",
        "Duelist Alliance ",
        "Battle Pack 3: Monster league"
    ]
    
    // Initiate array of all ZEXAL Booster Sets
    var sets_ZEXAL = [
        "Cancel",
        "All Booster Sets",
        "Primal Origin",
        "Dragons of Legend",
        "Legacy of the Valiant",
        "Shadow Specters",
        "Judgment of the Light",
        "Number Hunters",
        "Lord of the Tachyon Galaxy",
        "Hidden Arsenal 7: Knight of Stars",
        "Cosmo Blazer",
        "Abyss Rising",
        "Return of the Duelist",
        "Hidden Arsenal 6: Omega Xyz",
        "Galactic Overlord",
        "Order of Chaos",
        "Hidden Arsenal 5: Steelswarm Invasion",
        "Photon Shockwave",
        "Generation Force"
    ]
    
    // Initiate array of all 5D Booster Sets
    var sets_5D = [
        "Cancel",
        "All Booster Sets",
        "Extreme Victory",
        "Hidden Arsenal 4: Trishula\'s Triumph",
        "Storm of Ragnarok",
        "Hidden Arsenal 3",
        "Starstrike Blast",
        "Duelist Revolution",
        "Hidden Arsenal 2",
        "The Shining Darkness",
        "Absolute Powerforce",
        "Hidden Arsenal",
        "Stardust Overdrive",
        "Ancient Prophecy",
        "Raging Battle",
        "Crimson Crisis",
        "Crossroads of Chaos",
        "The Duelist Genesis"
    ]
    
    // Initiate array of all GX Booster Sets
    var sets_GX = [
        "Cancel",
        "All Booster Sets",
        "Light of Destruction",
        "Phantom Darkness",
        "Gladiator\'s Assault",
        "Tactical Evolution",
        "Force of the Breaker",
        "Strike of Neos",
        "CyberDark Impact",
        "Power of the Duelist",
        "Enemy of Justice",
        "Shadow of Infinity",
        "Elemental Energy",
        "Cybernetic Revolution",
        "The Lost Millennium"
    ]
    
    // Initiate array of all YUGI Booster Sets
    var sets_YUGI = [
        "Cancel",
        "All Booster Sets",
        "Flaming Eternity",
        "Rise of Destiny",
        "Soul of the Duelist",
        "Ancient Sanctuary",
        "Invasion of Chaos",
        "Dark Crisis",
        "Magician\'s Force",
        "Pharaonic Guardian",
        "Legacy of Darkness",
        "Labyrinth of Nightmare",
        "Pharaoh\'s Servant",
        "Spell Ruler",
        "Metal Raiders",
        "Legend of Blue Eyes White Dragon"
    ]
    
    // Initiate array of all Hidden Arsenal packs
    var sets_HIDDEN_ARSENALS = [
        "Cancel",
        "All Booster Sets",
        "Hidden Arsenal 7: Knight of Stars",
        "Hidden Arsenal 6: Omega Xyz",
        "Hidden Arsenal 5: Steelswarm Invasion",
        "Hidden Arsenal 4: Trishula\'s Triumph",
        "Hidden Arsenal 3",
        "Hidden Arsenal 2",
        "Hidden Arsenal"
    ]
    
    // Initiate array of all Starter Decks
    var sets_STARTER_DECKS = [
        "Cancel",
        "All Booster Sets",
        "Dark Legion Starter Deck",
        "Saber Force Starter Deck",
        "Super Starter: Space-Time Showdown",
        "Starter Deck: Yugi Reloaded",
        "Starter Deck: Kaiba Reloaded",
        "Super Starter: V for Victory",
        "Starter Deck: Xyz Symphony",
        "Starter Deck: Dawn of the Xyz",
        "Yu-Gi-Oh! 5D\'s Duelist Toolbox",
        "Yu-Gi-Oh! 5D\'s Starter Deck 2009",
        "Yu-Gi-Oh! 5D\'s Starter Deck",
        "Starter Deck: Jaden Yuki",
        "Starter Deck: Syrus Truesdale",
        "Yugi Starter Deck",
        "Starter Deck: Kaiba Evolution",
        "Starter Deck: Yugi Evolution",
        "Starter Deck: Pegasus",
        "Starter Deck: Joey",
        "Starter Deck: Kaiba",
        "Starter Deck: Yugi"
    ]
    
    // Initiate array of all Structure Decks
    var sets_STRUCTURE_DECKS = [
        "Cancel",
        "All Booster Sets",
        "HERO Strike",
        "Geargia Rampage",
        "Realm of Light",
        "Cyber Dragon Revolution",
        "Saga of Blue-Eyes White Dragon",
        "Onslaught of the Fire Kings",
        "Realm of the Sea Emperor",
        "Samurai Warlords",
        "Dragons Collide",
        "Gates of the Underworld",
        "Lost Sanctuary",
        "Dragunity Legion",
        "Marik",
        "Machina Mayhem",
        "Warrior\'s Strike",
        "Spellcaster\'s Command",
        "Zombie World",
        "Dark Emperor",
        "Rise of the Dragon Lords",
        "Machine Re-volt",
        "Dinosaur\'s Rage",
        "Lord of the Storm",
        "Invincible Fortress",
        "Spellcaster\'s Judgement",
        "Warrior\'s Triumph",
        "Blaze of Destruction",
        "Fury from the Deep",
        "Zombie Madness",
        "Dragon\'s Roar"
    ]
    
    // Initiate array of Other sets
    var sets_OTHER = [
        "Cancel",
        "All Booster Sets",
        "Shonen Jump"
    ]
    
    var sets_DUELIST_PACKS = [
        "Cancel",
        "Duelist Pack: Yuki"
    ]
    
    // Initiate array of all Main Card Types
    var cardTypes_DEFAULT = [
        "Cancel",
        "Clear",
        "Monster",
        "Spell",
        "Trap"
    ]
    
    // Initiate array of Monster Card type
    var subCardTypes = [
        "Cancel",
        "Search all below monster card types",
        "Normal",
        "Effect",
        "Ritual",
        "Fusion",
        "Synchro",
        "Xyz"
    ]
    
    // Initiate array of Attributes
    var ATTRIBUTES = [
        "Cancel",
        "Search All Attributes",
        "Dark",
        "Divine",
        "Earth",
        "Fire",
        "Light",
        "Water",
        "Wind"
    ]

    
    // Initiate array of all sub card types of Spell cards
    var subTypes_SPELL = [
        "Cancel",
        "Search All Spell Types",
        "Normal",
        "Continuous",
        "Equip",
        "QuickPlay",
        "Field",
        "Ritual"
    ]

    
    // Initiate array of all sub card types of Trap cards
    var sub_TYPES_TRAP = [
        "Cancel",
        "Search All Trap Types",
        "Normal",
        "Continuous",
        "Counter"
    ]
    
    // Initiate array of secondary monster type
    var sub_TYPES_MONSTER = [
        "Cancel",
        "Search All Primary Monster Types",
        "Aqua",
        "Beast",
        "Beast-Warrior",
        "Dinosaur",
        "Divine-Beast",
        "Dragon",
        "Fairy",
        "Fiend",
        "Fish",
        "Insect",
        "Machine",
        "Plant",
        "Psychic",
        "Pyro",
        "Reptile",
        "Rock",
        "Sea Serpent",
        "Spellcaster",
        "Thunder",
        "Warrior",
        "Winged Beast",
        "Zombie"
    ]
    
    // Initiate array of 2nd secondary monster types
    var sub_TYPES_SECONDARY_MONSTER = [
        "Cancel",
        "Search All Secondary Monster Types",
        "Pendulum",
        "Gemini",
        "Spirit",
        "Toon",
        "Tuner",
        "Union"
    ]

    
    var arrayOfLevel_Rank = ["Cancel","Search All Levels & Ranks", "1","2","3","4","5","6","7","8","9","10","11","12"]
    
                                    // Alert Titles and Messages
    // Advance Search - Primary Card Type
    var cardType_AlterTitle = "Select a primary card type"
    var cardType_AlertMessage = "This includes Monster, Spell, & Trap"
    
    // Advance Search - Secondary Card Type(Monster Cards Only(Effect, Ritual, Normal, etc))
    var cardSecondaryCardType_AlertTitle = "Select a secondary card type"
    var cardSecondaryCardType_AlertMessage = "Example: Effect, Normal, etc"
    
    // Advance Search - Monster Card Type
    var cardMonsterCardType_AlertTitle = "12"
    var cardMonsterCardType_AlertMessage = "12"
    
    // Advance Search - Secondary Monster Card Type
    var cardSecondaryMonsterCardType_AlertTitle = "13"
    var cardSecondaryMonsterCardType_AlertMessage = "13"
    
    // Advance Search - Attribute Type
    var cardAttributeType_AlertTitle = "14"
    var cardAttributeType_AlertMessage = "14"
    
    // Advance Search - Level/Rank Type
    var cardLevelRankType_AlertTitle = "15"
    var cardLevelRankType_AlertMessage = "15"
    
    // Advance Search - Selected Card Set
    var cardSelectedCardSet_AlertTitle = "Select a card set"
    var cardSelectedCardSet_AlertMessage = "This includes boosters, starter/structure decks, special packs, etc"
}