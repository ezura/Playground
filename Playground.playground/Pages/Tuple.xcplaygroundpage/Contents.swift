//: [Previous](@previous)

import UIKit

//struct KeyboardDisplayEventInformation {
//    let frameBegin: CGRect
//    let frameEnd: CGRect
//    let animationDuration: Double
//    let animationOptions: UIViewAnimationOptions
//    
//    let isLocal: Bool // これは iOS9 から
//    
//    // error: stored properties cannot be marked potentially unavailable with '@available'
//    @available(iOS, introduced=8)
//    let width: CGFloat
//    
//    // ほとばしる無理やり感(/･ω･＼)
//    @available(iOS, introduced=8)
//    var height: CGFloat { return _height }
//    private let _height: CGFloat
//}

import Foundation

//// SDK のバージョンに依存して増減しそうなので包んでおくことに。
//// isLocal は iOS9 からなのでオプショナルに。@available とかで分けた方が良いのかな。。いや、微妙か。。
//typealias KeyboardDisplayEventInformation = (
//    frameBegin: CGRect,
//    frameEnd: CGRect,
//    animationDuration: Double,
//    animationOptions: UIViewAnimationOptions,
//    isLocal: Bool?)

struct KeyboardDisplayEventInformation {
    enum <#name#> {
        case <#case#>
    }
    
    let frameBegin: CGRect
    let frameEnd: CGRect
    let animationDuration: Double
    let animationOptions: UIViewAnimationOptions
    
    @available(iOS, introduced=9)
    var isLocal: Bool { return _isLocal }
    let _isLocal: Bool
}


protocol KeyboardRecieverType: class {
    func keyboardWillShow(keyboardEventInformation: KeyboardDisplayEventInformation)
    func keyboardWillHide(keyboardEventInformation: KeyboardDisplayEventInformation)
}

extension KeyboardRecieverType {
    func keyboardWillShow(keyboardEventInformation: KeyboardDisplayEventInformation) {}
    func keyboardWillHide(keyboardEventInformation: KeyboardDisplayEventInformation) {}
}

/**
 キーボードのイベントを監視する。
 
 * 監視を開始するとき: beginObserve
 * 終了するとき: endObserve
 */
final class KeyboardNortificationObserver {
    weak var reciever: KeyboardRecieverType?
    
    func startObserve() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(self.keybordWillShow(_:)),
                                                         name: UIKeyboardWillShowNotification,
                                                         object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(self.keybordWillHide(_:)),
                                                         name: UIKeyboardWillHideNotification,
                                                         object: nil)
    }
    
    func stopObserve() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    deinit {
        stopObserve()
    }
    
    @objc private func keybordWillShow(notificaiton: NSNotification) {
        guard let userInfo = notificaiton.userInfo,
            animationCurveNum = (userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber) as? Int,
            animationCurve = UIViewAnimationCurve(rawValue: animationCurveNum),
            animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            frameBegin = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue(),
            frameEnd = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() else {
                return
        }
        var isLocal: Bool?
        if #available(iOS 9.0, *) {
            isLocal = (userInfo[UIKeyboardIsLocalUserInfoKey] as? NSNumber) as? Bool
        }
        reciever?.keyboardWillShow((frameBegin: frameBegin, frameEnd: frameEnd,
            animationDuration: animationDuration, animationOptions:  UIViewAnimationOptions(animationCurve: animationCurve),
            isLocal: isLocal))
    }
    
    @objc private func keybordWillHide(notificaiton: NSNotification) {
        guard let userInfo = notificaiton.userInfo,
            animationCurveNum = (userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber) as? Int,
            animationCurve = UIViewAnimationCurve(rawValue: animationCurveNum),
            animationDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            frameBegin = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue(),
            frameEnd = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() else {
                return
        }
        var isLocal: Bool?
        if #available(iOS 9.0, *) {
            isLocal = (userInfo[UIKeyboardIsLocalUserInfoKey] as? NSNumber) as? Bool
        }
        
        reciever?.keyboardWillHide((frameBegin: frameBegin, frameEnd: frameEnd,
            animationDuration: animationDuration, animationOptions: UIViewAnimationOptions(animationCurve: animationCurve),
            isLocal: isLocal))
    }
}
//: [Next](@next)
