import UIKit

/* Types
 * 数据类型: Int
 * 浮点类型: Double,Float
 * 字符类型: String
 * 布尔类型: Bool
 * 集合类型: Array【有序】,
            Set【无序,值唯一】,
            Dictionary【无序,key-value】,
            Tuples 【元组】
 * 可选类型: Optional
 *
 * ps. swift 有明确的类型转换机制，不同类型操作需要转换成一致才可以
 */

// ## 数据类型:
//      有符号(signed: +inf,0,-inf): Int,Int8,Int16,Int32,Int64
//      无符号(unsigned:0,-inf): UInt,UInt8,UInt16,UInt32,UInt64
let minValue = UInt8.min  // 无符号UInt8类型最小值是0
let maxValue = UInt8.max  // 无符号UInt8类型最大值是255

//Int类型范围：在32位平台,Int 类型是Int32; 在64位平台,Int类型范围是Int64
//UInt类型范围：在32位平台,UInt 类型是UInt32; 在64位平台,UInt类型范围是UInt64
let maxYears : Int = Int.max
let minYears : Int = Int.min

// ## 浮点类型：
let doublePi:Double = Double.pi //Double：表示64位浮点类型. 15位小数精度
let floatPi:Float = Float.pi //Float: 表示32位浮点类型. 6位小数精度

// ## 类型安全与类型推断
// swift 是一门类型安全的语言，String类型的数据不能传Int。
// 但这不意味着你需要为每个变量定义类型，它会自动进行类型转换
let meaningOfLife = 42  //推断为Int
let pi = 3.14159        //推断为Double (浮点数默认推断类型).
let anotherPi = 3 + 0.14159 //推断为Double

//多进制类型声明
let decimalInteger = 17
let binaryInteger = 0b10001       // 17 二进制声明:      0b 开头
let octalInteger = 0o21           // 17 八进制声明:      0o 开头
let hexadecimalInteger = 0x11     // 17 十六进制声明:     0x 开头

//浮点数类型10的幂次方
let expSigned:Double = 1.25e2  //表示 1.25 x 102, or 125.0.
let expUnsigned: Double = 1.25e-2 //表示 1.25 x 10-2, or 0.0125
//2的幂次方
let fpSignedValue  : Double = 0xFp2  //means 15 x 2^2, or 60.0.
let fpUnsignedValue: Double = 0xFp-2 //means 15 x 2^-2, or 3.75.

// ## 类型转换
//let cannotBeNegative: UInt8 = -1  //❌ 无符号，不可以为负数
//let tooBig: Int8 = Int8.max + 1   //❌ 越界。
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one) //类型转换： SomeType(要转换的类型值)

let three = 3
let pointOneFourOneFiveNine = 0.14159
let piConver = Double(three) + pointOneFourOneFiveNine   //浮点类型转换

// ## 类型别名：给一个数据类型重新命名一个类型
typealias AudioSample = UInt8
let sameple = AudioSample.max

// ## 布尔值
let orangesAreOrange = true
let turnipsAreDelicious = false
let isBoy : Bool = false
let i = 1
//if i { //❌ 无法自动转换为bool类型
//
//}
if i == 1 { //✅ 条件判断
}

// ## 元组
let http404Error = (404, "Not Found")
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
let (justTheStatusCode, _) = http404Error  //不用到的类型，可以用_, 忽略其中一个类型。
print("The status code is \(justTheStatusCode)")
print("The status code is \(http404Error.0)")    //直接用索引，访问类型
print("The status message is \(http404Error.1)") //直接用索引，访问类型
let http200Status = (statusCode: 200, description: "OK")
print("The status code is \(http200Status.statusCode)")
print("The status message is \(http200Status.description)")

// ## 可选值
let possibleNumber = "1"
let convertedNumber = Int(possibleNumber) // convertedNumber类型是Int?
var serverResponseCode: Int? = 404
serverResponseCode = nil //非可选类型不可以赋值 nil
var surveyAnswer: String? //可选类型自动赋值为 nil
if convertedNumber != nil { //使用逻辑运算符判断可选类型是否为nil. ==, !=
    print("convertedNumber has an integer value of \(convertedNumber!).") //一旦明确可选类型有值，则可以用 “类型名!” 声明。
}

//if let constantName = someOptional { //绑定类型声明
//    statements
//}
print("My number is \(convertedNumber!)")
if let actualNumber = Int(possibleNumber) {
    print("The string \"\(possibleNumber)\" has an integer value of \(actualNumber)")
} else {
    print("The string \"\(possibleNumber)\" couldn't be converted to an integer")
}

if let convertedNumber = convertedNumber {
    print("My number is \(convertedNumber)")
}

if var convertedNumber = convertedNumber { //声明成为Var 表示块内部，该参数是变量
    convertedNumber = 1000
    print("My number is \(convertedNumber)")
}

/*
 * 常量声明: let constantname : Types = typesValue
 * 变量声明: var varname : Types = typesValue
 *
 * ps. 多个变量可以写在同一行，用逗号分开
 */
var x = 0.0, y = 0.0, z = 0.0 // 隐式声明类型
var welcomeMessage: String //显式声明类型
var red, green, blue: Double //多个变量声明为double类型

let π = 3.14159   //变量名可以是任何类型，如Unicode
let 你好 = "你好世界"
//⚠️⚠️ 变量名，不可以是空白符号、数学符号、箭头，语气助词、数字开头等等
let 🐶🐮 = "dogcow"


var friendlyWelcome = "Hello!"
friendlyWelcome = "Bonjour!"  //✅ allow

let languageName = "Swift"
//languageName = "Swift++" // ❌ not allow

/*
 * 打印：print()
 *
 * ps. \(数据)
 */

print("The current value of friendlyWelcome is \(friendlyWelcome)")
print("She is a boy ? \(isBoy)")


/*
 * 注释类型：
 * 单行注释: //
 * 多行注释: /*  注释内容  */
 */



/*
 * 分号: ;
 * Swift 不强制要求;结尾，你如果想加也可以。
 * 你也可以用; 分割同一行的代码
 */

/*
 * 错误控制：throws 需要使用try-catch配合抛出error.
 */
func makeASandwich() throws {
//    do {
//        try makeASandwich()
//        eatASandwich()
//    } catch SandwichError.outOfCleanDishes {
//        washDishes()
//    } catch SandwichError.missingIngredients(let ingredients) {
//        buyGroceries(ingredients)
//    }
}


/*
 * 调试断言：assert/assertionFailure
 * 先决条件: precondition/preconditionFailure
 *
 * assertionFailure和preconditionFailure都是直接挂掉，不用加判断条件。fatalError是致命错误，程序挂掉。
 */
let index = 1
let age = -3
assert(age >= 0, "A person's age can't be less than zero.")   //debug环境生效
assert(age >= 0)
precondition(index > 0, "Index must be greater than zero.")   //debug/release都生效
