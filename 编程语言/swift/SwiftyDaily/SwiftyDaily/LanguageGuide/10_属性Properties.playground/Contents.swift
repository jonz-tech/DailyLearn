import UIKit

/**
    对于特定的类、结构、枚举等类型，属性被它们用来关联存储一些常量或者变量值。
    属性分为计算型属性（Computed properties） 和存储型属性（Stored properties）
        计算型属性：用于计算而不是存储一个值。适用范围类、结构、枚举
        存储型属性：被用于结构和类的一部分，用于存储数据。数据可以是变量 var 或者常量 let
    此外你还可以用观察器来观察一个属性的变化
    你也可以使用属性包装器来服用属性的setter/getter
     你可以定义属性的时候提供一个默认值。也可以在初始化的时候赋值一个初始值
 */
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

class FixedLengthRangeClass {
    var firstValue: Int
    let length: Int
    init(firstValue: Int, length: Int) {
        self.firstValue = firstValue
        self.length = length
    }
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
// the range represents integer values 0, 1, and 2
rangeOfThreeItems.firstValue = 6
// the range now represents integer values 6, 7, and 8

//常量实例的结构题，当被定义为let时，无法修改其成员属性
let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
// this range represents integer values 0, 1, 2, and 3
//rangeOfFourItems.firstValue = 6
// this will report an error, even though firstValue is a variable property

let rangeOfFourItemsClass = FixedLengthRangeClass(firstValue: 0, length: 4)
rangeOfFourItemsClass.firstValue = 7

// 懒存储属性： Lazy Stored Properties
// 懒存储属性 默认初始化的时候不存储，只有在它首次被访问的时候，才会存储初始值。在声明前，使用lazy 表示这是一个懒存储属性
// 懒存储属性只能用var 声明
class DataImporter {
    /*
    DataImporter is a class to import data from an external file.
    The class is assumed to take a nontrivial amount of time to initialize.
    */
    var filename = "data.txt"
    // the DataImporter class would provide data importing functionality here
    init() {
        print("DataImporter is now inited \(self.filename)")
    }
}

class DataManager0 {
    var importer = DataImporter() //只有在首次访问时，才初始化。
    var data: [String] = []
    // the DataManager class would provide data management functionality here
}

class DataManager {
    lazy var importer = DataImporter() //只有在首次访问时，才初始化。
    var data: [String] = []
    // the DataManager class would provide data management functionality here
}

let manager0 = DataManager0()
manager0.data.append("Some data")
manager0.data.append("Some more data")
print("========== before manager0 call ==========")
print("manager0.importer.filename is \(manager0.importer.filename)")


let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
print("========== before importer call ==========")
print("manager.importer.filename is \(manager.importer.filename)")


// 计算型属性： 不做值存储，只通过set/get来进行计算
struct Point {
    var x = 0.0, y = 0.0
}
struct Size {
    var width = 0.0, height = 0.0
}
struct Rect {
    var origin = Point() //存储型属性
    var size = Size() //存储型属性
    var center: Point { //计算型性属性
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
}
var square = Rect(origin: Point(x: 0.0, y: 0.0),
                  size: Size(width: 10.0, height: 10.0))
let initialSquareCenter = square.center
// initialSquareCenter is at (5.0, 5.0)
square.center = Point(x: 15.0, y: 15.0)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
// Prints "square.origin is now at (10.0, 10.0)"

// setter短语法
// 与上面的center set代码不同 ，AlternativeRect 的setter 没有声明一个入参名 newCenter. 默认为用newValue作为新变化值。
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

//getter短语法
// 如果getter里，只有一条表达式。那么getter 中的return可以去掉。
struct CompactRect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            Point(x: origin.x + (size.width / 2),
                  y: origin.y + (size.height / 2))
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
}

// 只读计算型属性 （var 声明）
// 如果计算型属性只有getter方法，没有setter方法。则该属性为只读属性，
// 只读属性永远可以返回一个可读值，也可以通过.属性语法访问，但没法写改变该属性值。
// 计算型属性和只读计算型属性，都都只能用var修饰，因为他们的值不是固定的。let只能定义常量，一旦他们初始化。

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
// Prints "the volume of fourByFiveByTwo is 40.0"


// 属性观察器
//  属性观察器用于监控和响应属性值的变化，每次属性值被设置，都会调用属性观察器，甚至新值和旧值一样的时候，也会被调用。
// 使用观察属性的地方：
//  1. 自定义的存储属性
//  2. 被继承的存储属性 （被继承的属性，要使用观察者，都只能通过重写的该属性来添加观察者）
//  3. 被继承的计算型属性 （被继承的属性，要使用观察者，都只能通过重写的该属性来添加观察者）
//  对于计算型的属性，使用setter方法来观察和响应值的变化，而不是尝试去创建一个观察者。
//  你可以通过以下两种方式添加属性观察器
//  1. willSet 方法： 在属性值被存储之前，该方法会调用。如果用willSet，一个新的newValue常量值会被当做入参,你也可以指定一个特定常量名做入参。
//  2. didSet  方法： 在属性值被存储后，该方法会被调用。如果用didSet, 一个旧的oldValue常量值会被当做入参，你也可以定义一个特定名做旧值入参。
//  被继承的属性观察器，willSet和didSet 方法，在子类初始化时，只会在父类属性初始化后才被调用。尽管子类属性已经被设置，但在父类未初始化前，他们都不会被调用。

print("======================= \n")
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) { // 定义了一个新名来做新值
            print("superclass willSet About to set totalSteps to \(newTotalSteps)")
        }
        didSet { //使用了系统默认旧值oldValue
            if totalSteps > oldValue  {
                print("superclass didSet Added \(totalSteps - oldValue) steps")
            }
        }
    }
    
//    init() {
//        print("superclass  setpCounter inited")
//    }
    
    init(parames : Int) {
        self.totalSteps = parames
        print("superclass  setpCounter inited")
    }
}
let stepCounter = StepCounter(parames: 33)
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter.totalSteps = 896
// About to set totalSteps to 896
// Added 536 steps


stepCounter.totalSteps = 100


print("======================= \n")
class StepCounterMorePrint : StepCounter {
    override var totalSteps: Int {
        willSet(newTotalSteps) { // 定义了一个新名来做新值
            print("subClass About willSet totalSteps to \(newTotalSteps)")
        }
        didSet (anOldValue){ //使用了系统默认旧值oldValue
            if totalSteps > anOldValue  {
                print("subClass didSet Added \(totalSteps - anOldValue) steps")
            }else {
                print("subClass  didSet backforward \(anOldValue - totalSteps) steps")
            }
        }
    }
    
    override init(parames : Int) {
        super.init(parames: parames)
        print("subClass setpCounter inited")
    }
}

let stepCounter0 = StepCounterMorePrint(parames: 44)
stepCounter0.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter0.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter0.totalSteps = 596
// About to set totalSteps to 896
// Added 536 steps
stepCounter0.totalSteps = 100

// 如果声明一个观察属性，并且将它作为in-out参数传递到函数入参里。willSet和didSet总是会被调用。
// 这是因为函数在入参时（copy-in）和函数结束时被出参（copy-out），重写写回到属性中，都会调用willSet和didSet

// 属性包装器： 属性包装器将属性的存储和声明分为了2部分隔离的代码。 例如对于多个属性，都要做做线程安全检测和将它们的值存到数据库中。
// 此时你只需要用属性包装器写一套代码，并在多个属性前用对应的包装器声明即可。

// 定义一个属性包装器，你只需要在结构、枚举或者类中，
// 1.开头用 @propertyWrapper 声明
// 2.添加一个 wrappedValue 的属性
@propertyWrapper
struct TwelveOrLess {
    private var number = 0   //给属性包装器增加了一个初始值 0
    var wrappedValue: Int { //属性包装器，对指定的属性就行包装
        get { return number }
        set { number = min(newValue, 12) }
    }
}

struct SmallRectangle {
    @TwelveOrLess var height: Int //指定height 作为wrappedValue的包装值，对其增加get/get方法。
    @TwelveOrLess var width: Int
}

var rectangle = SmallRectangle()
print(rectangle.height) //height get值是wrappedValue中的get方法对应的值。height 的setvalue是wrappedValue 中的set方法。
// Prints "0"

rectangle.height = 10
print(rectangle.height)
// Prints "10"

rectangle.height = 24
print(rectangle.height)
// Prints "12"

//另外一种属性包装器。
struct SmallRectangle2 {
    private var _height = TwelveOrLess() //声明两个包装器内容。
    private var _width = TwelveOrLess()
    var height: Int { //返回值改为TwelveOrLess 的get和set
        get { return _height.wrappedValue }
        set { _height.wrappedValue = newValue }
    }
    var width: Int {
        get { return _width.wrappedValue }
        set { _width.wrappedValue = newValue }
    }
}


//设置属性包装器的初始值
// TwelveOrLess 定义numbber时，被初始化了一个值0. 这导致它包装的属性初始化时，不能被赋予其他初始值。
// 如果需要初始化其他自定义值，则需要给包装器定义一个初始化器。如下：
@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int

    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }

    init() {
        maximum = 12
        number = 0
    }
    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }
    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}
//当你不给属性一个特定值时，包装器用init()
struct ZeroRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}

var zeroRectangle = ZeroRectangle()
print(zeroRectangle.height, zeroRectangle.width)

//当你给属性一个特定值时，包装器用init(wrappedValue:)
struct UnitRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber var width: Int = 1   // 方式1， 包装器的属性值给值
    @SmallNumber(wrappedValue: 33) var x: Int //方式2， 包装器给值
}


var unitRectangle = UnitRectangle()
print("unitRectangle.height \(unitRectangle.height), width \(unitRectangle.width),x \(unitRectangle.x)")
// Prints "1 1"

//当你给属性2个特定值时，包装器用init(wrappedValue:maximum)
struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
}
var narrowRectangle = NarrowRectangle()
print(narrowRectangle.height, narrowRectangle.width)
// Prints "2 3"

narrowRectangle.height = 100
narrowRectangle.width = 100
print(narrowRectangle.height, narrowRectangle.width)
// Prints "5 4"

//属性包装器的隐射值：对于一个属性包装器，你可以用projectedValue 来隐射一个属性关联值。
// 1. 通过在属性包装器里定义一个 projectedValue 的属性。 设置为private(set)
// 2. 访问包装属性的映射值，通过$属性名来访问
@propertyWrapper
struct TwelveOrLess3 {
    private var number = 0   //给属性包装器增加了一个初始值 0
    private(set) var projectedValue: String
    var wrappedValue: Int { //属性包装器，对指定的属性就行包装
        get {
            return number
        }
        set {
            number = min(newValue, 12)
            if newValue > 12 {
                self.projectedValue = "bigger than 12"
            }else{
                self.projectedValue = "less than 12"
            }
            
        }
    }
    init(wrappedValue: Int) {
        self.projectedValue = "inited begin" // 必须在wrapperdValue前初始化
        self.wrappedValue = wrappedValue
    }
}

struct TL3 {
    @TwelveOrLess3 var x:Int = 1
    @TwelveOrLess3 var y:Int = 2
    @TwelveOrLess3(wrappedValue: 33) var z:Int
}
var cor = TL3()
print("TL3.x \(cor.x), y \(cor.y),z \(cor.z) wrapp.$z: \(cor.$z)")

//全局变量： 定义的变量在方法、类方法、闭包或者类型上下文的变量，都属于全局变量。全局变量都是懒加载，但不需要定义lazy
//本地变量： 定义的变量在方法、类方法、或者闭包体内的变量。只有存储型本地变量才可以使用包装器。

//类型属性： 通过 类型.属性名 去访问的属性，叫做类型属性。
// 定义一个结构体\枚举类型的类型属性，在其属性定义前加上 static 关键字
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
let aSomStruct = SomeStructure()
//❌ print("aSomStruct storedTypeProperty \(aSomStruct.storedTypeProperty) computedTypeProperty: \(aSomStruct.computedTypeProperty)") // is worng access

print("aSomStruct storedTypeProperty \(SomeStructure.storedTypeProperty) computedTypeProperty: \(SomeStructure.computedTypeProperty)")

enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
let aSomeEnume0 = SomeEnumeration.storedTypeProperty
let aSomeEnume1 = SomeEnumeration.computedTypeProperty
//print("aSomeEnume storedTypeProperty \(aSomeEnume0.storedTypeProperty) aSomeEnume: \(aSomeEnume1.computedTypeProperty)") // is worng access

print("aSomeEnume storedTypeProperty \(SomeEnumeration.storedTypeProperty) computedTypeProperty: \(SomeEnumeration.computedTypeProperty)")

// 定义一个类类型的类型属性. 有两种 static 和class 定义。 尽管类型属性作用域在结构体、枚举体和类体内，但其都属于全局变量
// class  表示这个属性可以该属性被继承类重写。
// static 定义的属性，依然可以被继承类读，但不能重写。
// 访问和写类类型属性，都是用 ” 类型.属性名 “ 的方式， 而不是用实例访问
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}


let aSomeClass = SomeClass()
// reset a new value
SomeClass.storedTypeProperty = "new store some value"
//❌ print("SomeClass storedTypeProperty \(aSomeClass.storedTypeProperty) computedTypeProperty\(aSomeClass.computedTypeProperty)")
print("SomeClass storedTypeProperty \(SomeClass.storedTypeProperty) computedTypeProperty\(SomeClass.computedTypeProperty) \(SomeClass.overrideableComputedTypeProperty)")


class SubSomeClass: SomeClass {
//    ❌ can not override write if not declare as class
//    static var computedTypeProperty: Int {
//        return 27
//    }
    override class var overrideableComputedTypeProperty: Int {
        return 333
    }
}

let aSubSomeClass = SubSomeClass()
// ❌ error case can not write
// SubSomeClass.overrideableComputedTypeProperty = 444
print("SubSomeClass storedTypeProperty \(SubSomeClass.storedTypeProperty) computedTypeProperty\(SubSomeClass.computedTypeProperty) \(SubSomeClass.overrideableComputedTypeProperty)")

// 查询和设置类型属性
print(SomeStructure.storedTypeProperty)
// Prints "Some value."
SomeStructure.storedTypeProperty = "Another value."
print(SomeStructure.storedTypeProperty)
// Prints "Another value."
print(SomeEnumeration.computedTypeProperty)
// Prints "6"
print(SomeClass.computedTypeProperty)
// Prints "27"

struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                // cap the new audio level to the threshold level
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                // store this as the new overall maximum input level
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()
leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
// Prints "7"
print(AudioChannel.maxInputLevelForAllChannels)
// Prints "7"
rightChannel.currentLevel = 11
print(rightChannel.currentLevel)
// Prints "10"
print(AudioChannel.maxInputLevelForAllChannels)
// Prints "10"
