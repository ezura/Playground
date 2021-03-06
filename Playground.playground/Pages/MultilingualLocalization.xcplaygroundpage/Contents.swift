//: Playground - noun: a place where people can play

import UIKit

enum Language {
    case Japanese, English, Chinese
    
    func stringFileName() -> String {
        switch self {
        case .Japanese: return "Japanese"
        case .English:  return "English"
        case .Chinese:  return "Chinese"
        }
    }
}

/// recievable language change notification
protocol LocalizeSupportType: class {
    var language: Language { get set }
}

extension LocalizeSupportType {
    func beginLocalizing() {
        localizeNotificationManager.register(self)
    }
    
    func endLocalizing() {
        localizeNotificationManager.remove(self)
    }
}

class LocalizeNotificationManager {
    // hold weak reference objects
    private class WeakContainer: SequenceType {
        typealias ContentType = LocalizeSupportType
        
        struct WeakContent {
            weak var content: ContentType?
            
            init(_ content: ContentType) {
                self.content = content
            }
        }
        
        var containers: [WeakContent]
        
        var containersExcludeNilContiner: [WeakContent] {
            return containers.filter { $0.content != nil }
        }
        
        var receivers: [ContentType] {
            return containersExcludeNilContiner.map { $0.content! }
        }
        
        init(containers: [ContentType]) {
            self.containers = containers.map(WeakContent.init)
        }
        
        func append(element: ContentType) {
            containers.append(WeakContent(element))
        }
        
        func remove(element: ContentType) {
            let index = containers.indexOf { return $0.content === element }
            if let index = index {
                containers.removeAtIndex(index)
            }
        }
        
        /// remove released elements
        func dropWeaks() {
            containers = containersExcludeNilContiner
        }
        
        func generate() -> AnyGenerator<ContentType> {
            return AnyGenerator(containersExcludeNilContiner.map { $0.content! }.generate())
        }
    }
    
    private var registrants: WeakContainer
    
    init() {
        registrants = WeakContainer(containers: [])
    }
    
    init(objects: LocalizeSupportType...) {
        registrants = WeakContainer(containers: objects)
    }
    
    private func register(object: LocalizeSupportType) {
        registrants.append(object)
    }
    
    private func remove(object: LocalizeSupportType) {
        registrants.remove(object)
    }
    
    /// notice to observers
    func publish(language: Language) {
        registrants.forEach {
            $0.language = language
        }
    }
}

internal(set) var localizeNotificationManager = LocalizeNotificationManager()





class MyClass1 : LocalizeSupportType {
    
    var value: Int
    var language: Language = .Japanese {
        
        didSet {
            
            print("Did Set", language)
        }
    }
    
    init(_ value: Int) {
        self.value = value
    }
}

class MyClass2 : LocalizeSupportType {
    
    var value: Int
    var language: Language = .Japanese {
        
        didSet {
            
        }
    }
    
    init(_ value: Int) {
        self.value = value
    }
}

class UIViewController : LocalizeSupportType {
    
    var language: Language = .Japanese {
        
        didSet {
            
        }
    }
    
    func viewDidLoad() {
        
        beginLocalizing()
        
    }
}

struct Sample {
    var x = 0
    // 返り値使わなかったら警告だしてくれる
    // さらに、mutable_variant を指定していた場合、代わりにこれ使ってね (Fix-it) ってメッセージが出る。
    @warn_unused_result(mutable_variant="mutatingSampleFunc")
    func sampleFunc() -> Int {
        return x + 1
    }
    
    mutating func mutatingSampleFunc() {
        x += 1
    }
}

var a = Sample()

// @warn_unused_result(mutable_variant="mutatingSampleFunc") にしてるメソッド
// warning: Result of call to non-mutating function 'sampleFunc()' is unused; use 'mutatingSampleFunc()' to mutate in-place
// 警告マーク押すと、mutatingSampleFunc に置き換えてくれる
a.sampleFunc()


var obj1 = MyClass1(100) as Optional
let obj2 = MyClass1(10)
let obj3 = MyClass2(20)
let obj4 = MyClass2(30)

obj1!.beginLocalizing()
obj2.beginLocalizing()
obj3.beginLocalizing()
obj4.beginLocalizing()

obj2.language
obj3.language

obj3.endLocalizing()

obj1 = nil

// これは WeakReceiverManager が言語の変更通知を受けとって、内部で実行する
localizeNotificationManager.publish(.English)

obj2.language
obj3.language
