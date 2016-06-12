//: [Previous](@previous)

import Foundation


enum Sample: Int {
    case A
    
    @available(*, unavailable)
    var rawValue: Int { return 1 }
}

func sampleFunc<T: RawRepresentable>(param: T) -> T.RawValue {
    return param.rawValue
}
print(sampleFunc(Sample.A))
let sample0 = Sample(rawValue: 0)
let sample1 = Sample(rawValue: 1)

struct MyNumber {
    var value = 0

    @warn_unused_result(mutable_variant="increment")
    func incremented() -> Int {
        return value + 1
    }
    
    mutating func increment() {
        value += 1
    }
}

var number = MyNumber()
number.incremented()

let count = 5.0
let numbers = "2 3 5 4 1".componentsSeparatedByString(" ").sort { Int($0)! > Int($1)! }
numbers[Int(count*0.5) + 1]
//: [Next](@next)
