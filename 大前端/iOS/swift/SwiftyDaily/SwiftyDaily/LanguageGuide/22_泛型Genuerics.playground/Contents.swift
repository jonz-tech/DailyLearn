import UIKit

// # 泛型
//    泛型代码可以根据你定义的主题，编写一个灵活、可复用函数和可使用于任何类型的类型。你可避免编写重复的代码，而是用一种清晰抽象的方式来表达代码的意图。

// 泛型是swift功能强大特性之一，很多标准库都是用泛型设计。事实上在Swift语言指南里，你已经无意识的使用上了泛型。比如Array和Dictionary都是泛型集合。 你可以创建一个Int类型或者String类型的数组集合，同样的字典也可以自动存储不同的类型。

// # 01 泛型解决的问题
// 常见的交换参数方法，使用了In-Out参数
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
// Prints "someInt is now 107, and anotherInt is now 3"

func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}

//  上面上个方法，仅有类型的不同。所以可以通过泛型来写出唯一一个函数，它支持int，String，Double类型互换。
// PS: 对于互换值的两个参数，他们的类型都是必须是一样的。如果不一样，Swift编译器则会报错。

// # 02 泛型函数
// 格式：func funcname<T>(a: T, b: T) -> returnType { body }
// 泛型函数可以在任何类型上工作。以下是交换类型函数的泛型例子：

// T 表示任何函数
func swap<T>(a:inout T, b: inout T) -> Void {
    let tmp: T = a
    a = b
    b = tmp
}
var swapInt = 3
var anotherSwapInt = 107
swap(&swapInt, &anotherSwapInt)
// someInt is now 107, and anotherInt is now 3

var swapString = "hello"
var anotherSwapString = "world"
swap(&swapString, &anotherSwapString)
// someString is now "world", and anotherString is now "hello"

// # 03 类型参数
// 参数类型是根据泛型的占位符来确定的
// 格式：<T>，并且将占位符写在函数名后面。T不是实际类型名,它可以是任意类型。由于它是一个占位符，Swift不会真的去找这个不存在的T类型。

// # 04 类型参数命名
// 占位符类型通常用大写 T、U、V等表示，用 < 和 > 括起来


// # 05 泛型类型
// 除了泛型函数，Swift还允许自定义泛型类型。例如定义一个栈结构的泛型函数，它支持Int，String等类型
struct Stack<T> {
    var pool: [T] = []
    mutating func push(_ item: T){
        pool.append(item)
    }
    
    mutating func pop() -> T {
        let last = pool.removeLast()
        return last
    }
}
var stackInt = Stack<Int>()
stackInt.push(1)
stackInt.push(2)
stackInt.push(3)
let popInt = stackInt.pop()

var stackString = Stack<String>()
stackString.push("one")
stackString.push("two")
stackString.push("three")
let popString = stackString.pop()


// # 06 拓展泛型类型
// 泛型同样支持拓展，使用extension 表示
extension Stack {
    func root() -> T? {
        guard let first = self.pool.first else { return nil }
        return first
    }
}
stackInt.root()
stackString.root()

// # 07 类型限制
// 类型常量可以让告诉泛型函数，让它的类型基础自某个类、遵循某个协议或者某个协议组合。例如字典类型可以限制它的key是一个string类型。在 字典的描述中，字典键的类型必须是可哈希（hashable）的。也就是说，必须有一种方法能够唯一地表示它。字典键之所以要是可哈希的，是为了便于检查字典中是否已经包含某个特定键的值。若没有这个要求，字典将无法判断是否可以插入或替换某个指定键的值，也不能查找到已经存储在字典中的指定键的值
// 语法：
class SomeClass {
    
}
protocol SomeProtocol {
    
}
// 在一个类型参数名后面放置一个类名或者协议名，并用冒号进行分隔，来定义类型约束
func nameOfFunc<T: SomeClass, U: SomeProtocol>(a: T, b: U){
    //function body
}

//这里函数无法通过编译。问题出在相等性检查上，即 "if value == valueToFind"
//func findIndex2<T>(of valueToFind: T, in array:[T]) -> Int? {
//    for (index, value) in array.enumerated() {
//        // T类型不确定是否满足可比较方法，因此这里会变异报错
//        if value == valueToFind {
//            return index
//        }
//    }
//    return nil
//}


// Swift 标准库中定义了一个 Equatable 协议，该协议要求任何遵循该协议的类型必须实现等式符（==）及不等符（!=），从而能对该类型的任意两个值进行比较。所有的 Swift 标准类型自动支持 Equatable 协议
// 遵循Equatable协议的泛型类型
func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

// # 08 关联类型
// 当我们定义一个协议时，有时候我们希望能够临时声明一个类型，这个类型在后续实现时才确定它的确切类型。
//这个时候我们可以用关联类型来声明，关联类型格式：associatedtype HolderType
// 当我们要实现这个协议，对于关联类型。我们可以通过typealias HolderType = 真实类型 来告诉编译器HolderType是一个什么类型。
protocol Container {
    associatedtype Item //associatedtype声明Item是一个类型，我们临时称这个类型为Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

struct IntStack: Container {
    // original IntStack implementation
    var items: [Int] = []
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
// 这里说明Item 是Int类型。所以append方法、下标返回类型都是Int
// 事实上，如果你在上面的代码中删除了 typealias Item = Int 这一行，一切也可正常工作，因为 Swift 清楚地知道 Item 应该是哪种类型
    typealias Item = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}

// 你也可以使用泛型来让swift编译器推断关联类型
struct GenericAssociatedType<T>: Container {
    // original Stack<Element> implementation
    var items: [T] = []
    mutating func push(_ item: T) {
        items.append(item)
    }
    mutating func pop() -> T {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(_ item: T) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> T {
        return items[i]
    }
}

// 给存在类型添加关联类型

// Swift 的 Array 类型已经提供 append(_:) 方法，count 属性，以及带有 Int 索引的下标来检索其元素。这三个功能都符合 Container 协议的要求，也就意味着你只需声明 Array 遵循Container 协议，就可以扩展 Array，使其遵从 Container 协议。你可以通过一个空扩展来实现这点
extension Array: Container {
    //由于array已经有append、下标方法。所以这里可以是空实现体
}
//给拓展完Containner后，后续你就可以把Array当作Container使用

//给关联类型添加限制为遵循某个协议
protocol Container2 {
    //这里Item类型都必须遵循Equatable
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}


struct Stack2<Element: Equatable>: Container {
    typealias Item = Element
    // original Stack<Element> implementation
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

//关联类型里使用协议限制
protocol SuffixableContainer: Container {
    // 类型Suffix为关联类型，且类型必须遵循当前声明的SuffixableContainer协议。
    // 同时Suffix的Item类型要和 Container的Item一致。
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

extension Stack2: SuffixableContainer {
    
    func suffix(_ size: Int) -> Stack2 {
        var result = Stack2()
        for index in (count-size)..<count {
            result.append(self[index])
        }
        return result
    }
    // Inferred that Suffix is Stack.
}
var stackOfInts = Stack2<Int>()
stackOfInts.append(10)
stackOfInts.append(20)
stackOfInts.append(30)
let suffix = stackOfInts.suffix(2)


// # 09 泛型Where语句 （Generic Where Clauses）
// 类型限制让你能够为泛型函数、下标、类型的类型参数定义一些强制要求。你可以通过定义一个泛型where子句来实现
// 通过泛型 where 子句让关联类型遵某个特定的协议，或者某个特定的参数类型和关联类型必须是相同类型。
// 泛型语句定义： where关键字开始，紧跟关联类型、或者相同的类型和关联类型。
// 你可以在函数体或者类型的左大括号之前添加where子句。

// allItemsMatch 函数遵循以下条件
// 1. 函数有两个参数someContainer、anotherContainer，类型分别为C1、C2，且必须遵循Container类型
// 2. C1、C2类型的Item类型必须相等。 C1.Item == C2.Item
// 3. C1类型的item类型必须遵循Equatable协议。和2组合起来后，可以推断出C2.item类型也遵循Equatable

func allItemsMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherContainer: C2) -> Bool where C1.Item == C2.Item, C1.Item: Equatable {
    // 检测两个参数的count是否相等
    if someContainer.count != anotherContainer.count {
        return false
    }

    // 检测数组元素是否都相等
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    // 返回结果都相等
    return true
}

var stackOfStrings = Stack2<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"]

if allItemsMatch(stackOfStrings, arrayOfStrings) {
    print("All items match.") // Prints "All items match."
} else {
    print("Not all items match.")
}


// # 10 拓展泛型where语句
// 泛型where语句也支持extension能力
extension Stack2 where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}
if stackOfStrings.isTop("tres") {
    print("Top element is tres.") // Prints "Top element is tres."
} else {
    print("Top element is something else.")
}

struct NotEquatable { }
var notEquatableStack = Stack<NotEquatable>()
let notEquatableValue = NotEquatable()
notEquatableStack.push(notEquatableValue)
//notEquatableStack.isTop(notEquatableValue)  // Error

extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}
if [9, 9, 9].startsWith(42) {
    print("Starts with 42.")
} else {
    print("Starts with something else.") // Prints "Starts with something else."
}

extension Container where Item == Double {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        return sum / Double(count)
    }
}
print([1, 1200.0, 98.6, 37.0].average())

// # 11 分支上下文

extension Container {
    // 限制item为Int类型
    func average() -> Double where Item == Int {
        var sum = 0.0
        for index in 0..<count {
            sum += Double(self[index])
        }
        return sum / Double(count)
    }
    func endsWith(_ item: Item) -> Bool where Item: Equatable {
        return count >= 1 && self[count-1] == item
    }
}
let numbers = [1260, 1200, 98, 37]
print(numbers.average())
// Prints "648.75"
print(numbers.endsWith(37))

// 上述方法里，如果不用where限定，则需要通过extension 拓展where语句来声明，他们的能力是相同的
//extension Container where Item == Int {
//    func average() -> Double {
//        var sum = 0.0
//        for index in 0..<count {
//            sum += Double(self[index])
//        }
//        return sum / Double(count)
//    }
//}
//
//extension Container where Item: Equatable {
//    func endsWith(_ item: Item) -> Bool {
//        return count >= 1 && self[count-1] == item
//    }
//}

// # 12 关联类型泛型where语句
//你可以在关联类型后面加上具有泛型 where 的子句

protocol Container3 {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
//   Iterator的泛型 where 子句要求：无论迭代器是什么类型，迭代器中的元素类型，必须和容器项目的类型保持一致
    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
//    makeIterator() 则提供了容器的迭代器的访问接口。
    func makeIterator() -> Iterator
}
protocol ComparableContainer: Container3 where Item: Comparable { }

// # 13 泛型下标
//下标可以是泛型，它们能够包含泛型 where 子句。你可以在 subscript 后用尖括号来写占位符类型，你还可以在下标代码块花括号前写 where 子句

// 1. 在尖括号中的泛型参数 Indices，必须是符合标准库中的 Sequence 协议的类型。
// 2. 下标使用的单一的参数，indices，必须是 Indices 的实例。
// 3. 泛型 where 子句要求 Sequence（Indices）的迭代器，其所有的元素都是 Int 类型。这样就能确保在序列（Sequence）中的索引和容器（Container）里面的索引类型是一致的。
extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [Item]
        where Indices.Iterator.Element == Int {
            var result: [Item] = []
            for index in indices {
                result.append(self[index])
            }
            return result
    }
}
