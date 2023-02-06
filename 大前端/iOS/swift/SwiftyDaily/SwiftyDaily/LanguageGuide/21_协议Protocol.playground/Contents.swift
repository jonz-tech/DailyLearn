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
// 协议可以要求实现类型指定实例方法和类型方法。这些方法的声明和普通的实例和类方法声明一样，但它没有{}和方法体。
// 可以在协议中定义具有可变参数的方法，和普通方法的定义方式相同。但是，不支持为协议中的方法提供默认参数。

// 1. 协议中的类方法：用static和class作为关键字前缀。
 protocol StaticProtocol {
     static func someTypeMethod()
 }

// 2. 实例方法和普通的方法声明一样。
protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy:m))
        return lastRandom / m
    }
}
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// 打印 “Here's a random number: 0.37464991998171”
print("And another one: \(generator.random())")
// 打印 “And another one: 0.729023776863283”

// ## 异变方法要求条件
// 通常有些场景，我们需要用方法来改变实例属性或者实例本身，这个方法我们称为异变方法。
// 把mutating关键字，放在func关键字前面表示异变方法。协议中如果也需要异变方法，同样声明mutating即可。
protocol Togglable {
    mutating func toggle()
}
// PS:
// 1. 如果实现协议中的mutating 方法对象是类类型，则不用写mutating关键字。
// 2. 如果实现协议异变方法的对象是结构体和枚举，则必须写mutating关键字
enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}
var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()   // lightSwitch 现在的值为 .on

// ## 构造函数要求条件
// 同样也可以在协议中，声明你想要的构造函数。声明方式和构造函数的定义一样，但没有{}和构造体。
protocol SomeInitProtocol {
    init(someParameter: Int)
}

// 实现协议的对象是类的话，无论是指定构造器，还是便利构造起，你都必须给构造器实现方法加上require关键字。
// 好处是：可以确保所有子类也必须提供此构造器实现，从而也能遵循协议。
class SomeInitClass: SomeInitProtocol {
    required init(someParameter: Int) { //如果不声明require，这里会编译报错。
        // initializer implementation goes here
    }
}

// 如果类已经被标记为 final，那么不需要在协议构造器的实现中使用 required 修饰符。
// 因为 final 类不能有子类。。
final class FinalInitClass: SomeInitProtocol {
    required init(someParameter: Int) { //这里require是可选项，可加可不加。
        // initializer implementation goes here
    }
}

// 如果一个类继承了父类和协议，并且协议都有init方法。那么需要把require和override写上。
protocol SomeProtocol1 {
    init()
}

class SomeSuperClass1 {
    init() {
        // initializer implementation goes here
    }
}

class SomeSubClass: SomeSuperClass1, SomeProtocol1 {
    // "required" from SomeProtocol conformance; "override" from SomeSuperClass
    required override init() {
        // initializer implementation goes here
    }
}

// 可失败构造函数要求
// 对于协议定义，你也可以声明可失败构造函数。
// 1. 可失败构造器（init?）：可失败构造函数实现，可以是可失败的(返回nil)，或者不可失败的（不返回nil）。
// 2. 非可失败构造器（init）：不可失败构造函数实现，可以上不可失败（不返回nil），或者有可失败构造函数强制转换表示(init!)



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

