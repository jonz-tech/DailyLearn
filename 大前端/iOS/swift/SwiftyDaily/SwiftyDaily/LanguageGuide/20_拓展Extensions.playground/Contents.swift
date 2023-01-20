import UIKit

// #拓展
/*
    扩展可以给一个现有的类，结构体，枚举，还有协议添加新的功能.它还可以给没有源码权限的类型，追加拓展(追加模型retroactive modeling)能力。
 它和OC的分类很相似，但是Swift的拓展是没有分类名的。
 Swift拓展可以做到的能力:
    1. 添加计算型实例属性和计算类型属性
    2. 定义实例方法和类方法
    3. 提供新的构造器
    4. 定义下标
    5. 定义和使用新的嵌套类型
    6. 使用已经存在的类型遵循一个协议
 在 Swift 中，你甚至可以扩展协议以提供其需要的实现，或者添加额外功能给遵循的类型所使用。
 
 扩展可以给一个类型添加新的功能，但是不能重写已经存在的功能。
 
 */


// ## 拓展语法

// 使用关键字 extension + 已存在的类型 {} 定义对一个类型的拓展

extension Array {
  // 在这里给 SomeType 添加新的功能
}

protocol AProtocol {
    
}

protocol BProtocol {
    
}

// 给类型增加一个或者多个协议
extension Array : AProtocol,BProtocol{
    
}

/*
 拓展对泛型也同样起作用，意味着你可以给以存在的泛型添加能力，或者给泛型添加新能力。
 
 对一个现有的类型，如果你定义了一个扩展来添加新的功能，那么这个类型的所有实例都可以使用这个新功能，包括那些在扩展定义之前就存在的实例。
 */


// ## 计算型属性

 // 拓展可以给已知类型，添加实例属性和计算类型属性。

// 下面的例子给Double类型添加了5个计算型实例属性
 extension Double {
     // 1km = 1000m
     var km: Double { return self * 1_000.0 }
     // 1m = 1m
     var m: Double { return self }
     // 1cm = 0.01m
     var cm: Double { return self / 100.0 }
     // 1mm = 0.001m
     var mm: Double { return self / 1_000.0 }
     // 1ft = 1/3.28084m //英尺转换
     var ft: Double { return self / 3.28084 }
 }

let oneInch = 25.4.mm
print("One inch is \(oneInch) meters")
// Prints "One inch is 0.0254 meters"
let threeFeet = 3.ft
print("Three feet is \(threeFeet) meters")
// Prints "Three feet is 0.914399970739201 meters"

// 校园运动场跑道总长度 2000米 + 300米+20厘米
let total = 2.km + 300.m + 20.cm
print("it‘s  \(total) meters")

// **** PS:  扩展可以添加新的计算属性，但是它们不能添加存储属性，或向现有的属性添加属性观察者。*****


// ## 初始化
/*
        扩展可以给现有的类型添加新的构造器。它使你可以把自定义类型作为参数来供其他类型的构造器使用，或者在类型的原始实现上添加额外的构造选项。
 
 **** 扩展可以给一个类添加新的便利构造器，但是它们不能给类添加新的指定构造器或者析构器。指定构造器和析构器必须始终由类的原始实现提供
 ****
 
 注意事项:
 1. 如果你使用扩展给一个值类型添加构造器，而这个值类型已经为所有存储属性提供默认值，且没有定义任何自定义构造器，那么你可以在该值类型扩展的构造器中使用默认构造器和成员构造器。
 
 2.  如果你已经将构造器写在值类型的原始实现中，则不适用于这种情况，如同 值类型的构造器代理 中所描述的那样。
 
 3.  如果你使用扩展给另一个模块中定义的结构体添加构造器，那么新的构造器直到定义模块中使用一个构造器之前，不能访问 self。
 */

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}

let defaultRect = Rect()
let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
   size: Size(width: 5.0, height: 5.0))

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))
// centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)


// ## 方法



// ##下标



// ## 嵌套类型
