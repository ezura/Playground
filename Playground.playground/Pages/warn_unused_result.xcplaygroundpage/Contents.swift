//: [Previous](@previous)

import Foundation

struct MyNumber {
    var value = 0
    // 返り値使わなかったら警告だしてくれる
    // さらに、mutable_variant を指定していた場合、代わりにこれ使ってね (Fix-it) ってメッセージが出る。
    @warn_unused_result(mutable_variant="add")
    func increatented() -> Int {
        return value + 1
    }
    
    mutating func increatent() {
        value += 1
    }
}


//: [Next](@next)
