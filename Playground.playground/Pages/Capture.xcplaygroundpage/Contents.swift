//: [Previous](@previous)

import Foundation

class A {
    var x = 0
    
    deinit {
        print("deinit")
    }
    
    func sample() {
//        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
//            print(self.a.x)
//        }
        
    }
}


do {
    let a = A()
}

sleep(2)
//: [Next](@next)
