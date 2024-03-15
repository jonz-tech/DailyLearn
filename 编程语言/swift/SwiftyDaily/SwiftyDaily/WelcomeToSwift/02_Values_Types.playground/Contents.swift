import UIKit

// Values
// let 声明一个常量。 声明的时候，赋予一个最终值
// format like -> let valueName : Type = value
let swift : String = "Swift is awsome! "

// var 声明一个变量. 声明一个可变类型
// format like -> var varName : Type = varValue
var swiftage : Int = 0
swiftage = 5
//print("\(swift)")
var greeting = "Hello, playground"

struct swifty {
    let swiftAge  = swiftage
    func  log()->String{
        return "\(swift). and it is \(swiftAge) old"
    }
}

let aSwift = swifty()
aSwift.log()

//Types
// value Types
// ## 数字类型和基础类型
// ### logic 逻辑类型
let isBoy : Bool = true //true, false

// ### Numbers 数字类型
let intAge : Int = 18               // Int
let floatHeight : Float = 1.78      // Float
let piValue : Double = 3.1415926    // Double

// ### Range 范围类型
let halfRage : Range = 0 ..< 8      // half open  not include upper scope
let closeRange : ClosedRange = 0 ... 8 //full open , include upper scope

// ### Error 错误类型
let error : Error
let result: Result<Int,Error>

// ### optional 可选类型
//short format
let aShortForm : Int? = Optional.none //meaning nil
//long format
let aLongForm : Optional<String> = Optional.some("hello !")

//包装成其他类型： if let, if guard let, switch 配合使用
if let aNewWrapper = aShortForm {
        print("\(aNewWrapper)")
}else{
     print("nil case")
}
// 可选类型添加默认值
let aString :Optional<String> = Optional.some("baidu.a") //optional.none
print("\(aString ?? "defalut nil case ")")

//安全的调用链式
let isALib = aString?.hasSuffix(".a")
print("is lib \(String(describing: isALib))")

//明确声明有值 !
let isALib2 = aString!.hasSuffix(".a")

// ## String and Text
// ### String
let aString3 : String = "Welcome!"
let aCharator: Character

// ### 编码和存储
let letterK: Unicode.Scalar = "K"
let kim: Unicode.Scalar = "김"
print(letterK, kim)

// ### 静态字符串
let emoji: StaticString = "\u{1F600}"
emoji.hasPointerRepresentation  //-> true
emoji.isASCII                   //-> false
emoji.unicodeScalar             //-> Fatal error!
emoji.utf8CodeUnitCount         //-> 4
emoji.utf8Start[0]              //-> 0xF0
emoji.utf8Start[1]              //-> 0x9F
emoji.utf8Start[2]              //-> 0x98
emoji.utf8Start[3]              //-> 0x80
emoji.utf8Start[4]              //-> 0x00

// ## 集合类型
let array : [Int]
let array2 : Array<String>
let dictionary:Dictionary<Int,String>
let dictionary2:[Int:String]

// ## set,optional set
let ingredients: Set = ["cocoa beans", "sugar", "cocoa butter", "salt"]
if ingredients.contains("sugar") {
    print("No thanks, too sweet.")
}

struct ShippingOptions: OptionSet {
    let rawValue: Int
    static let nextDay    = ShippingOptions(rawValue: 1 << 0)
    static let secondDay  = ShippingOptions(rawValue: 1 << 1)
    static let priority   = ShippingOptions(rawValue: 1 << 2)
    static let standard   = ShippingOptions(rawValue: 1 << 3)
    static let express: ShippingOptions = [.nextDay, .secondDay]
    static let all: ShippingOptions = [.express, .priority, .standard]
}

let aOpSet: ShippingOptions
//reference Types

let aSet : Set = [1,2,3,4]
