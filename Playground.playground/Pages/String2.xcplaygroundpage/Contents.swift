//: [Previous](@previous)

import Foundation

struct A {}

extension String {
    init?(_ v: A) {
        self = "( 'ω')"
    }
}

let a = A()
String(a)       // "( 'ω')"
String(a) + ""  // "A()"
// Optional<String> + String

/*
 * String(A()) が失敗のある変換に見えなかった (Optional が返ってくるように見えなかった)
   * 例外をなげる
   * ラベルでそれとなく意図を伝える
 * Optional<String> + String ができてしまう
 * String が全てを受け入れてしまう
 */

//: [Next](@next)
