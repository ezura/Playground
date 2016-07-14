//: [Previous](@previous)

import Foundation

struct A {}

extension String {
    init?(_ convertFromRawData: A) {
        self = "( 'ω')"
    }
    
    // えらーがまずありえないばあい
//    init(_ a: A) {
//        guard xxx else {
//            fatalError()
//        }
//    }
    
    // エラーもじゅうぶんありうるばあい
    init(convertFromRawData a: A) throws {
        guard xxx else {
            throw XXX()
        }
    }
    
    // エラー、へんかんできるかいなか、りょうほうとりうるばあい
    init(_ a: Any) {
        if a is CellPrintable {
            
        }
        else {
            
        }
    }
    
    init<T:CellPrintable>(_ a: T) {
        
    }
}

let a = A()    // A
String(a)      // "( 'ω')"
String(a) + "^^" // "A()^^"

//: [Next](@next)

struct Yen {
    
    var price: Double
    
    init(_ price: Double, kind: Kind) {
        
    }
}

let prince = Yen()
let message = "きんがくは" + String(price) + "です"


