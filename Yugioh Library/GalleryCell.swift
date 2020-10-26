//
//  GalleryCell.swift
//  Yugioh Library
//
//  Created by Matt on 5/20/16.
//  Copyright © 2016 CybertechApps. All rights reserved.
//

import Foundation
import UIKit

class GalleryCell: UICollectionViewCell {
    
    @IBOutlet var collection_image: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Increment the generation when the cell is recycled
        
        
        collection_image.hnk_cancelSetImage()
        collection_image.image = nil
        
    }
}
