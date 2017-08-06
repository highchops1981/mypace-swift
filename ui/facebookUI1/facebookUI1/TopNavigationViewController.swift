//
//  TopNavigationViewController.swift
//  facebookUI1
//
//  Created by ishikura keisuke on 2016/10/16.
//  Copyright © 2016年 ishikura keisuke. All rights reserved.
//

import UIKit

class TopNavigationViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for subview1 in searchBar.subviews {
            for subview2 in subview1.subviews {
                if(subview2.isKind(of: UIImageView.self)){
                    let imageView:UIImageView = subview2 as! UIImageView
                    imageView.alpha = 0
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

