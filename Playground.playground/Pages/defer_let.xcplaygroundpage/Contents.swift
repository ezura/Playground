//: [Previous](@previous)

import UIKit

class ViewController: UIViewController {
    private var checkButton: UIButton!
    private var submitButton: UIButton!
    
    // 😦
    func checkButtonDidTap(sender: UIButton) {
        checkButton.enabled = false
        
        guard "" == "" /* condition */ else {
            /* do something */
            checkButton.enabled = true
            return
        }
        
        guard "" == "" /* condition */ else {
            checkButton.enabled = true
            return
        }
        
        /* do something... */
        
        // if...
        guard "" == "" /* condition */ else {
            // missing!!
//            checkButton.enabled = true
            return
        }
        
        checkButton.enabled = false
    }
    
    
    // 😮
    func checkButtonDidTap_(sender: UIButton) {
        var shouldCheckButtonEnabled = true
        
        checkButton.enabled = false
        defer { checkButton.enabled = shouldCheckButtonEnabled }
        
        guard "" == "" /* condition */ else {
            shouldCheckButtonEnabled = true
            return
        }
        
        guard "" == "" /* condition */ else {
            shouldCheckButtonEnabled = true
            return
        }
        
        /* do something... long long long (ﾟωﾟ) */
        
        // if...
        guard "" == "" /* condition */ else {
            // missing???
//            shouldCheckButtonEnabled = true
            return
        }
        
        shouldCheckButtonEnabled = false
    }
    
    
    
    //
    func checkButtonDidTap___(sender: UIButton) {
        let shouldCheckButtonEnabled: Bool  // <- shouldCheckButtonEnabled need initialize
        
        checkButton.enabled = false
        defer {  // 🎉 error: constant 'shouldCheckButtonEnabled' used before being initialized
            checkButton.enabled = shouldCheckButtonEnabled
        }
        
        guard "" == "" /* condition */ else {
            shouldCheckButtonEnabled = true
            return
        }
        
        guard "" == "" /* condition */ else {
            shouldCheckButtonEnabled = true
            return
        }
        
        /* do something... long long long (ﾟωﾟ) */
        
        // if...
        guard "" == "" /* condition */ else {
            // missing???
//            shouldCheckButtonEnabled = true
            return
        }
        
        shouldCheckButtonEnabled = false
    }
}


//: [Next](@next)
