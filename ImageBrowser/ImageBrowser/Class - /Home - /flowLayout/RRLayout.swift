//
//  RRLayout.swift
//  ImageBrowser
//
//  Created by Rochester on 18/3/17.
//  Copyright © 2017年 Rochester. All rights reserved.
//

import UIKit

class RRLayout: UICollectionViewFlowLayout {
    override func prepare() {
        self.itemSize = UIScreen.main.bounds.size
        self.scrollDirection = .horizontal
        
        self.minimumLineSpacing = 10
        collectionView?.isPagingEnabled = true
    }
}
