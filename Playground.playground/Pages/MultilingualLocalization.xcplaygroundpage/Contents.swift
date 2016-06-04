//: Playground - noun: a place where people can play

import UIKit

import Foundation

protocol LocalizeSupportType : class {
    var language: String { get set }
}

class ReceiverManager : SequenceType {
    
    private class _WeakContainerRef {
        
        struct WeakContainer {
            weak var receiver: LocalizeSupportType?
        }
        
        var _containers: [WeakContainer]
        
        var containersExcludeNilContiner: [WeakContainer] {
            return _containers.filter { $0.receiver != nil }
        }
        
        var receivers: [LocalizeSupportType] {
            return containersExcludeNilContiner.map { $0.receiver! }
        }
        
        init(containers: [WeakContainer]) {
            _containers = containers
        }
        
        func dropWeaks() {
            _containers = containersExcludeNilContiner
        }
        
        func generate() -> AnyGenerator<LocalizeSupportType> {
            return AnyGenerator(containersExcludeNilContiner.map { $0.receiver! }.generate())
        }
    }
    
    private var _weakContainerRef: _WeakContainerRef
    
    init() {
        _weakContainerRef = _WeakContainerRef(containers: [])
    }
    
    init<T:LocalizeSupportType>(objects: T...) {
        _weakContainerRef = _WeakContainerRef(containers: objects.map(_WeakContainerRef.WeakContainer.init))
    }
    
    var receivers: [LocalizeSupportType] {
        return _weakContainerRef.receivers
    }
    
    func generate() -> AnyGenerator<LocalizeSupportType> {
        _weakContainerRef.dropWeaks()
        return _weakContainerRef.generate()
    }

    func assign<T:LocalizeSupportType>(x: T) {
        let x = _WeakContainerRef.WeakContainer(receiver: x)
        _weakContainerRef._containers.append(x)
    }
    
    func publish(language: String) -> Int {
        receivers.forEach {
            $0.language = language
        }
        
        // for Debug
        return receivers.count
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