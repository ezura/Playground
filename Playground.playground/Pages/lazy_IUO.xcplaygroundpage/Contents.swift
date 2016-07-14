//: [Previous](@previous)

import UIKit

class Sample {
    lazy var value: Int! = {
        return 0
    }()
}
let sample = Sample()
sample.value     // 0
sample.value = 1
sample.value     // 1

sample.value = nil
sample.value     // 0


//class Sample {
//    lazy var window: UIWindow! = {
//        let window = UIWindow()
//        window.rootViewController = {
//            let vc = UIViewController()
//            vc.view.backgroundColor = UIColor.orangeColor()
//            return vc
//        }()
//        return window
//    }()
//}
//
//let sample = Sample()
//sample.window.makeKeyAndVisible()  // orangeColor window
//
//// いろいろあって状態が変わる (わかりやすさのため、色を変えてみる)
//sample.window.backgroundColor = UIColor.redColor()
//sample.window  // redColor window
//
//// 役目果たしたので消す
//sample.window = nil
//
//
//// また出番に
//sample.window.makeKeyAndVisible()  // orangeColor window

//: [Next](@next)
