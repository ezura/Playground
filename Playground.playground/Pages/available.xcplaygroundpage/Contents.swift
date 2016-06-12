//: [Previous](@previous)

import Foundation

//: # @available

/*:
 ## platform
 ### 種類
 * iOS
 * iOSApplicationExtension
 * OSX
 * OSXApplicationExtension
 * watchOS
 * watchOSApplicationExtension
 * tvOS
 * tvOSApplicationExtension
 * \* (全ての platform)
 
 ### フォーマット
 * <# platform #> <# version number #>
 * <# platform #>
 */
do {
    @available(iOS 10, OSX 10, *)
    class A {}
    if #available(iOS 10, *) {
        let a = A()
    } else {
        // Fallback on earlier versions
    }
}

do {
    @available(iOS, deprecated=8.0)
    func sample() {}
    sample()
}

class A {
    func sample2() {}
}
@available(iOS 10.0, OSX 10.10, *)
extension A {
    func sample() {}
}

let a = A()
a.sample2()
a.sample()

do {
    enum MyEunm {
        case A
        @available(iOS 10.0, OSX 10.10, *)
        case B, C
//        case C
    }
    
    if #available(iOS 10.0, *) {
        MyEunm.B
    } else {
        // Fallback on earlier versions
    }
    
    MyEunm.C
}



enum Sample: Int {
    case A
    
    @available(*, unavailable)
    var rawValue: Int { return 0 }
}

func sampleFunc<T: RawRepresentable>(param: T) -> T.RawValue {
    return param.rawValue
}
print(sampleFunc(Sample.A))

let c: RawRepresentable = Sample.A
c.rawValue
/*:
 ## 可用性
 ### 種類
 * unavailable: 使用不可能
 * introduced : 使用可能
 * deprecated : 非推奨
 * obsoleted  : 廃止
 
 ### フォーマット
 <# availability #>=<# version number #>
 */
do {
    @available(iOS, obsoleted=10, introduced=9)
    @available(OSX, unavailable)
    func sample() {}
    sample()
}

do {
    @available(iOS, introduced=10.0)
    func sample() {}
    sample()
}

do {
    @available(iOS, deprecated=8.0)
    func sample() {}
    sample()
}

do {
    @available(iOS, obsoleted=8.0)
    func sample() {}
    sample()
}

/*:
 ## その他の付与情報
 * message
 * renamed
 */
do {
    @available(iOS, deprecated=8.0, message="deprecated (ﾟωﾟ)")
    func sample() {}
    sample()
}

do {
    @available(*, unavailable, renamed="newFunc")
    func oldFunc() {}
    func newFunc() {}
    
    newFunc()
}

do {
    @available(*, unavailable, renamed="newFunc(xx:)")
    @noreturn
    func oldFunc(x x: Int) -> Int { return 0 }
    func newFunc(xx xx: Int) {}
    
    oldFunc(x: 1)
}


//: [Next](@next)
