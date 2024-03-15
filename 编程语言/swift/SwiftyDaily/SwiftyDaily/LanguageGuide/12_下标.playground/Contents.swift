import UIKit
//  下标 可以定义在类（Class）、结构体（structure）和枚举（enumeration）这些目标中，可以认为是访问对象、集合或序列的快捷方式，不需要再调用实例的特定的赋值和访问方法。
//    举例来说，用下标访问一个数组(Array)实例中的元素可以这样写 someArray[index] ，访问字典(Dictionary)实例中的元素可以这样写 someDictionary[key]。
//    对于同一个目标可以定义多个下标，通过索引值类型的不同来进行重载，而且索引值的个数可以是多个。

//    语法
//    下标允许你通过在实例后面的方括号中传入一个或者多个的索引值来对实例进行访问和赋值。
//    语法类似于实例方法和计算型属性的混合。
//    与定义实例方法类似，定义下标使用subscript关键字，显式声明入参（一个或多个）和返回类型。
//    与实例方法不同的是下标可以设定为读写或只读。这种方式又有点像计算型属性的getter和setter：

subscript(index: Int) -> Int {
    get {
        // 用于下标脚本值的声明
    }
    set(newValue) {
        // 执行赋值操作
    }
}

struct Subexample {
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
