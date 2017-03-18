//
//  RRDetailCell.swift
//  ImageBrowser
//
//  Created by Rochester on 18/3/17.
//  Copyright © 2017年 Rochester. All rights reserved.
//

import UIKit
import Kingfisher
class RRDetailCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    
    var model : Model?{
        didSet{
            guard let url = URL(string:model?.hd_thumb_url ?? "") else {
                return
            }
            image.kf.setImage(with: url)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        image.isUserInteractionEnabled = true
        
    }

}
