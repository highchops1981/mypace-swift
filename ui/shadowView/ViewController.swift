//
//  ViewController.swift
//  temp
//
//  Created by ishikura keisuke on 2017/10/23.
//  Copyright © 2017年 ishikura keisuke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    var testSpeed = 0.0
    var shadowTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        shadowTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.showTimer), userInfo: nil, repeats: true)
        shadowTimer.fire()
        
        
    }

    @objc func showTimer(){
        
        let nowSpeed = testSpeed
        showShadow(speed: nowSpeed )
        
        testSpeed = Double(arc4random_uniform(99))
        
        
    }

    func showShadow(speed:Double) {
        
        //G<=-(-350+(90*r))*ra/350
        //if r == 0.8 && ra == 60 G<=47.0
        //if r == 0.7 && ra == 60 G<=49.0
        //G<=(418-(90*r))*ra/418
        //if r == 1.2 && ra == 70 G<=51.0
        //if r == 1.3 && ra == 70 G<=50.0
        
        let nowSpeed = speed
        
        // const
        let viewHeight = Double(self.view.frame.size.height)
        let viewWidth = Double(self.view.frame.size.width)
        let halfOfViewHeight = viewHeight / 2
        let defaultCarCenterPosY = 300.0
        let maxSpeedOffset = 60.0
        let minSpeedOffset = 70.0
        let carHeight = 90.0
        let halfOfCarHeight = carHeight / 2
        let expansionRatio = 0.5
        let reductionRatio = 0.5
        let bestSpeed = 30.0
        let workingRangTop = (halfOfViewHeight - defaultCarCenterPosY) + (halfOfCarHeight * (1.0 - reductionRatio))
        let workingRangBottom = viewHeight + (halfOfViewHeight - defaultCarCenterPosY) - (halfOfCarHeight * (1.0 + expansionRatio))
        
        // var
        let gapSpeedWithBest = bestSpeed - nowSpeed
        var minusCarPos = (gapSpeedWithBest) * defaultCarCenterPosY / maxSpeedOffset
        var plusCarPos = (gapSpeedWithBest) * (viewHeight - defaultCarCenterPosY) / minSpeedOffset
        
        if minusCarPos > 0 {
            
            minusCarPos = minusCarPos * -1
            
        }
        
        if plusCarPos < 0 {
            
            plusCarPos = plusCarPos * -1
            
        }
        
        minusCarPos = minusCarPos + halfOfViewHeight
        plusCarPos = plusCarPos + halfOfViewHeight
        var minusCarRate = reductionRatio / maxSpeedOffset * (gapSpeedWithBest)
        var plusCarRate = expansionRatio / minSpeedOffset * (gapSpeedWithBest)
        
        if minusCarRate > 0 {
            
            minusCarRate = minusCarRate * -1
            
        }
        
        if plusCarRate < 0 {
            
            plusCarRate = plusCarRate * -1
            
        }
        
        var myCarPosY = halfOfViewHeight
        var shadowPosY = halfOfViewHeight
        var myCarRate = 1.0
        var shadowRate = 1.0
        
        if gapSpeedWithBest > 0 {
            
            myCarPosY = plusCarPos
            shadowPosY = minusCarPos
            myCarRate = myCarRate + plusCarRate
            shadowRate = shadowRate + minusCarRate
            
        } else {
            
            myCarPosY = minusCarPos
            shadowPosY = plusCarPos
            myCarRate = myCarRate + minusCarRate
            shadowRate = shadowRate + plusCarRate
            
        }
        
        if myCarPosY < workingRangTop {
            
            myCarPosY = workingRangTop
            myCarRate = 1.0 - reductionRatio
            
        } else if myCarPosY > workingRangBottom {
            
            myCarPosY = workingRangBottom
            myCarRate = 1.0 + expansionRatio
            
        }
        
        if shadowPosY < workingRangTop {
            
            shadowPosY = workingRangTop
            shadowRate = 1.0 - reductionRatio
            
        } else if shadowPosY > workingRangBottom {
            
            shadowPosY = workingRangBottom
            shadowRate = 1.0 + expansionRatio
            
        }
        
        let myCarHeight = viewHeight * myCarRate
        let myCarWidth = viewWidth * myCarRate
        let shadowHeight = viewHeight * shadowRate
        let shadowWidth = viewWidth * shadowRate
        
        self.view.moveCenterAndShrinkAndExpansionView(view: view1, x: (CGFloat(viewWidth / 2)), y:CGFloat(myCarPosY), width: CGFloat(myCarWidth), height: CGFloat(myCarHeight), completion: {() -> Void in
        })
        
        self.view.moveCenterAndShrinkAndExpansionView(view: view2, x: (CGFloat(viewWidth / 2)), y:CGFloat(shadowPosY),width: CGFloat(shadowWidth), height: CGFloat(shadowHeight), completion: {() -> Void in
        })
        
    }

    deinit {
        shadowTimer.invalidate()
    }

}

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


