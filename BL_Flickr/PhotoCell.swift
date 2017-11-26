//
//  PhotoCell.swift
//  BL_Flickr
//
//  Created by Алексей Россошанский on 24.11.17.
//  Copyright © 2017 Alexey Rossoshansky. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
    
}
