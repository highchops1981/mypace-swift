//: Playground - noun: a place where people can play

import Cocoa

class GrowthPerpetuity {
    
    var discountRate:Double = 0
    var cashEveryYear:Double = 0
    var growthRate:Double = 0
    
    func calcGrowthPerpetuity() -> Double {
        
        var presentValue:Double = 0
        
        presentValue = cashEveryYear / ( discountRate - growthRate )
        
        return presentValue
        
    }
    
}

let perpetuity = GrowthPerpetuity()

perpetuity.discountRate = 0.05
perpetuity.cashEveryYear = 1000000
perpetuity.growthRate = 0.03


print(perpetuity.calcGrowthPerpetuity())
