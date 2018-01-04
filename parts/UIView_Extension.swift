//
//  UIView_Extension.swift
//  PackeT-SBX-iOS
//
//  Created by keisuke ishikura on 2017/10/19.
//  Copyright © 2017年 SoftBank. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func moveCenterAndShrinkAndExpansionView(view: UIView, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, completion: @escaping () -> Void) {
        
        let width = width
        let height = height
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            
            view.center = CGPoint(x: x, y: y)
            view.bounds.size = CGSize(width:CGFloat(width), height:CGFloat(height))
            
        }) { _ in
            
            completion()
            
        }
    }

    func moveCenterAndShrinkAndExpansionView(view: UIView, x: CGFloat, y: CGFloat, rate: Double, completion: @escaping () -> Void) {
        
        let width = Double(view.bounds.width) * rate
        let height = Double(view.bounds.height) * rate
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            
            view.center = CGPoint(x: x, y: y)
            view.bounds.size = CGSize(width:CGFloat(width), height:CGFloat(height))
            
        }) { _ in
            
            completion()
            
        }
    }

    func moveView(view: UIView, x: CGFloat, y: CGFloat, completion: @escaping () -> Void) {
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            
            view.frame =  CGRect(x:x, y:y, width:view.bounds.width, height:view.bounds.height)
            
        }) { _ in
            
            completion()
            
        }
        
    }
    
}
