//
//  CardInfo_Cell.swift
//  Yugioh Library
//
//  Created by Matthew White on 10/29/15.
//  Copyright © 2015 CybertechApps. All rights reserved.
//

import Haneke
import UIKit

struct MyCellData {
    let url: String
}


class CardInfo_Cell: UITableViewCell {
    
    var card_image_url = ""
    
    // The generation will tell us which iteration of the cell we're working with
    var generation: Int = 0
    
    
    
    @IBOutlet weak var card_nameLabel: UILabel!
    
    
    @IBOutlet weak var advance_Search_cardNameLabel: UILabel!
    
    @IBOutlet weak var card_imageIV: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
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

    override func prepareForReuse() {
        super.prepareForReuse()
        // Increment the generation when the cell is recycled
        
        
        card_imageIV.image = nil
        //card_imageIV.hnk_cancelSetImage()
    }
}
