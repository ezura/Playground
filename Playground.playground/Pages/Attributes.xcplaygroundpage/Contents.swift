//: [Previous](@previous)

import Foundation

//: @warn_unused_result について
struct MyNumber {
    var value = 0
    // 返り値使わなかったら警告だしてくれる
    // さらに、mutable_variant を指定していた場合、代わりにこれ使ってね (Fix-it) ってメッセージが出る。
    @warn_unused_result(mutable_variant="increment")
    func incremented() -> Int {
        return value + 1
    }
    
    mutating func increment() {
        value += 1
    }
}

var a = MyNumber()

// @warn_unused_result(mutable_variant="mutatingSampleFunc") にしてるメソッド
// warning: Result of call to non-mutating function 'sampleFunc()' is unused; use 'mutatingSampleFunc()' to mutate in-place
// 警告マーク押すと、mutatingSampleFunc に置き換えてくれる
a.incremented()

//: [Next](@next)
