//
//  ViewController.swift
//  shimmer
//
//  Created by keisuke ishikura on 2018/05/22.
//  Copyright © 2018年 mypace. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var SlideToAnswer: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let light = UIColor.white.cgColor
        let dark = UIColor.black.cgColor
        
        let gradient = CAGradientLayer()
        gradient.colors = [dark, light, dark]
        gradient.frame = CGRect(x: 0, y: 0, width: 375, height: 92)
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.locations = [0.0, 0.5, 1.0]
        SlideToAnswer.layer.addSublayer(gradient)
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.0, 0.25]
        animation.toValue = [0.75, 1.0, 1.0]
        animation.duration = 2.0
        animation.repeatCount = HUGE
        gradient.add(animation, forKey: "shimmer")
        
        let maskLayer = CATextLayer()
        maskLayer.frame = CGRect(x: 0, y: 0, width: SlideToAnswer.frame.size.width, height: SlideToAnswer.frame.size.height)
        maskLayer.string = SlideToAnswer.text
        maskLayer.font = SlideToAnswer.font
        maskLayer.fontSize = SlideToAnswer.font.pointSize
        maskLayer.alignmentMode = kCAAlignmentCenter
        maskLayer.contentsScale = UIScreen.main.scale
        gradient.mask = maskLayer
    }

}

