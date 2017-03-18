//
//  RRCell.swift
//  ImageBrowser
//
//  Created by Rochester on 18/3/17.
//  Copyright © 2017年 Rochester. All rights reserved.
//

import UIKit
import Kingfisher
class RRCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    var model : Model?{
        didSet{
//            print(model?.hd_thumb_url)
            guard let url = URL(string: model?.hd_thumb_url ?? "") else{return}
            
//            print(url)
            image.kf.setImage(with: url)
            
            

        }
    }
}
