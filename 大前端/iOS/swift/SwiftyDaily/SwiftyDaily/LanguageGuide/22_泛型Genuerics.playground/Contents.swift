import UIKit

// # 泛型
//    泛型代码可以根据你定义的主题，编写一个灵活、可复用函数和可使用于任何类型的类型。你可避免编写重复的代码，而是用一种清晰抽象的方式来表达代码的意图。

// 泛型是swift功能强大特性之一，很多标准库都是用泛型设计。事实上在Swift语言指南里，你已经无意识的使用上了泛型。比如Array和Dictionary都是泛型集合。 你可以创建一个Int类型或者String类型的数组集合，同样的字典也可以自动存储不同的类型。

// # 01 泛型解决的问题
// 常见的交换参数方法，使用了In-Out参数
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// Prints "someInt is now 107, and anotherInt is now 3"

func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}

//  上面上个方法，仅有类型的不同。所以可以通过泛型来写出唯一一个函数，它支持int，String，Double类型互换。
// PS: 对于互换值的两个参数，他们的类型都是必须是一样的。如果不一样，Swift编译器则会报错。

// # 02 泛型函数
// 格式：func funcname<T>(a: T, b: T) -> returnType { body }
// 泛型函数可以在任何类型上工作。以下是交换类型函数的泛型例子：

// T 表示任何函数
func swap<T>(a:inout T, b: inout T) -> Void {
    let tmp: T = a
    a = b
    b = tmp
}
var swapInt = 3
var anotherSwapInt = 107
swap(&swapInt, &anotherSwapInt)
// someInt is now 107, and anotherInt is now 3

var swapString = "hello"
var anotherSwapString = "world"
swap(&swapString, &anotherSwapString)
// someString is now "world", and anotherString is now "hello"

// # 03 类型参数
// 参数类型是根据泛型的占位符来确定的
// 格式：<T>，并且将占位符写在函数名后面。T不是实际类型名,它可以是任意类型。由于它是一个占位符，Swift不会真的去找这个不存在的T类型。

// # 04 类型参数命名
// 占位符类型通常用大写 T、U、V等表示，用 < 和 > 括起来


// # 05 泛型类型
// 除了泛型函数，Swift还允许自定义泛型类型。例如定义一个栈结构的泛型函数，它支持Int，String等类型
struct Stack<T> {
    var pool: [T] = []
    mutating func push(_ item: T){
        pool.append(item)
    }
    
    mutating func pop() -> T {
        let last = pool.removeLast()
        return last
    }
}
var stackInt = Stack<Int>()
stackInt.push(1)
stackInt.push(2)
stackInt.push(3)
let popInt = stackInt.pop()

var stackString = Stack<String>()
stackString.push("one")
stackString.push("two")
stackString.push("three")
let popString = stackString.pop()


// # 06 拓展泛型类型
// 泛型同样支持拓展，使用extension 表示
extension Stack {
    func root() -> T? {
        guard let first = self.pool.first else { return nil }
        return first
    }
}
stackInt.root()
stackString.root()

// # 07 常量类型

// # 08 关联类型

// # 09 泛型分支

// # 10 拓展泛型分支

// # 11 分支上下文

// # 12 关联类型泛型分支

// # 13 泛型下标
