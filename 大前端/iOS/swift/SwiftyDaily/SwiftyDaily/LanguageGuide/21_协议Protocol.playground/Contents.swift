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



// ## 协议类型
// 协议本身并不具备任何功能，但你可以把它当作一个完整能力的类型来表示。
// 协议类型，又被叫做“存在类型”，原因是它表示：存在一个类型,该类型遵循了协议T
// 其他非协议类型使用的场景，协议也可以作为类型使用：
//  1. 在方法、函数、构造器中作为参数类型或者返回类型。
//  2. 作为一个常量类型、变量类型或者属性类型。
//  3. 在数组、字典或者其他容器内作为类型项

// PS: 由于协议上一个类型，因此协议名称开头要用大写字母。
// 骰子类
class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    // 模拟扔骰子的过程
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}
// Random dice roll is 3
// Random dice roll is 5
// Random dice roll is 4
// Random dice roll is 5
// Random dice roll is 4

// ## 代理
// 代理上一个设计模式，它允许类或者实例对象将他们需要的一些功能，委托给其他类型的实例对象来提供。
// 这个设计模式的实现是：定义协议来封装那些需要被委托的功能，这样就能确保遵循协议的类型能提供这些功能。
// 委托模式可以用来响应特定的动作，或者接收外部数据源提供的数据，而无需关心外部数据源的类型。
// 为了防止强引用导致的循环引用，代理类型都要用弱引用类型表示。

// 骰子游戏协议
protocol DiceGame {
    var dice: Dice { get }
    func play()
}
// 骰子游戏代理协议
protocol DiceGameDelegate: AnyObject { //继承了AnyObject表示它是一个类类型。
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

// 蛇梯游戏协议实现类
class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    
    // 弱引用可选代理类型，由于是可选类型，默认值为nil
    // 协议代理类型，同时也是一个仅类类型，所以它可以用弱引用表示
    weak var delegate: DiceGameDelegate?
    
    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    
    func play() {
        square = 0
        delegate?.gameDidStart(self) //使用可选类型的链式访问DiceGameDelegate的方法
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}
// 骰子游戏代理DiceGameDelegate协议实现类
class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()
// Started a new game of Snakes and Ladders
// The game is using a 6-sided dice
// Rolled a 3
// Rolled a 5
// Rolled a 4
// Rolled a 5
// The game lasted for 4 turns


// ## 拓展增加协议遵循
// 对于一个已存在的类型，尽管你没有源码权限，你依然可以为类型拓展遵循某个协议，进而增加类型的一些能力。
// 拓展可以和协议一样，为已存在类型增加属性、方法和下标等能力。因此我们可以让拓展直接继承某个协议。

// PS: 对于已存在的实例类型，如果后续为这个类型增加拓展协议，那么这个实例依然可以使用拓展协议提供的能力。

protocol TextRepresentable {
    var textualDescription: String { get }
}

let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

print(d12.textualDescription)


extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}
print(game.textualDescription)

//### 有条件的遵循协议
// 在一些明确的条件情况下，泛型可能可以满足某些协议要求的一些能力。例如类型的某个通用参数都遵循了协议T
// 你可以在拓展一个类型能力时，定义一个泛型。让它可以根据需要循序不同的协议。

// 拓展了数组需要遵循协议TextRepresentable，并且它的元素也要遵循TextRepresentable类型
extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

var myDice = [d6, d12]
print(myDice.textualDescription) // Prints "[A 6-sided dice, A 12-sided dice]"
//myDice.append(1) //添加非遵循的类型，这里会编译报错。

// ### 拓展类型声明遵循某个协议
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}
extension Hamster: TextRepresentable {}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)

// PS：类型不自动遵循一个协议，所以类型要遵循某些协议，都需要显式的声明。

// ## 采用合成实现对象来遵循某个协议
// Swift提供了许多合成实现类型，例如Equatable（相等）、Hashable（哈希）和Comparable（对比）。
// 直接使用这些合成实现类型，意味着你无需重复写这些实现功能。
// Equatable：自定义类型使用Equatable合成类型，可使用场景：
//    * 结构体中的存储属性，可以遵循Equatable合成实现。
//    * 枚举关联类型遵循使用了Equatable合成实现。
//    * 枚举中无关联类型的。

//为了让Vector3D能够使用 == 比较方法，将Vector3D声明为遵循Equatable
struct Vector3D: Equatable {
    var x = 0.0, y = 0.0, z = 0.0
}

let twoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
let anotherTwoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
if twoThreeFour == anotherTwoThreeFour { //直接通过 == 来比较。
    print("These two vectors are also equivalent.")
}
// Hashable:自定义类型遵循Hashable合成实现，使用场景：
//  * 结构体中的存储属性，声明遵循Hashable合成实现。
//  * 枚举关联类型，声明遵循Hashable合成实现。
//  * 枚举无关联类型的

// Comparable： 自定义类型遵循Comparable合成实现，使用场景：
//  * 如果枚举类型有关联类型，那么它必须遵循Comparable协议。
//  * 声明遵循Comparable合成类型的类型，可以得到 < 操作符的合成实现，且无需自己编写任何关于 < 的实现代码。Comparable 协议同时包含 <=、> 和 >= 操作符的默认实现
enum SkillLevel: Comparable {
    case beginner
    case intermediate
    case expert(stars: Int)
}
var levels = [SkillLevel.intermediate, SkillLevel.beginner,
              SkillLevel.expert(stars: 5), SkillLevel.expert(stars: 3)]
for level in levels.sorted() {
    print(level)
}
// 打印 "beginner"
// 打印 "intermediate"
// 打印 "expert(stars: 3)"
// 打印 "expert(stars: 5)"

// ## 集合中的协议类型
// 协议类型可以被存储到数组、字典等集合中。
let things: [TextRepresentable] = [game, d12, simonTheHamster]
for thing in things {
    print(thing.textualDescription)
}
// A game of Snakes and Ladders with 25 squares
// A 12-sided dice
// A hamster named Simon

// ## 协议继承
// 一个协议可以继承一个到多个协议，并且可以在继承协议的基础上，进一步添加需求。
//协议基础语法和类的基础一样，同时继承多个协议用逗号分隔。
protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // protocol definition goes here
}

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

// SnakesAndLadders 拓展协议
extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
}

print(game.prettyTextualDescription)
// A game of Snakes and Ladders with 25 squares:
// ○ ○ ▲ ○ ○ ▲ ○ ○ ▲ ▲ ○ ○ ○ ▼ ○ ○ ○ ○ ▼ ○ ○ ▼ ○ ▼ ○


// ## 类专属协议
// 如果协议只想给类使用，那么可以定义协议继承自AnyObject，此时枚举和结构等类型不可使用该协议。
protocol SomeClassOnlyProtocol: AnyObject, InheritingProtocol {
    // class-only protocol definition goes here
}
//PS: 对于引用类型要继承的协议，应该使用类专属协议。

// ## 复合协议
// 一个类型同时基础多个协议是非常有用的，但有时候我们不想多定义一个类型，又可以临时表示某个协议组，我们可以使用复合协议来表示。
// 复合协议表示： 协议A & 协议B & ... ， 它并不表示一个新的类型，而是表示“ 任何同时遵循A & B协议的类型”，它不关心参数的具体类型，只要参数遵循这两个协议即可。

protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct APerson: Named, Aged { // Person是一个新类型，它遵循了Aged和Named协议。
    var name: String
    var age: Int
}

// 函数参数类型用复合协议表示
func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}
let birthdayPerson = APerson(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)
// 打印 “Happy birthday Malcolm - you're 21!”

class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
class City: Location, Named {
    var name: String
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}
// 任何同时遵循Location和Named的类型，其他不同时遵循这两个协议的类型被传入，都是不合法的。
func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name)!")
}
 
let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)

beginConcert(in: seattle) // 打印 "Hello, Seattle!"


// ## 检测类型遵循的协议
// 检测方式：
// 1. is: 遵循协议时返回true，不遵循时返回false
// 2. as?: 不遵循时返回nil，遵循时返回类型为协议类型的可选值
// 3. as!: 将协议强转为某个协议类型，如果强转失败会出发运行时错误。

protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}
class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}
class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]
for object in objects {
    if object is HasArea {
        print("Area is \((object as! HasArea).area)")
    } else {
//        let aObject = object as!HasArea  //强转失败报运行时错误
        print("\(object) that doesn't have an area")
    }
}

// ## 可选协议类型要求
// 对于协议中的部分能力，我们可能不是必须要实现的，这个时候我们可以将他们定义为可选类型。满足可选能力的协议类型，我们称为可选协议类型。
// 可选协议类型要求： 使用optional关键字作为前缀，表示该能力可选。
    // 对于要和Objective-c相互打交道的协议，如果协议能力时可选的，我们要用optional声明。
    // 并且由于协议被用于OC，所以协议名和可选部分都要加上 @objc
    // 标记 @objc 特性的协议，只能被OC类或者同样是 @objc 的类型使用，其他类以及结构体和枚举均不能遵循这种协议
// 标明 optional的方法和属性，他们的类型会自动变为可选类型。这种类型的调用，同样可以用可选链式类型的方式调用。

//协议前无需optional修饰
@objc protocol CounterDataSource {
    // 这里并不是表示返回为可选类型，而是这个increment函数类型为可选，类型表示为: (int -> String)?
    @objc optional func increment(forCount count: Int) -> Int
    // 定义一个可选的属性
    @objc optional var fixedIncrement: Int { get }
}

// 由于CounterDataSource时可选协议。
// 严格来说，你可以声明一个类来遵循CounterDataSource，并且这个类无需实现这些optional方法和属性。
// 技术上时允许的，但这并不会带来一个更好的数据展示方式。

class Counter {
    var count = 0
    var dataSource: CounterDataSource //这里如果声明为非可选
    func increment() {
        // 这里表示如果dataSource有increment方法，则调用。否则返回nil
        if let amount = dataSource.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource.fixedIncrement {
            count += amount
        }
    }
    init(data: CounterDataSource){
        self.dataSource = data
    }
}

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

var counter = Counter(data: ThreeSource())
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}
// 3
// 6
// 9
// 12

class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}
// -3
// -2
// -1
// 0
// 0

// ## 协议拓展

// 可以通过extension来为协议增加方法、构造器、下标以及计算型属性等能力。
// 你可以基于协议本身来实现这些功能，而无需在每个遵循的协议类型中都重复同样的实现，也无需使用全局函数。

// 1. 给协议RandomNumberGenerator拓展一个randomBool的方法，这个方法已经完成实现。
// 2. 所有继承RandomNumberGenerator的类型，都自动拥有一个randomBool的方法，并且无需每个都单独实现。
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}
let generator2 = LinearCongruentialGenerator()
print("Here's a random number: \(generator2.random())")
// Prints "Here's a random number: 0.3746499199817101"
//由于拓展RandomNumberGenerator原因，generator自动拥有一个randomBool方法。
print("And here's a random Boolean: \(generator2.randomBool())")
// Prints "And here's a random Boolean: true"

// 协议拓展可以为协议拓展实现，但不能增加其他协议的继承。 继承都要在定义协议处声明

// ### 协议拓展 提供默认实现
// 你可以用协议拓展来增加一个默认的方法实现或者计算型属性实现。
// 如果协议拓展增加了默认实现，在遵循协议的类型定义时，也为这些函数和属性提供了实现。那么会忽略协议拓展中的默认实现，以遵循类型实现为准。

// PS： 对于有协议拓展实现默认值的类型，它和可选类型协议区别是比较清晰的。 有协议拓展默认值的类型，遵循该协议的类型无需额外提供实现，同时也不需要用可选协议类型的链式调用方式。

extension PrettyTextRepresentable  {
    var prettyTextualDescription: String {
        return textualDescription
    }
}
// ### 给协议拓展增加限制
// 当你定义协议拓展的时候，在拓展的方法和属性前，你可以限制遵循这个协议的类型，都必须满足某些条件才有效。
// 给协议拓展增加限制的方式，在协议名后面多加 where 从句。

// 这里表示给Collection协议拓展一个allEqual的方法实现。
// 并且Collection集合中的元素都必须遵循 Equatable 协议，这样就可以使用 ==，!= 等比较操作
extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}

let equalNumbers = [100, 100, 100, 100, 100]
let differentNumbers = [100, 100, 200, 100, 200]
let notEquatable: [Any] = ["100", 100, 200, 100, 200]
print(equalNumbers.allEqual()) // Prints "true"
print(differentNumbers.allEqual()) // Prints "false"

// 这里会报运行时错误，因为不满足Equatable，所以notEquatable对象，没有获得协议拓展的allEqual方法。
//print(notEquatable.allEqual())
