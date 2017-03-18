//
//  Model.swift
//  ImageBrowser
//
//  Created by Rochester on 18/3/17.
//  Copyright © 2017年 Rochester. All rights reserved.
//

import UIKit

class Model: NSObject {
    var hd_thumb_url : String = ""
    var thumb_url : String = ""
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
