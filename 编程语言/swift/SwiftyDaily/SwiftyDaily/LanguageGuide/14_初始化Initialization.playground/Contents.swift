import UIKit

// 初始化是针对结构、枚举、类实例化前的一个预处理流程
// 这个过程包括初始化属性值、设置一系列其他操作。
// 存储属性在构造器中赋值时，它们的值是被直接设置的，不会触发任何属性观测器
// 初始化和函数一样定义，并且创建一个实例类型对象。和OC不一样，swift不需要返回一个self,
// 它的主要作用是用来确保实例被使用前的预处理。 初始化存储属性的方式有：
// 1. 可以通过初始化方法给默认值，
// 2. 也可以在定义时给一个默认值， 通过 等号 赋值 一个默认值。
// 3. 也可以通过入参的形式给初始化一个默认值。

// 初始化方法：Initializers

//    init() {
//        // perform some initialization here
//    }

struct Fahrenheit {
    var temperature: Double {
        willSet (newValue) {
            print("new value is :\(newValue) old is \(temperature)")
        }
    }
    var cn : Int = 10  //定义时直接初始化
    init() {  // 初始化方法内直接赋值
        temperature = 32.0
    }
    init(temperature: Double) { // 入参赋值
        self.temperature = temperature
    }
}
var f = Fahrenheit()
var x = Fahrenheit(temperature: 13.1)
print("The default temperature is \(f.temperature)° Fahrenheit x \(x.temperature)")
x.temperature = 15.6

// Prints "The default temperature is 32.0° Fahrenheit"

struct Fahrenheit2 {
    var temperature = 32.0
}

// 自定义初始化方法
// 通过入参自定义初始化方法
struct Celsius {
    var temperatureInCelsius: Double
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
}
let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
// boilingPointOfWater.temperatureInCelsius is 100.0
let freezingPointOfWater = Celsius(fromKelvin: 273.15)
// freezingPointOfWater.temperatureInCelsius is 0.0

// 参数名（Parameter Names）和参数标签（Argument Labels）
//    初始化器都是用init() 来定义
//    在调用构造器时，主要通过参数名和类型，来确定需要调用哪个初始化器。
//    如果你在定义构造器时没有提供参数的外部名字，Swift 会为每个构造器的参数自动生成一个跟内部名字相同的外部名。
//    如果参数和类型都相同，swift还提供参数标签来确定不同的初始话方法
//    你也可以使用 _ 来忽略参数标签
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        print(" parameres   red:\(red) green:\(green) blue:\(blue)")
        self.red   = red
        self.green = green
        self.blue  = blue
    }
    init(white: Double) {
        print(" parameres   white   \(white)")
        red   = white
        green = white
        blue  = white
    }
    
    init(forYou white: Double) {
        print(" argument label  forYou   \(white)")
        red   = white
        green = white
        blue  = white
    }
    
    init(forMy white: Double) {
        print(" argument label  forMy   \(white)")
        red   = white
        green = white
        blue  = white
    }
    init(_ white: Double) {
        print("argument label by underscore _ \(white) to ignore parames")
        red   = white
        green = white
        blue  = white
    }
}

let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
let defalut = Color(white: 0.3)  //默认入参
let formy = Color(forMy: 0.8)    //参数标签，初始化器1
let foryou = Color(forYou: 0.5)  //参数标签，初始化器2
let forTom = Color(0.7)         //参数标签，初始化器3

// 可选类型属性
// 如果实例在初始化时，实例属性可以不需要马上初始化，或者在后续某个时间在初始化值，
// 这个时候我们想在初始化时，让属性为nil， 我们可以声明他为 可选类型
// 常量类型的属性，可以在初始化时被赋值一次，之后不可再修改 (在初始化结束前，必须完成赋值)
// 属性可以在定义时提供一个默认值。 这样在初始化时，可以不需赋值。
struct SurveryItem {
    var answered: Bool = false // 定义时赋值一个默认值，在初始化时无需给值。
    var isResponse : Bool
    let question: String  // 常量类型属性
    var answer: String? { // 延后回答属性，无需在初始化时赋值。
        didSet(oldValue){
            print("didSet answer oldValue:\((oldValue ?? "not set")) newValue:\((answer ?? "not set")) for question: \(self.question)")
            if answer != oldValue {
                self.answered = true
            }
            if answer == nil {
                self.answered = false
            }else{
                self.isResponse = true
            }
        }
    }
    init(question: String){
        self.isResponse = false
        self.question = question
    }
}

var survery1 = SurveryItem(question: "which baskball star do you  like?")
var survery2 = SurveryItem(question: "how old are you?")
var survery3 = SurveryItem(question: "what is your email?")
//延后回答结果
survery1.answer = "kobe"
survery2.answer = "30"
survery3.answer = "a"
//survery3.answer =  nil
print("survery1.answered:\(survery1.answered) survery2.answered:\(survery2.answered) survery3.answered:\(survery3.answered) survery3.isResponse:\(survery3.isResponse)")

// 成员初始化器
// 对于结构类型来说，对于没有初始化值的成员属性，swift自动创建对应的初始化器函数
// 对于类类型来说，则不会自动创建，需要自定义初始化函数
struct Size {
    var width = 0.0, height = 0.0
}
let sizeByNone = Size()
let twoByTwo = Size(width: 2.0, height: 2.0)
let oneByWidth = Size(width: 2.0)
let oneByHeidgt = Size(height: 4.0)


class MySize {
    var width = 0.0, height = 0.0
}
let sizeByNone1 = MySize()
//let twoByTwo1 = MySize(width: 2.0, height: 2.0) // ❌ error case without define initailization
//let oneByWidth1 = MySize(width: 2.0) // ❌ error case without define initailization
//let oneByHeidgt1 = MySize(height: 4.0) // ❌ error case without define initailization


// 值类型的初始化代理
// 初始化器可以通过调用其它初始化器来完成实例的部分初始化过程。这一过程称为初始化器代理，它能减少多个初始化器间的代码重复。
// 值类型的代理委托： 结构、枚举由于不支持继承，所以其对应的初始化委托比较简单，它只能调用它提供的其他初始化器
// 类类型的代理委托： 与结构、枚举不同，类类型初始化器由于类支持继承，所以意味着类初始化器需要额外的职责，来保证所有的属性都被初始化
struct SWSize {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = SWSize()
    init() {} // 利用origin 和size有默认值的情况，不需要给成员属性初始化值。
    init(origin: Point, size: SWSize) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: SWSize) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let myRect = Rect(center: Point(x: 3,y: 3), size: SWSize(width: 30,height: 30))


//类继承（Class Inheritance）和初始化器（Initialization）
// 所以的类存储属性（包括继承的属性），在初始化结束时，都必须要完成初始值设置。
// 对于类类型初始化器，swift提供了两种初始化器来保证属性的完全初始化：
//  1. 指派型初始化器 （designated initializers）：类初始化的主要形式。和普通的初始化器一样，用init()表示
//                1.1 初始化类中提供的所有属性，并根据继承链往上调用父类的初始化器来实现父类的初始化。
//                1.2 每一个类都必须拥有至少一个指定初始化器
/*
                 init(parameters) {
                     statements
                 }
 */

class DesignatedSuperClass {
    var no1 : Int // 局部存储变量
    init(no1 : Int) {
        self.no1 = no1 // 初始化
    }
}
class DesignatedSubClass : DesignatedSuperClass {
    var no2 : Int // 新的子类存储变量
    init(no1 : Int, no2 : Int) {
        self.no2 = no2 // 初始化
        super.init(no1:no1) // 初始化超类
    }
}

let res = DesignatedSuperClass(no1: 10)
let res2 = DesignatedSubClass(no1: 10, no2: 20)

print("DesignatedSuperClass res 为: \(res.no1)")
print("DesignatedSubClass res2 为: \(res2.no1)")
print("DesignatedSubClass res2 为: \(res2.no2)")


//  2. 便利型初始化器 （Convenience Initializers）： 类初始化中比较次要的、辅助型的初始化器.用关键字 convenience 来声明init()
//                2.1 可以在同一个类中，定义便利初始化器来调用它的指定初始化器，并为其参数提供默认值。你也可以定义便利初始化器，来创建一个特殊用途或特定输入的实例。
//                2.2 便利初始化器不是必要的，只在有需要的时候，才为类提供便利初始化器。意图明确的便利初始化器，有助于减少你的初始化时间和简化你初始化操作。
/*
                 convenience init(parameters) {
                       statements
                 }
 */


// 类类型的初始化代理
// 为了简化指定初始化器和便利初始化器关系，swift设计了3个规则来处理初始化器直接的代理关系。
// 规则1： 当前类的指定初始化器必须调用它父类的指定初始化器
// 规则2： 便利初始化器只能调用当前类的其他初始化器（这里的其他初始化器：可以是指定型初始化器，也可以是另外一个便利型初始化器）
// 规则3： 便利初始化器最终都要调一个指派型初始化器
// 简化记住方式：
//  1. 指派型初始化器总是向上一级的初始化器
//  2. 便利型初始化器总是横向调用本类其他初始化器

/*
        Designated <-- convenience <-- convenience
         ↑      ↑
   Designated Designated <-- convenience <-- convenience
        ↑                       |
         -----------------------
 */


class DesignatedSuperClass2 {
    var no1 : Int // 局部存储变量
    init(no1 : Int) {
        print("init DesignatedSuperClass2")
        self.no1 = no1 // 初始化
    }
}

class DesignatedSubClass2 : DesignatedSuperClass2 {
    var no2 : Int
    init(no1 : Int, no2 : Int) {
        print("init DesignatedSubClass2 no1 and no2")
        self.no2 = no2
        super.init(no1:no1)
    }
    // 便利方法只需要一个参数
    override convenience init(no1: Int)  {
        print("convenience init DesignatedSubClass2")
        self.init(no1:no1, no2:0)
    }
    
    convenience init(no2: Int)  { // 添加override 时，表示重写，❌ error, 因为父类无init(no2: Int)
        print("convenience init DesignatedSubClass2")
        self.init(no1:60, no2:no2)
    }
    
    convenience init()  { // 去掉convenience 时 表示指定类型初始化器， ❌ error 调用self.inited 不满足指定类型向上调用要求
        print("init DesignatedSubClass2")
        self.init(no2:70)
    }
}
let res3 = DesignatedSuperClass2(no1: 20)
let res4 = DesignatedSubClass2(no1: 30, no2: 50)
let res5 = DesignatedSubClass2(no1: 40)
let res6 = DesignatedSubClass2(no2: 60)
let res7 = DesignatedSubClass2()
print("DesignatedSuperClass2 res3 为: \(res3.no1)")
print("DesignatedSubClass2 res4 为: \(res4.no1)")
print("DesignatedSubClass2 res4 为: \(res4.no2)")
print("DesignatedSubClass2 res5 no2为: \(res5.no2) no1: \(res5.no1)")
print("DesignatedSubClass2 res7 no2为: \(res7.no2) no1: \(res7.no1)")





// 两段式初始化 Two-Phase Initialization
// 类的初始化都是两段式（两个阶段）的：
//      第一阶段： 类初始化时，所有被定义的属性都要完成属性初始值赋予（可选类型除外）。过程如下：
//              1. 类的指定初始化器或者便利初始化器被调用
//              2. 类实例对象的内存被申请，此时内存还没有初始化分配值。
//              3. 指定初始化器确认当前类的存储属性都有一个值，此时存储属性的初始化值存储到内存中。
//              4. 指定初始化器向上调用父类初始化器，执行上述操作，为父类存储属性初始化值。
//              5. 重复向上调用链，直到最根节点。
//              6. 一旦到向上调用链的根节点，最终类的存储属性被确认有值后，这个实例的内存就被初始化好了。这个时候阶段一执行完成。

//      第二阶段： 在第一阶段属性都确定后（属性都被赋值后）。我们才可以在类初始化结束前，被允许对类的属性做进一步操作。过程如下：
//              1. 第一阶段完成后，各个指定初始化器可以进一步自定义自身特性。比如访问self, 修改自身属性，或者访问实例方法等等。
//              2. 最终，调用链上的便利性初始化器都可以自定义特性和调用self

// 两段式初始化在满足类继承的灵活性条件下，同时保证了类初始化的安全性。它同时阻止了类成员属性在初始化前被访问的；也阻止了属性值被其他初始化器，非预期的设置成其他值。
// swift 通过4个安全检测手段，来保证两段式没有错误的进行：
//      安全检测1：指定初始化器在向上代理调用父类指定初始化器前，必须完成自身类属性的初始值设置。
//      安全检测2：如果子类要赋值一个继承属性的值，则必须放在指派初始化器向上调用父类初始化器后面。
//      安全检测3：便利型初始化器如果要给一个属性赋值（类本身属性or继承的属性），都必须放在调用其他初始化器之后。
//      安全检测4：类实例的方法或者属性，只有在二段式的第一阶段结束后，才能被调用或者访问。


//Swift子类初始化，与OC子类初始化不一样。 它不默认继承父类的初始化。 如果子类的初始化器与父类指定初始化器一样，需要用override重写
class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
    init() {
        print("Vehicle init wheels: \(numberOfWheels)")
        self.VehicleChangeWheels()
    }
    
    func VehicleChangeWheels(){
        self.numberOfWheels = 1
        print("Vehicle VehicleChangeWheels : \(numberOfWheels)")
    }
}

let vehicle = Vehicle()
print("Vehicle: \(vehicle.description) ===== \n")
// Vehicle: 0 wheel(s)

class Bicycle: Vehicle {
    override init() { //重载父类指定类型初始化器
        print("Bicycle init begin ")
        super.init()  // 调用父类初始化器
        print("Bicycle init wheels change before : \(numberOfWheels)")
        numberOfWheels = 2
        print("Bicycle init wheels change after : \(numberOfWheels)")
        
    }
}
let bicycle = Bicycle()
print("Bicycle: \(bicycle.description) ===== \n")
// Bicycle: 2 wheel(s)

class Hoverboard: Vehicle {
    var color: String
    init(color: String) {
        self.color = color
        // super.init() implicitly called here
        
//        self.VehicleChangeWheels() //如果不显示调用super.init()，调用此方法会报错
    }
    override var description: String {
        return "\(super.description) in a beautiful \(color)"
    }
}

let hoverboard = Hoverboard(color: "silver")
print("Hoverboard: \(hoverboard.description)")
// Hoverboard: 0 wheel(s) in a beautiful silver


// 自动初始化器继承
// 如上所说，默认情况下，子类不继承父类的初始化器。 然而，在特定条件达到情况下，父类的初始化器会被子类自动继承。
// 假设你子类的新属性被赋值了默认值，那么以下2条规则会被适用：
//    1. 如果你的子类不定义任何指定初始化器，那么子类会自动继承父类的指定初始化器或者便利初始化器（所有初始化器？？？）
//    2. 如果你的子类实现了它父类所有的指定初始化器（无论是通过规则1继承所得，还是自定义实现），那么它会自动继承父类的所有便利初始化器。
class Food {
    var name: String
    init(name: String) {
        self.name = name //根节点。无需调用super.init()
    }
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

let mysteryMeat = Food()
// mysteryMeat's name is "[Unnamed]"


class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    override convenience init(name: String) { //规则2：实现了父类的指定初始化器，默认继承父类的便利初始化器。。 这里要用override声明重写
        self.init(name: name, quantity: 1)
    }
}

let oneMysteryItem = RecipeIngredient()    //继承Fool得到的便利初始化器init()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)

class ShoppingListItem: RecipeIngredient {  // 规则1： 不实现任何父类指定初始化器，自动继承父类所有初始化器.
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

let shop1 = ShoppingListItem()     //继承RecipeIngredient 所有的初始化器。
let shop2 = ShoppingListItem(name: "jo")
let shop3 = ShoppingListItem(name: "jo2",quantity: 3)


// 可失败的初始化器 Failable Initializers
// 有时候类、结构、枚举的初始化器，由于初始值无效，所以需要返回失败。这就是可选性失败初始化器。
// 声明用 init?() 表示可失败初始化器，同时内部要 有返回nil的case
// 你可以同时定义可失败初始化器和不可失败初始化器，并且他们有相同的参数类型和参数名

// 数字类型的可以失败初始化器
let wholeNumber: Double = 12345.0
let pi = 3.14159

if let valueMaintained = Int(exactly: wholeNumber) {
    print("\(wholeNumber) conversion to Int maintains value of \(valueMaintained)")
}
// Prints "12345.0 conversion to Int maintains value of 12345"

let valueChanged = Int(exactly: pi)
// valueChanged is of type Int?, not Int

if valueChanged == nil {
    print("\(pi) conversion to Int doesn't maintain value")
}
// Prints "3.14159 conversion to Int doesn't maintain value"

// 结构类型的可失败初始化器
struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}
let someCreature = Animal(species: "Giraffe")
// someCreature is of type Animal?, not Animal

if let giraffe = someCreature {
    print("An animal was initialized with a species of \(giraffe.species)")
}
// Prints "An animal was initialized with a species of Giraffe"

// 枚举类型的可失败初始化器
enum TemperatureUnit {
    // 开尔文，摄氏，华氏
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .Kelvin
        case "C":
            self = .Celsius
        case "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}


let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("这是一个已定义的温度单位，所以初始化成功。")
}

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("这不是一个已定义的温度单位，所以初始化失败。")
}



enum TemperatureUnit2: Character {
    case kelvin = "K", celsius = "C", fahrenheit = "F"
}

let fahrenheitUnit2 = TemperatureUnit2(rawValue: "F")
if fahrenheitUnit2 != nil {
    print("This is a defined temperature unit, so initialization succeeded.")
}
// Prints "This is a defined temperature unit, so initialization succeeded."

let unknownUnit2 = TemperatureUnit2(rawValue: "X")
if unknownUnit2 == nil {
    print("This isn't a defined temperature unit, so initialization failed.")
}
// Prints "This isn't a defined temperature unit, so initialization failed."

//传递失败初始化器。
//    类、结构体、枚举的可失败初始化器，可以横向调用自身其他失败初始化器。
//    对于子类，则可以向上调用失败初始化器。
//    可失败初始化器也可以代理到非可失败初始化器。
class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}


if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}
// Prints "Item: sock, quantity: 2"
if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("Unable to initialize zero shirts")
}
// Prints "Unable to initialize zero shirts"

if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
} else {
    print("Unable to initialize one unnamed product")
}
// Prints "Unable to initialize one unnamed product"
// 通过关键字override 重写可失败初始化器的各种喂食等工作
class Document {
    var name: String?
    // this initializer creates a document with a nil name value
    init() {}
    // this initializer creates a document with a nonempty name value
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}


class UntitledDocument: Document {
    override init() {
        super.init(name: "[Untitled]")!
    }
}

// 你也可以使用init!() 来表示可失败初始化器比如返回实例。


// 必须初始化器 Required Initializers
// 通过在初始化器前，添加required 表示。
// 每个继承该类的init 都必须用require 来重写初始化器。
// 子类声明require ，无需用override 声明
class SomeClass {
    required init() {
        // initializer implementation goes here
    }
}

class SomeSubclass: SomeClass {
    //子类也要实现对应的初始化器。通过required声明， 这里无需override 字段声明
    required init() {
        // subclass implementation of the required initializer goes here
    }
}

//通过给存储属性添加一个闭包或者方法来给初始值
//你可以用闭包、全局方法来为属性提供默认值
// 闭包后加（），表示告诉编辑器，这个闭包马上执行。如果不加，则表示将闭包赋值给属性，而不是将闭包值赋值给属性
class SomeClass2 {
    let someProperty: Int = {
        // create a default value for someProperty inside this closure
        // someValue must be of the same type as SomeType
        return -1
    }()
}

struct Chessboard {
    let boardColors: [Bool] = {
        var temporaryBoard: [Bool] = []
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}

let board = Chessboard()
print(board.squareIsBlackAt(row: 0, column: 1))
// Prints "true"
print(board.squareIsBlackAt(row: 7, column: 7))
// Prints "false"
