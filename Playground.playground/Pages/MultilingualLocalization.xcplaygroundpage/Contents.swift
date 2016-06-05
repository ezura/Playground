//: Playground - noun: a place where people can play

import UIKit

enum Language {
    case Japanese, English, Chinese
}

/// recievable language change notification
protocol LocalizeSupportType: class {
    var language: Language { get set }
}

extension LocalizeSupportType {
    func beginLocalizing() {
        receiverManager.assign(self)
    }
    
    func endLocalizing() {
        receiverManager.remove(self)
    }
}

private class ReceiverManager {
    // hold weak reference objects
    class WeakContainer: SequenceType {
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
    
    func assign(object: LocalizeSupportType) {
        registrants.append(object)
    }
    
    func remove(object: LocalizeSupportType) {
        registrants.remove(object)
    }
    
    /// notice to observers
    func publish(language: Language) {
        registrants.forEach {
            $0.language = language
        }
    }
}

private var receiverManager: ReceiverManager = ReceiverManager()





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
receiverManager.publish(.English)

obj2.language
obj3.language
