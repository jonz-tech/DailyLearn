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

// ## 协议类型集合


// ## 协议继承


// ## 类专属协议


// ## 协议构成


// ## 检测协议遵循


// ## 可选类型要求条件


// ## 协议拓展

