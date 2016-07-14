//: [Previous](@previous)

import UIKit

/// Alert を wrap
class Alert: NSObject, UIAlertViewDelegate {
    enum _Alert {
        @available(iOS 8, *)
        case View(UIAlertView)
        case Controller(UIAlertController)
    }
    
    // Alert の実態
    var _alert: _Alert
    var clickedButton:((AnyObject?,Int?)->())?
    
    override init() {
        super.init()
    }
    
    init(title title: String?,
        message message: String?,
        delegate delegate: AnyObject?,
        cancelButtonTitle cancelButtonTitle: String?) {
        if #available(iOS 8, *) {
            let alert = UIAlertController
            _alert = _Alert(UIAlertController(title: title,
                message: message,
                preferredStyle: .Alert))
        }
    }
}

//: [Next](@next)
