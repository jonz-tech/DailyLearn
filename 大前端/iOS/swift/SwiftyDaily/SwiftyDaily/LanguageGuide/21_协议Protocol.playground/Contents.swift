import UIKit

// 在类中的函数叫方法，不在类中的函数叫函数。
// #协议
// 协议给函数、属性、和其他功能定义了一个原型。然后这个协议后续可以被类、结构和枚举等实现。
// 任何满足了这个协议的都被称为遵循了这个协议。
// 另一方面，任何声明遵循协议的，都必须实现这些协议方法。你可以定义个协议，并要求实现遵循这个高级用法。

// ## 协议语法
// 协议通过关键字 protocol 表示
protocol SomeProtocol {
    // protocol definition goes here
}

protocol FirstProtocol {
    // protocol definition goes here
}

protocol AnotherProtocol {
    // protocol definition goes here
}

// 结构遵循两个协议
struct SomeStructure: FirstProtocol, AnotherProtocol {
    // structure definition goes here
}

class SomeSuperClass {
    init (){
        
    }
}
// 如果类继承同时遵循协议，则继承对象写在协议前面
class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
    // class definition goes here
}



// ## 属性要求条件
// 协议可以要求遵循实现提供实例属性或者类型属性。协议不需要制定声明存储属性或者计算型属性。只需要指定属性名和类型。
// 协议也可以声明每个属性是需要getter 或者 setter/getter都需要。
// 如果一个协议要求属性需要setter/getter，那么这个属性实现不可以是一个常量存储属性，也不可以是一个只读计算型属性。
// 如果一个协议要求属性需要getter ，那么这个属性实现可以是任何类型属性。同时你也可以在你的代码里实现setter。
protocol SomeProtocol2 {
    var mustBeSettable: Int { get set } //读写属性
    var doesNotNeedToBeSettable: Int { get } // 只读属性
}
protocol AnotherProtocol2 {
    static var someTypeProperty: Int { get set } //前置类型属性读写
}

protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}
let john = Person(fullName: "John Appleseed") // john.fullName is "John Appleseed"


class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String { //计算型属性
        return (prefix != nil ? prefix! + " " : "") + name
    }
}
var ncc1701 = Starship(name: "Enterprise", prefix: "USS") // ncc1701.fullName is "USS Enterprise"

// ## 方法要求条件
// 协议可以要求实现类型指定实例方法和类型方法

// ## 可变方法要求条件


// ## 构造函数要求条件


// ## 协议作为类型


// ## 代理


// ## 拓展增加协议遵循


// ## 同步实现遵循协议


// ## 协议类型集合


// ## 协议继承


// ## 类专属协议


// ## 协议构成


// ## 检测协议遵循


// ## 可选类型要求条件


// ## 协议拓展

