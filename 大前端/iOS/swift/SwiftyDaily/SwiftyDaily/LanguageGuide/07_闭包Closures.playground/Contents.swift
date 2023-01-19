import Foundation
// 闭包是一个可以用于传递独立的代码块。与c、oc和lambdas的block一样
//闭包的三种形式
//1. 全局函数：有名称但不能捕获任何值
//2. 嵌套函数：有名称也能捕获闭包内的值
//3. 闭包表达式: 无名称，使用轻量语法，可以根据上下文捕获环境参数
//Swift中的闭包有很多优化的地方:
//根据上下文推断参数和返回值类型
//从单行表达式闭包中隐式返回（也就是闭包体只有一行代码，可以省略return）
//可以使用简化参数名，如$0, $1(从0开始，表示第i个参数...)
//提供了尾随闭包语法(Trailing closure syntax)
//标准库函数 sorted(by:)
let letters = ["G", "C", "B", "A", "F"]

func descending(_ a: String, _ b: String) -> Bool {
    return a > b
}

func ascending(_ a: String, _ b: String) -> Bool {
    return a < b
}

let ascendingLetters = letters.sorted(by: ascending)
let descendingLetters = letters.sorted(by: descending)
print("ascendingLetters: \(ascendingLetters)")
print("descendingLetters: \(descendingLetters)")
print("origin letters: \(letters)")

//闭包的表达式
/*
 { (parameters) -> return type in
     statements
 }
 */

//所以上面的sorted(by:descending)用闭包简化掉函数，表达式显示为：
let descending = letters.sorted(by: { (_ a: String , _ b: String) -> Bool in
    return a > b
})

//sorted(by:ascending)用闭包简化掉函数，表达式显示为：
let ascending = letters.sorted(by: { (_ a: String , _ b: String) -> Bool in
    return a < b
})
print("ascending: \(ascending)")
print("descending: \(descending)")
print("origin letters2: \(letters)")

//omittedDescending。 基于sorted(by:)的定义，可以推断简化为以下：
let omittedDescending = letters.sorted(by: { s1,s2 in
    return s1 > s2
})

let omittedDescending2 = letters.sorted(by: { s1,s2 in return s1 > s2 })
//omittedAscending。基于sorted(by:)的定义，可以推断简化为以下：
let omittedAscending = letters.sorted(by: { s1,s2 in
    return s1 < s2
})

let omittedAscending2 = letters.sorted(by: { s1,s2 in return s1 < s2 })

//隐式 return 由于表达式 (s1 > s2) 、(s1 < s2) 返回一个布尔值，所以return 可以被简化
let omittedDescending3 = letters.sorted(by: { s1,s2 in s1 > s2 })
let omittedAscending3 = letters.sorted(by: { s1,s2 in s1 < s2 })

//简化入参名
//由于sorted(by:) 可以推断出有2个入参，且都为String类型，所以可以简化入参为$0,$1. 注意从$0开始
let shorthandDescending = letters.sorted(by: { $0 > $1 })
let shorthandAscending = letters.sorted(by: { $0 < $1 })

//操作方法
// 大于操作符（ > ）、小于操作符（ < ）有被实现与比较两个字符串，并且返回一个布尔值。这完全符合sorted(by:)的期待。
//所以可以用操作符简化sorted(by:). 记得去掉{}
let operatorDescending = letters.sorted(by:  > )
let operatorAscending = letters.sorted(by: < )
print("operatorAscending: \(operatorAscending)")
print("operatorDescending: \(operatorDescending)")
//尾随闭包 （Trailing Closures）
//sorted(by:)也是一个尾随闭包，

//模拟sorted(by:) 构建一个尾随闭包 mySorted(compared:)
extension Array {
  
    
    func mySorted(compared: (_ s1: String, _ s2: String) -> Bool )-> Array {
        var newArray = Array(self) //新构建一个数组。 不改变原有数组值
        for  index in 0..<newArray.count {
            var sorted  = true
            let loopUper = newArray.count-index-1
            for  jIndex in 0..<loopUper {
                let NextJValue = newArray[jIndex+1]
                let jValue = newArray[jIndex]
                if compared(NextJValue as! String ,jValue as! String) {
                    sorted = false
                    let tmp = newArray[jIndex]
                    newArray[jIndex] = NextJValue
                    newArray[jIndex+1] = tmp
                }
//                print(" index:\(index), value:\(value), pIndex:\(jIndex) pValue:\(jValue) newArray:\(newArray)")
            }
            if sorted == true {
                break
            }
            
        }
        return newArray
    }
}

let tailDescending = letters.mySorted(compared: > )
let tailAescending = letters.mySorted(compared: < )
print("tailAescending: \(tailAescending)")
print("tailDescending: \(tailDescending)")
print("letters: \(letters)")

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
var numbers = [16, 58, 510]

func replaceItem(_ number: Int) -> String {
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
}
//public func map<T>(_ transform: (Output) -> T) -> Just<T>
let numberOfStrings = numbers.map { (number) -> String in //number会被自动推断为：数组中的item所对应的类型。 这里为Int
    return replaceItem(number)
}
print("numberOfStrings: \(numberOfStrings)")
print("numbers: \(numbers)")

// 模拟map
extension Array {
    func myMap(by: (_ item: Int) -> String? ) -> Array<Any> {
        var newMapArray = [Any]()
        for  item in self {
            let arrayItem = item as! Int
            let replaceItem = by(arrayItem)
            if let replace = replaceItem {
                newMapArray.append(replace)
            }
        }
        return newMapArray
    }
}
numbers = [33,520,77]
let myReplaceMaps = numbers.myMap { item in
    return replaceItem(item)
}
print("myReplaceMaps: \(myReplaceMaps)")

//多尾随闭包
func httpQuery(url: String?, success callSuccess: ((_ code: Int,_ repsponeObject: [String:String]) -> Void), fail callFail: ((_ code: Int,_ error: String) -> Void)) {
    if url == nil {
        callFail(301, "url is empty")
        return
    }
    
    //doing query
    
    callSuccess(0,["data":"haha"])
}


httpQuery(url: "swift day happy! ") { code, repsponeObject in
    print("success code: \(code) data:\(repsponeObject)")
} fail: { code, error in
    print("fail code: \(code) error:\(error)")
}


/*
 捕获值
 闭包可以在其定义的上下文中捕获常量或变量。

 即使定义这些常量和变量的原域已经不存在，闭包仍然可以在闭包函数体内引用和修改这些值。

 Swift最简单的闭包形式是嵌套函数，也就是定义在其他函数的函数体内的函数。

 嵌套函数可以捕获其外部函数所有的参数以及定义的常量和变量。

 */

func step(number add: Int ) -> (()->Int){
    var total = 0
    
    /* 这里addStep函数没有入参，方法体内的add和total，根据函数上下文情况被捕获为一份副本，total初始化是0，amount是5.
     * （可以理解为函数内的静态变量，这个变量被addStep持有对象所存储，直到持有对象被释放）
     */
//    var stepTmp = add
    func addStep()->Int {
        total += add
        total = total - 1
        return total
    }
    return addStep
}

let methodStep5 = step(number: 5)
//methodStep5 means has a capture property named add, its value is 5, and has a reuslt property named total.
var stepValue = methodStep5()
print("stepValue: \(stepValue)")

stepValue = methodStep5()
print("stepValue2: \(stepValue)")

stepValue = methodStep5()
print("stepValue3: \(stepValue)")

//methodStep10 means has a capture property named add, its value is 10, and has a reuslt property named total.
let methodStep10 = step(number: 10)
print("returnStep10: \(methodStep10())")

// 函数类型和闭包都是引用类型
//这里虽然methodStep5和methodStep10 都被声明为常量，但我们依然可以改变闭包内的变量。
//methodStep5和methodStep10又是两个独立的个体，随着被初始化而拷贝出独立副本。

/**
 

//逃逸闭包：当闭包作为函数的参数传入时 默认情况下 函数执行完毕 闭包中的代码也就执行完了 方法中的变量和传入的闭包也就释放了（类似oc block 不马上执行，延迟delay调用）
 条件：
       1. 闭包被作为参数传递
       2. 在函数调用return之后，才调用的闭包。 (闭包被延迟调用)
       3. 被延迟调用的入参闭包，需要用@escaping 声明，否则会编译报错。
       4. 对象类型逃逸闭包，访问属性，需要用self引用。这会引起强引用
       5. 通常闭包上下文变量，在闭包体内都可以隐式的访问。但对于对象类型的逃逸闭包，则需要显示self声明，这让是让你明确意图，同时确认这不是一个循环引用
       6. 结构体、枚举体逃逸类型，不能用self访问。同时也不能捕获上下文变量。【会编译报错】
       7. 结构类型方法中访问属性（无论隐射/显示）。需要用mutating声明函数，使得self合法。
*/

var handlers :[() -> Void] = []

//入参闭包被外部变量持有，不马上执行。
func escapingClosure( escapingClosure: @escaping () -> Void ){
    handlers.append(escapingClosure)
}

//入参闭包不被外部持有，随着函数结束而结束
func notEscapingClosure( escapingClosure: () -> Void ){
    escapingClosure()
}

class ClosureClass {
    var x = 10
    func doSomething(){
        escapingClosure {
            [self] in x = 100
            print("[self] in escapingClosure \(self.x)")
        }
        escapingClosure {
            self.x = 300
            print("[self.x == 300] in escapingClosure \(self.x)")
        }
        
        notEscapingClosure {
            self.x = 10
            print("self.x in notEscapingClosure \(self.x)")
        }
        notEscapingClosure {
            x = 3
            print("x in notEscapingClosure \(self.x)")
        }
    }
}
var a = 30

var closureClass:ClosureClass? = ClosureClass()
closureClass?.doSomething()
print("========= escapingClosure out add =========== ")
escapingClosure {
    a = 4
    print("not instance escaping \(a)")
}

closureClass = nil
print("========= closureClass is free ?? =========== ")
print("closureClass.x \(closureClass?.x ?? 0) ")
handlers.first?()

handlers.last?()
print("handlers.count \(handlers.count)")

//结构类型逃逸闭包
struct EscapintStruct {
    var x = 10
    mutating func doingSomething(){
//        escapingClosure {
//            x = 5
//            print("[self.x == 300] in EscapintStruct.escapingClosure \(x)") //compiler error
//        }
        
        notEscapingClosure {
            x = 10
            print("self.x in EscapintStruct.notEscapingClosure \(x)")
        }
    }
}
var escapingStruct: EscapintStruct? = EscapintStruct()
escapingStruct?.doingSomething()
//handlers.last?()


/** 自动闭包 autoclosure：(类似OC的 inline block, 默认情况block不会被调用，直到你需要用到它 )
    1. 自动闭包是一种自动创建的闭包，用于包装一个表达式，并且作为入参传递给函数。
    2. 这种闭包不接受任何参数，当闭包被调用的时候，会返回被包装在其中的表达式的值。
    3. 这种便利语法，可以让你在传入参时，无需写一个显式的闭包。 通过简化删除闭包花括号，用一个普通的表达式来表示。
    4. 我们会使用自动闭包来调函数，但比较少见，会需要实现一个自动闭包。
    5. 自动闭包让你能够延迟求值，因为直到你调用这个闭包，代码段才会被执行。
    6. 延迟求值对于那些有副作用（Side Effect）和高计算成本的代码来说是很有益处的，因为它使得你能控制代码的执行时机。
 */
//例子：比较常见的常见。在debug状态下，使用assert(condition:message:file:line:)。
//assert(false,"call to show message")
// 这里condition和message都是自动闭包。当condition为false时，调用执行提示message
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// Prints "5"

//a function with no parameters that returns a string。 customerProvider类型为 () -> String
let customerProvider = {
    //remove(at: ) if remove success return the delete elements. while customersInLine is an [String] type.
    // so its return type will be infer to String type.
    customersInLine.remove(at: 0)
    
}
print(customersInLine.count)
// Prints "5"

print("Now serving \(customerProvider())!")
// Prints "Now serving Chris!"
print(customersInLine.count)

//显示声明一个闭包，返回一个String类型
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}

serve {
    customersInLine.remove(at: 0)
}
print("after serve explicit autoclosure call \(customersInLine)")

//隐式声明一个闭包，无参数，返回一个String类型。
func serveAutoclosure(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}

serveAutoclosure(customer: customersInLine.remove(at: 0))
print("after serve implicit autoclosure call \(customersInLine)")

//所以我们可以推断出 assert 的自动闭包写法
func myAssert(condiction:  ()->Bool, message: ()->String){
    guard condiction() == true else {
        print("message: \(message())")
        abort()
        return
    }
}

func myAssertAutoClosure(_ condiction: @autoclosure ()->Bool,_ message: @autoclosure ()->String){
    guard condiction() == true else {
        print("myAssertAutoClosure message: \(message())")
        abort()
        return
    }
}

myAssert {
    return true
} message: {
    return "你好呀"
}

myAssertAutoClosure(false,"你好呀")

//过渡使用自动闭包，会降低你代码的可读性。函数名和上下文应该清晰的被推断。

//同时使用自动闭包和逃逸闭包
// customersInLine is ["Barry", "Daniella"]
var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))

print("Collected \(customerProviders.count) closures.")
// Prints "Collected 2 closures."
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}
// Prints "Now serving Barry!"
// Prints "Now serving Daniella!"
