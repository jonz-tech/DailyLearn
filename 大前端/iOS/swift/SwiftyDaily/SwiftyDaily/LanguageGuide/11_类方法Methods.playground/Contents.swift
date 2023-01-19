import UIKit
// Method 方法也是类型。 类、结构体、枚举都可以定义实例方法
//    在 Swift 语言中，实例方法是属于某个特定类、结构体或者枚举类型实例的方法。
//
//    实例方法提供以下方法：
//
//        1. 可以访问和修改实例属性
//
//        2. 提供与实例目的相关的功能
//
//    实例方法要写在它所属的类型的前后大括号({})之间。
//
//    实例方法能够隐式访问它所属类型的所有的其他实例方法和属性。
//
//    实例方法只能被它所属的类的某个特定实例调用。
//
//    实例方法不能脱离于现存的实例而被调用。
//
//    实例方法： 在类、结构体、枚举里定义的方法，通过实例访问的方法

class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}
let counter = Counter()
// the initial counter value is 0
counter.increment()
// the counter's value is now 1
counter.increment(by: 5)
// the counter's value is now 6
counter.reset()
// the counter's value is now 0

// 每一个类型都有一个隐性的self属性，用于指向实例本身。
// self通常用在区别self.属性和方法参数的区别。
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}


//如果你确实需要在某个具体的方法中修改结构体或者枚举的属性，
//你可以选择变异(mutating)这个方法，然后方法就可以从方法内部改变它的属性；
//并且它做的任何改变在方法结束时还会保留在原始结构中。
struct Point2 {
    var x = 0.0, y = 0.0
//    mutating 用于声明可变方法。用来表示内部属性可修改
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
var somePoint2 = Point2(x: 1.0, y: 1.0)
somePoint2.moveBy(x: 2.0, y: 3.0)
print("The point is now at (\(somePoint2.x), \(somePoint2.y))")
// Prints "The point is now at (3.0, 4.0)"


// 方法还可以给它隐含的self属性赋值一个全新的实例，这个新实例在方法结束后将替换原来的实例。
struct Point3 {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point3(x: x + deltaX, y: y + deltaY)
    }
}


enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}
var ovenLight = TriStateSwitch.low
ovenLight.next()
// ovenLight is now equal to .high
ovenLight.next()
// ovenLight is now equal to .off


// 类型方法。 可类型属性一样，使用static,class 声明。
// 结构体、类、枚举都可以定义类型方法。
class SomeClass {
    var someMethodProperty: Int
    class func someTypeMethod() {
        // type method implementation goes here
        print("call some class: someTypeMethod")
        
    }
    init() {
        self.someMethodProperty = 0
    }
}
SomeClass.someTypeMethod()


// 当访问的方法有返回值， 且返回值未被使用，会有告警，此时可以用 _ 消除告警。
// 可以在方法定义时，用 @discardableResult  来表示忽略返回值。
struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1

    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel { highestUnlockedLevel = level }
    }

    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }

    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}


class Player {
    var tracker = LevelTracker()
    let playerName: String
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        // 这里会报未使用返回值。
        tracker.advance(to: level + 1)
    }
    init(name: String) {
        playerName = name
    }
}



//    方法的局部参数名称和外部参数名称
//    Swift 函数参数可以同时有一个局部名称（在函数体内部使用）和一个外部名称（在调用函数时使用
//
//    Swift 中的方法和 Objective-C 中的方法极其相似。像在 Objective-C 中一样，Swift 中方法的名称通常用一个介词指向方法的第一个参数，比如：with，for，by等等。
//
//    Swift 默认仅给方法的第一个参数名称一个局部参数名称;默认同时给第二个和后续的参数名称为全局参数名称。
//
//    以下实例中 'no1' 在swift中声明为局部参数名称。'no2' 用于全局的声明并通过外部程序访问。


