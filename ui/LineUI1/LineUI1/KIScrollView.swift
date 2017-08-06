//
//  KIScrollView.swift
//  LineUI1
//
//  Created by ishikura keisuke on 2016/10/11.
//  Copyright © 2016年 ishikura keisuke. All rights reserved.
//

import UIKit

class KIScrollView: UIScrollView {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        superview?.touchesBegan(touches, with: event)
    }
    
}
