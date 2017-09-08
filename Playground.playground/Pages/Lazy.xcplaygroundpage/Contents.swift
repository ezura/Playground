//: [Previous](@previous)

import Foundation

public class Lazy<T> {
    private let initializer: () -> T
    
    private var _value: T!
    public var value: T {
        // TODO: mutex
        switch _value {
        case .none:
            _value = initializer()
            return _value
        case .some(let v):
            return v
        }
    }
    
    public init(initializer: @escaping () -> T) {
        self.initializer = initializer
    }

//    subscript(v: Void) -> T {
//        return value
//    }
}

func lazy<T>(initializer: @escaping () -> T) -> Lazy<T> {
    return Lazy(initializer: initializer)
}

struct A {
    init() { print("call `A.init`") }
}
class B {
    let v1 = lazy { return nil as Optional<A> } // ❗️self making
    lazy var v2 = { return A() }() // swift's `lazy`
}

let b = B()
print("will call `B.v1`", #line)
b.v1.value  // A()
print("will call `B.v1`", #line)
b.v1.value  // A()
print("will call `B.v1`", #line)
b.v1.value  // A()
print()
print("will call `B.v2`", #line)
b.v2  // A()
print("will call `B.v2`", #line)
b.v2  // A()
print("will call `B.v2`", #line)
b.v2  // A()

/* ## output
 will call `B.v1` 59
 call `A.init` <- ❗️call `init` once
 will call `B.v1` 61
 will call `B.v1` 63
 
 will call `B.v2` 66
 call `A.init` <- ❗️call `init` once
 will call `B.v2` 68
 will call `B.v2` 70
 */

//: [Next](@next)
