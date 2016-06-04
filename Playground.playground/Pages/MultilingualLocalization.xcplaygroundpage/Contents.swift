//: Playground - noun: a place where people can play

import UIKit

/// The Protocol recievable language change notification
protocol LocalizeSupportType : class {
    var language: String { get set }
}

class ReceiverManager {
    
    // hold weak reference objects
    private class WeakContainer: SequenceType {
        typealias ContentType = LocalizeSupportType
        
        struct WeakElement {
            weak var content: ContentType?
            
            init(_ content: ContentType) {
                self.content = content
            }
        }
        
        var _containers: [WeakElement]
        
        var containersExcludeNilContiner: [WeakElement] {
            return _containers.filter { $0.content != nil }
        }
        
        var receivers: [ContentType] {
            return containersExcludeNilContiner.map { $0.content! }
        }
        
        init(containers: [WeakElement]) {
            _containers = containers
        }
        
        func append(element: ContentType) {
            _containers.append(WeakElement(element))
        }
        
        /// remove released elements
        func dropWeaks() {
            _containers = containersExcludeNilContiner
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
        registrants = WeakContainer(containers: objects.map(WeakContainer.WeakElement.init))
    }
    
    func assign(x: LocalizeSupportType) {
        registrants.append(x)
    }
    
    /// notice to observers
    func publish(language: String) {
        registrants.forEach {
            $0.language = language
        }
    }
}

class MyClass1 : LocalizeSupportType {
    
    var value: Int
    var language: String = "JP" {
        
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
    var language: String = "EN"
    
    init(_ value: Int) {
        self.value = value
    }
}

internal(set) var receiverManager: ReceiverManager = ReceiverManager()

extension LocalizeSupportType {
    func beginLocalizing() {
        receiverManager.assign(self)
    }
}

class UIViewController : LocalizeSupportType {
    
    var language: String = "JP" {
        
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

obj1 = nil

// これは WeakReceiverManager が言語の変更通知を受けとって、内部で実行する
receiverManager.publish("xx")

obj2.language
obj3.language
