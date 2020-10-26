//
//  CardInfo_Cell_aboutBanlist.swift
//  Yugioh Library
//
//  Created by Matthew White on 1/14/16.
//  Copyright © 2016 CybertechApps. All rights reserved.
//

import Foundation

class CardInfo_Cell_aboutBanlist: UITableViewCell {
    
    
    
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
    
}
