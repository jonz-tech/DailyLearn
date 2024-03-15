import UIKit
//  下标 可以定义在类（Class）、结构体（structure）和枚举（enumeration）这些目标中，可以认为是访问对象、集合或序列的快捷方式，不需要再调用实例的特定的赋值和访问方法。
//    举例来说，用下标访问一个数组(Array)实例中的元素可以这样写 someArray[index] ，访问字典(Dictionary)实例中的元素可以这样写 someDictionary[key]。
//    对于同一个目标可以定义多个下标，通过索引值类型的不同来进行重载，而且索引值的个数可以是多个。

//    语法
//    下标允许你通过在实例后面的方括号中传入一个或者多个的索引值来对实例进行访问和赋值。
//    语法类似于实例方法和计算型属性的混合。
//    与定义实例方法类似，定义下标使用subscript关键字，显式声明入参（一个或多个）和返回类型。
//    与实例方法不同的是下标可以设定为读写或只读。这种方式又有点像计算型属性的getter和setter：
//    没有声明set、get 则默认为只读下标，此时可以移除get.

//subscript(index: Int) -> Int {
//    get {
//        // 用于下标脚本值的声明
//    }
//    set(newValue) {
//        // 执行赋值操作
//    }
//}

struct Subexample {
    // 如果赋值了初始值，则初始化时无需传递参数
    let decrementer: Int
    //只读
    subscript(index: Int) -> Int {
        return (decrementer / index)
    }
}
let division = Subexample(decrementer: 100)
print("100 除以 9 等于 \(division[9])")
print("100 除以 2 等于 \(division[2])")
print("100 除以 3 等于 \(division[3])")
print("100 除以 5 等于 \(division[5])")
print("100 除以 7 等于 \(division[7])")


struct AddExample{
    let addInt : Int
    subscript(index : Int) -> Int{
        return addInt + index
    }
}

let add = AddExample(addInt: 10)
print("3+9  等于 \(add[9])")


struct SwiftList{
    let myList : Array<Int>
    subscript(index: Int) -> Int {
        if myList.count > index && index >= 0{
            return myList[index]
        }else {
            return NSNotFound
        }
    }
}

let Index = -1
let list = SwiftList(myList: [3,4,5,7,10])
print("list[\(Index)]  等于 \(list[Index])")

struct MyDictionary {
    let keys : Array <String>
    let values : Array <String>
    subscript(akey : String) -> String  {
        if keys.contains(akey) {
            let index = keys.firstIndex(of: akey)
            if let aIndex = index {
                return values[aIndex]
            }
            return ""
        }else {
            return ""
        }
    }
}

let myStruct = MyDictionary(keys: ["bj","gz","sh"], values: ["beijing","guangzhou","shanghai"])
print("myStruct[gz]  等于 \(myStruct["gz"])")
// 下标是访问集合、数组、队列的简短访问方式。 你可以自由的在你的结构、类里定义下标
// 下标可以有多个入参，入参可以是任何类型。它也可以也有一个返回类型，类型是任何值
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

var matrix = Matrix(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2

struct MyPoint {
    var x: Double = 0
    var y: Double = 0
    subscript(x: Double, y: Double) -> MyPoint {
        return MyPoint(x: x, y: y)
    }
}

let myPoint = MyPoint()
let resetPont = myPoint[4,5]
print("myPoint \(myPoint) resetPont: \(resetPont)")


// 类型下标： 和class,枚举等一样。 用static 定义
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}
let mars = Planet[4]
print(mars)
