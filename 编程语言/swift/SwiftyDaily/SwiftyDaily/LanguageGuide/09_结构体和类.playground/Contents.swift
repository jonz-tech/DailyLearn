import UIKit
//Swift 结构体是构建代码所用的一种通用且灵活的构造体。
//
//我们可以为结构体定义属性（常量、变量）和添加方法，从而扩展结构体的功能。
//
//与 C 和 Objective C 不同的是：
//
//  1. 结构体不需要包含实现文件和接口。
//
//  2. 结构体允许我们创建一个单一文件，且系统会自动生成面向其它代码的外部接口。
//
//  3. 结构体总是通过被复制的方式在代码中传递，因此它的值是不可修改的 (DeepCopy)

/* Swift里 结构和类的共同点
    1. 定义属性来存储值
    2. 定义函数来提供功能性能力
    3. 通过定于语法来定义属性值的访问权限
    4. 定义初始化方法来设置初始化状态
    5. 在默认实现的基础上，通过拓展来实现功能性能力拓展 extend
    6. 通过一个确定的协议类型来提供标准的能力
 
  Swift里类比结构多出来的的能力
    1. 类可以通过继承，来获取另外一个类的特性。
    2. 类支持运行时的类型转换检测和类型实例解释
    3. 析构函数支持类实例释放一些被复制的资源
    4. 对于一个类实例，引用计数器的存在，一个类可以被多个对象持有
 */

//基于以上的不同，正常情况下建议用结构、枚举来定义数据类型。只有真正需要的情况下，才用类类型。


//定义： 结构体和类的定义，有比较多的共同点。

// 结构体
struct SomeStructure {
    // structure definition goes here
}
// 类
class SomeClass {
    // class definition goes here
}

//和其他的基础数据类型一样，结构体和类都代表Swift的一种数据类型。 所以这里要用大写字母开头来定义类型名
//通过小写驼峰命名法来定义成员变量、函数名等等。

struct HumanStructure {
    var hand, body, head,foot : String
    var height : Float
  
}

class HumanClass {
    var humanStruct =  HumanStructure(hand: "class.aHand", body: "class.abody", head: "class.ahead", foot: "class.afoot", height: 167)
    init() {
        
    }
    func eat(){
        
    }
}

//初始化定义
let humanStruct = HumanStructure(hand: "aHand", body: "abody", head: "ahead", foot: "afoot", height: 180)
let humanClass = HumanClass()

struct MyRect {
    var width = 0
    var height = 0
}
//通过点语法访问成员属性值
print("strut: \(humanStruct.body)")

//通过初始化来初始化类、结构的成员属性


//和结构不同，类没有一个默认的初始化函数

//通过成员初始化方法类定义一个结构实例
var rect = MyRect(width: 10,height: 10)
var aCopyRect = rect //重新生成一份副本
rect.width = 22
print("rect.width:\(rect) copyRect: \(aCopyRect)")
//结构和枚举是值类型。 所谓的值类型，是指类型对象被赋值时，都是被拷贝一份副本。
//值类型：integers, floating-point numbers, Booleans, strings, arrays and dictionaries, 结构体
enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
}
var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection //赋值，生成一份新副本
currentDirection.turnNorth()

print("The current direction is \(currentDirection)")
print("The remembered direction is \(rememberedDirection)")
// Prints "The current direction is north"
// Prints "The remembered direction is west"


//    结构体应用
//    在你的代码中，你可以使用结构体来定义你的自定义数据类型。
//
//    结构体实例总是通过值传递来定义你的自定义数据类型。
//
//    按照通用的准则，当符合一条或多条以下条件时，请考虑构建结构体：
//
//    1. 结构体的主要目的是用来封装少量相关简单数据值。
//    2. 有理由预计一个结构体实例在赋值或传递时，封装的数据将会被拷贝而不是被引用。
//    3. 任何在结构体中储存的值类型属性，也将会被拷贝，而不是被引用。
//    4. 结构体不需要去继承另一个已存在类型的属性或者行为。

//    举例来说，以下情境中适合使用结构体：
//
//    几何形状的大小，封装一个width属性和height属性，两者均为Double类型。
//    一定范围内的路径，封装一个start属性和length属性，两者均为Int类型。
//    三维坐标系内一点，封装x，y和z属性，三者均为Double类型。
//    结构体实例是通过值传递而不是通过引用传递。

// 对象引用类型： 被赋值时，赋值对象持有该对象的引用关系。
//类是对象引用类型. 以下tenEighty，alsoTenEighty 共同持有同一个类对象
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
//尽管用 let 声明的alsoTenEighty为常量，但由于引用关系原因。你仍然可以给对象改变属性值。
alsoTenEighty.frameRate = 30.0


// 不同于Struct 和enum 用复制的形式,由于类是对象引用类型，所以你可以用多个常量和变量来持有类引用对象。
// 这就要求我们需要一些手段来引用类型对象是否是同一个对象。
// 1. 相等的： ===
// 2. 不相等的： !==

if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}

// 对象引用类型实例被常量或者变量持有，这有点像OC\C里的指针。但它又不直接指向内存里的地址，也不需要你用 * 来修饰。
// 相反引用类型的定义，和你定义其他常量、变量一样。
