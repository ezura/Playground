//: [Previous](@previous)

import Foundation

class SampleClass<T> {
    init() {}
    init(_ param: T) {}
}

String(SampleClass<String>())
// "SampleClass<Swift.String>"

String(SampleClass("aaa"))
// "SampleClass<Swift.String>"

String(SampleClass(1))
 // "SampleClass<Swift.Int>"

String(SampleClass(1).dynamicType)
// "SampleClass<Int>"

String(SampleClass<Int>.self)
// "SampleClass<Int>"

String(SampleClass<Swift.Int>.self)
// "SampleClass<Int>"



class SampleClass2<T: RawRepresentable where T.RawValue == Int> {
    init() {}
}

enum MyEnum: Int {
    case A
}

// "SampleClass2<MyEnum>"
String(SampleClass2<MyEnum>())
String(SampleClass2<MyEnum>().dynamicType)
String(SampleClass2<MyEnum>.self)

//: [Next](@next)
