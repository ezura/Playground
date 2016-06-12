//: [Previous](@previous)

import Foundation

//: @noreturn について

@noreturn
func fatalerrorFunc() {
    
    fatalError()
}


enum MyError: ErrorType { case A }
@noreturn
func throwErros() throws {
    throw MyError.A
}


@noreturn
func noreturnFunc(param: Bool) throws {
    guard param else {
        throw MyError.A
    }
    abort()
}




func sample() {
    do {
        try noreturnFunc(false)
        // @noreturn つけて情報を付加していると警告でる
        print("noreturnFunc の下")
    } catch {
        // エラー処理
    }
}

class Sample {
    var param = 1
    
    func hoge() {
        let a: Int = {
            return param
        }()
        
            {
                print(param)
                return param
            }()
        print(a)
        
        let b: @nonescape () -> Int = {
            return self.param
        }
        print(b())
    }
}

let a: String = { @nonescape () -> String in
    // do something
}()




do {
    class A {
        var param: (() -> Void)?
        deinit {
            print("deinit")
        }
        
        func sample(@autoclosure(escaping) param: () -> Void) {
//            self.param = param
            exec(param)
        }
        
        func exec(@noescape param: () -> Void) {
            print("before")
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
//                print("in")
//                param()
//            }
            param()
            print("after")
        }
        
        func dummy() {
            print("dummy")
        }
    }
    let a = A()
    a.sample( a.dummy() )
}

sleep(4)

////: [Next](@next)
