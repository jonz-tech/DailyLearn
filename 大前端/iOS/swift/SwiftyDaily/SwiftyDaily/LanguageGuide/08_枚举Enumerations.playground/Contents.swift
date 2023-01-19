
/**
 枚举简单的说也是一种数据类型，只不过是这种数据类型只包含自定义的特定数据，它是一组有共同特性的数据的集合。

 Swift 的枚举类似于 Objective C 和 C 的结构，枚举的功能为:

 它声明在类中，可以通过实例化类来访问它的值。

 枚举也可以定义构造函数（initializers）来提供一个初始成员值；可以在原始的实现基础上扩展它们的功能。

 可以遵守协议（protocols）来提供标准的功能。
 */

//
//Swift中的枚举很强大
//enum中的 rawValue 是其中的计算属性
//如果声明的时候不指定枚举类型就没有rawValue属性(包括关联值)
//rawValue中的值存储在Mach-O中，不占用枚举的存储空间
//枚举值与rawValue不是同一个东西
//rawValue可以不写，如果是Int默认0，1，2…String等于枚举名称的字符串
//如果枚举中存在rawValue同时也会存在init(rawValue:)方法，用于通过rawValue值初始化枚举
//如果枚举遵守了CaseIterable协议，且不是关联值的枚举，我们可以通过enum.allCases获取到所有的枚举，然后通过for循环遍历
//我们可以使用switch对枚举进行模式匹配，如果只关系一个枚举还可以使用if case
//关联值枚举可以表示复杂的枚举结构
//关联值的枚举没有init方法，没有RawValue别名，没有rawValue计算属性
//enum可以嵌套enum，被嵌套的作用域只在嵌套内部
//结构体也可以嵌套enum，此时enum的作用域也只在结构体内
//enum中可以包含计算属性，类型属性但不能包含存储属性
//enum中可以定义实例方法和使用static修饰的方法，不能定义class修饰的方法
//如果想使用复杂结构的枚举，或者说是具有递归结构的枚举可以使用indirect关键字

// 1. Swif枚举的类型可以是 String\Character\Int\Float等等
// 2. Swift枚举没有默认值Int. 所以不会有起始值0,1,2 ..
// 3. 枚举用case表示枚举类型。可以换行表示单独一个，可以用逗号隔开多个case
// 4. 枚举类型的首字母应该用大写表示
//语法：
/**
 enum enumName  : Type  {     // :Type 类型可以忽略
     // enumeration definition goes here
 }
 */
//罗盘方向
enum CompassDirect {
    case north
    case south
    case east
    case west
}

enum CompassEnum {
    case north,south,east,west
}

var directionToHead = CompassDirect.west
//一旦directionToHead 被CompassDirect初始化后，可以简化掉CompassDirect。 直接用枚举Case 名来赋值
directionToHead = .east
print("direction \(directionToHead)")

// switch 中的枚举类型匹配
directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}
// Prints "Watch out for penguins"

// 当switch 没有全部声明case时，可以用一个default 表示其他case
let somePlanet = CompassEnum.east
switch somePlanet {
case .east:
    print("CompassEnum as east")
default:
    print("Not a safe CompassEnum")
}

enum CoffeCubSize :CaseIterable {
    case Tall //中杯
    case Grande //大杯
    case Venti  //超大杯
}

let numberOfChoices = CoffeCubSize.allCases.count
//let numberOfChoices2 = CoffeCubSize.AllCases // ???
print("\(numberOfChoices) CoffeCubSize ")

for sizeOfCub in CoffeCubSize.allCases {
    print(sizeOfCub)
}

enum Mobile {
    case iPhone, Sumsong, huawei, vivo, oppo, xiaomi, onePlus
}


//枚举关联不同类型值。
enum Barcode {
    case upc(Int, Int, Int, Int) //upc 类型为元组（Int, Int, Int, Int）
    case qrCode(String)  //qrcode 类型为String
}
//upc关联类型Int, Int, Int, Int）， 对应值为8, 85909, 51226, 3
var productBarcode = Barcode.upc(8, 85909, 51226, 3)

switch productBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
case .qrCode(let productCode):
    print("QR code: \(productCode).")
}


//初始值|原始值Raw values
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

//原始值 Raw values 和关联值Associated values  是不一样的。
//原始值 对于特定case, 值都是一样的。
//关联值，是你基于枚举case 创建的一个变量或者常量。他可以每次都不一样。

//隐式赋值原始值。
// 当你定义Int或者Sting类型的枚举值时，你无需为每个case显示赋值一个初始值。Swift会自动为你赋值。
//注意：如果声明的时候不指定枚举类型就没有rawValue属性(包括关联值)

enum Planet: Int {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune //default mercury = 0, other +1
}
let aPlanet = Planet.mars
print("aPlanet raw Value: \(aPlanet.rawValue)")

enum Planet2: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune //explicitly assigned default mercury = 1
}

let aPlanet2 = Planet2.mars
print("aPlanet2 raw Value: \(aPlanet2.rawValue)")

//对于String类型的枚举值。 它的原始值就是case对应的Sting 名
enum Planet3: String {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune //default mercury = mercury,other is same as case
}

let aPlanet3 = Planet3.mars
print("aPlanet3 raw Value: \(aPlanet3.rawValue)")


//用Raw value来初始化一个枚举类型. 对应为可选类型
let aPlanet4 = Planet3(rawValue: "jupiter")
print("aPlanet4 raw Value: \(aPlanet4?.rawValue)")


let aPlanet5 = Planet3(rawValue: "myPlanet")
print("aPlanet4 raw Value: \(aPlanet5?.rawValue)") //没有这个case


//递归枚举 Recursive Enumerations
// 递归枚举表示枚举的case关联值类型，也是一个枚举实例。例如:
enum Animal {
    case cat
    indirect case dog (_ a1: Animal,_ a2: Animal)
    case fish
    case bulldog
    case sheepdog
    
    func descript() {
        switch self {
            case let .cat:
                print("===> cat")
            default:
                print("unknow")
        }
    }
}

var dog = Animal.dog(Animal.sheepdog, Animal.bulldog)
var cat = Animal.cat
print("dog.dog \(dog.descript()) cat:\(cat)")
// 使用indirect 声明某些case 是递归枚举
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}
 

enum HttpResponse {
    case state(Int)
    indirect case success(_ code: Int,_ data: AnyObject)
    indirect case fail(_ code: Int,_ message: String)
}

let E404 = HttpResponse.fail(404, "not found")
let E403 = HttpResponse.fail(403, "not good")
print("e404: \(E404)")

    

enum Math {
    case number(Int)
    indirect case add(Math,Math)
    indirect case mutiply(Math,Math)
    indirect case div(Math,Math)
    indirect case sub(Math,Math)
    
  
}

func cacula(math: Math) -> Int {
    switch math {
    case let .number(value):
        return value
    case let .add(leftNumber, rightNumber):
        return cacula(math: leftNumber) + cacula(math: rightNumber)
    case let .mutiply(leftNumber, rightNumber):
        return cacula(math: leftNumber) * cacula(math: rightNumber)
    case let .div(leftNumber, rightNumber):
        return cacula(math: leftNumber) / cacula(math: rightNumber)
    case let .sub(leftNumber, rightNumber):
        return cacula(math: leftNumber) - cacula(math: rightNumber)
    }
}

let mathLeft = Math.number(5)
let mathRight = Math.number(3)
let mathAdd = Math.add(mathLeft, mathRight)
let mathMutiply = Math.mutiply(mathLeft, mathRight)
let mathDiv = Math.div(mathLeft, mathRight)
let mathSub = Math.sub(mathLeft, mathRight)
print("mathAdd: \(cacula(math: mathAdd))")
print("mathMutiply: \(cacula(math: mathMutiply))")
print("mathDiv: \(cacula(math: mathDiv))")
print("mathSub: \(cacula(math: mathSub))")
