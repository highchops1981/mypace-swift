//: Playground - noun: a place where people can play

import Cocoa

class PensionTypeInvestimentProducts {
    
    var year:Double = 0.0
    var cashEveryYear:Double = 0.0
    var discountRate:Double = 0.0
    
    func calcPensionTypeInvestimentProducts() -> Double {
        
        var presentValue:Double = 0.0
        
        presentValue = cashEveryYear * ( (1.0 / discountRate ) - ( 1.0 / (discountRate * pow(( 1 + discountRate ), year ))))
        
        return presentValue
        
    }
    
}

let pensionTypeInvestimentProducts = PensionTypeInvestimentProducts()

pensionTypeInvestimentProducts.year = 5.0
pensionTypeInvestimentProducts.cashEveryYear = 1000000.0
pensionTypeInvestimentProducts.discountRate = 0.03

print(pensionTypeInvestimentProducts.calcPensionTypeInvestimentProducts())
