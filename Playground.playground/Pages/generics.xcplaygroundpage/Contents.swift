//: [Previous](@previous)

import Foundation

class A<T> {
    var data: T?
}

enum C {
    case Q
    static let count = 5
}

class B: A<Int> {}

let a = A<String>()
let b = B()

//: [Next](@next)
