//: [Previous](@previous)

import UIKit


public func solution(inout A : [Int], _ K : Int) -> [Int] {
    let count = A.count
    let (pre, suf) = ([Int](A[0..<K]), [Int](A[K..<count]))
    return suf + pre
}

var a = [1, 2, 3]
solution(&a, 1)

let value = 0

let labelA = UILabel()
let labelB = UILabel()
let labelC = UILabel()

func updateLabels() {
    // 😐
    if /* condition1 */ true {
        labelA.text = "a"
        labelB.text = "A"
        labelC.text = "A"
    } else if /* condition2 */ true {
        labelA.text = "b"
        labelB.text = "B"
        labelC.text = "B"
    } else {
        labelA.text = "c"
        labelB.text = "C"
        labelC.text = "C"
    }
}

func updateLabels_() {
    // 😦
    labelA.text = {
        if /* condition1 */ true {
            return "a"
        } else if /* condition2 */ true {
            return "b"
        } else {
            return "c"
        }
    }()
    labelB.text = {
        if /* condition1 */ true {
            return "A"
        } else if /* condition2 */ true {
            return "B"
        } else {
            return "C"
        }
    }()
}

func updateLabels__() {
    // 😊
    (labelA: labelA.text, labelB: labelB.text, labelC: labelC.text) = {
        if /* condition1 */ true {
            // error: cannot convert return expression of type
            return (labelA: "a", labelB: "b", labelD: "c")
        } else if /* condition2 */ true {
            return (labelA: "b", labelC: "B", labelB: "B")
        } else {
            return (labelA: "c", labelB: "C", labelC: "C")
        }
    }()
}

updateLabels__()
labelA.text  // "a"
labelB.text  // "b"


//: [Next](@next)
