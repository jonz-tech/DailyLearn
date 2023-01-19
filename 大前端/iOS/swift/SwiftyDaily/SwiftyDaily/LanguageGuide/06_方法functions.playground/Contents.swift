import UIKit

//常规函数定义
func greet(person: String) -> String {
    let greeting = "Hello, \(person)!"
    return greeting
}

print("\(greet(person: "Anna"))")
// Prints "Hello, Anna!"
print("\(greet(person: "Brian"))")
// Prints "Hello, Brian!"

func greetAgain(person: String) -> String {
    return "Hello again, " + person + "!"
}
print(greetAgain(person: "Anna"))
// Prints "Hello again, Anna!"

//无入参函数定义
func sayHelloWorld() -> String {
    return "hello, world"
}
print(sayHelloWorld())
// Prints "hello, world"

//多入参函数定义
func greet(person: String, alreadyGreeted: Bool) -> String {
    if alreadyGreeted {
        return greetAgain(person: person)
    } else {
        return greet(person: person)
    }
}
print("\(greet(person: "Tim", alreadyGreeted: true))")
// Prints "Hello again, Tim!"

//无返回值函数定义
func greetTo(person: String) {
    print("Hello, \(person)!")
}

greetTo(person: "Dave")
// Prints "Hello, Dave!"


func printAndCount(string: String) -> Int {
    print(string)
    return string.count
}

//忽略内部函数返回值
func printWithoutCounting(string: String) {
    let _ = printAndCount(string: string)
}
printAndCount(string: "hello, world")
// prints "hello, world" and returns a value of 12
printWithoutCounting(string: "hello, world")
// prints "hello, world" but doesn't return a value

//多参数返回，用元组类型
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")
// Prints "min is -6 and max is 109"

//可选类型元组返回
func minMax2(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty { return nil }
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}
if let bounds = minMax2(array: [8, -6, 2, 109, 3, 71]) {
    print("2: min is \(bounds.min) and max is \(bounds.max)")
}
// Prints "2: min is -6 and max is 109"

//入参变体，参数可以用两个单词组成，中间用空格隔开。第二个单词，表示第一个单词的值。
func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)!  Glad you could visit from \(hometown)."
}
print(greet(person: "Bill", from: "Cupertino"))
// Prints "Hello Bill!  Glad you could visit from Cupertino."

//使用下划线“_”忽略掉入参名。参数值不可缺少
func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
    // In the function body, firstParameterName and secondParameterName
    // refer to the argument values for the first and second parameters.
}
someFunction(1, secondParameterName: 2)



//函数入参初始值。若有初始值，则改函数调用时，可以忽略该参数
func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    // If you omit the second argument when calling this function, then
    // the value of parameterWithDefault is 12 inside the function body.
}
someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault is 6
someFunction(parameterWithoutDefault: 4) // parameterWithDefault is 12


//可变参数：Variadic Parameters。 函数入参用 类型... 表示函数的入参为可变。表示入参是一个数组： [类型]
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

//参数作用域 inout。 要想外部的变量，在函数内变化后，也支持改变。可以使用inout定义
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    a = a+b
    b = a - b
    a = a - b
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("somInt is \(someInt) anotherInt is \(anotherInt)")


//函数类型. 每个函数也代表一种类型。
//比如：addTwoInts/multiplyTwoInts 表示 (Int, Int) -> Int
func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}
func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}

//printHelloWorld 表示 () -> Void
func printHelloWorld() {
    print("hello, world")
}

//a. 我们可以用函数类型来表示某个变量类型
//定义一个变量mathFunction，他的类型是 (Int, Int) -> Int 。表示这个变量赋值需要2个入参，最后生成一个出参
var mathFunction: (Int, Int) -> Int = addTwoInts
print("mathFunction(2,3) type is addTwoInts and inferred as:  \(mathFunction(2,3))")
mathFunction = multiplyTwoInts
print("mathFunction(2,3) type is multiplyTwoInts and inferred as:  \(mathFunction(2,3))")

//b. 我们也可以用函数类型来表示函数的参数。比如
func math(_ math:(Int , Int) -> Int , _ a: Int, _ b: Int){
    print("function type as parameter : \(math(a,b))")
}

math(addTwoInts, 3, 5)
math(multiplyTwoInts, 3, 5)

//c. 我们也可以用函数类型来表示函数的返回值
func returnMathType(_ isadd: Bool) -> (Int,Int) -> Int {
    return isadd ? addTwoInts : multiplyTwoInts
}
print("returnMathType(false)(3,4) infered as :\(returnMathType(false)(3,4))")
print("returnMathType(true)(3,4) infered as :\(returnMathType(true)(3,4))")

//函数嵌套。 可以在函数内定义函数。用来做函数类型
func nestedMath(useAdd: Bool) -> (Int, Int) -> Int{
    func nestedAdd(_ a: Int, _ b: Int) -> Int{
        return a + b
    }
    func nestedMutiply(_ a: Int, _ b: Int) -> Int {
        return a * b
    }
    return useAdd ? nestedAdd : nestedMutiply
}
print("nestedMath(useAdd: false)(5,5) infered as :\(nestedMath(useAdd: false)(5,5))")
print("nestedMath(useAdd: true)(5,5) infered as :\(nestedMath(useAdd: true)(5,5))")
