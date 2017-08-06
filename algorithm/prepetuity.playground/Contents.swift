//
//Sum of infinite equi-ratio sequences
//

import Cocoa

class Perpetuity {
    
    var discountRate:Double = 0;
    var futureValueEveryYear:Double = 0;
    
    func calcPerpetuity() -> Double {
        
        var presentValue:Double = 0
        
        presentValue = futureValueEveryYear / discountRate
        
        return presentValue;
        
    }
    
}

let perpetuity = Perpetuity()

perpetuity.discountRate = 0.05
perpetuity.futureValueEveryYear = 1000000

print(perpetuity.calcPerpetuity())
