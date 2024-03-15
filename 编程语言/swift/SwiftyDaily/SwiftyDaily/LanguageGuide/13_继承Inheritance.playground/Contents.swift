import UIKit

// 一个类可以继承另外一个类的属性、方法和它的其他特性。
// 正在继承的类，叫做子类 subclass
// 被继承的类， 叫做父类 superclass


//不继承任何类的类，被称为基类 base Class
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // do nothing - an arbitrary vehicle doesn't necessarily make a noise
    }
}
let someVehicle = Vehicle(）
print("Vehicle: \(someVehicle.description)")
                          
                          
//  子类 Subclassing
class Bicycle: Vehicle {
    var hasBasket = false
}
let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15.0
print("Bicycle: \(bicycle.description)")


class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassengers = 2
tandem.currentSpeed = 22.0
print("Tandem: \(tandem.description)")
// Tandem: traveling at 22.0 miles per hour


// 重写： Overriding
//子类可以自定义实现实例方法、类型方法、实例属性、类型属性、下标等等继承自子类的特性。这些都是可以被重写的。
// 定义重写： override， 如果不声明override ，则会报错


//访问超类的方法、属性及下标
// 通过super.xxx 访问父类的属性、方法、和下标
//方法    super.somemethod()
//属性    super.someProperty()
//下标    super[someIndex]

//重写方法，通过override 父类来声明该类为重写类
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}

let train = Train()
train.makeNoise()
// Prints "Choo Choo"

//重写属性

//    你可以提供定制的 getter（或 setter）来重写任意继承来的属性，无论继承来的属性是存储型的还是计算型的属性。
//
//    子类并不知道继承来的属性是存储型的还是计算型的，它只知道继承来的属性会有一个名字和类型。所以你在重写一个属性时，必需将它的名字和类型都写出来。
//
//    注意点：
//          1. 如果你在重写属性中提供了 setter，那么你也一定要提供 getter。
//
//          2. 如果你不想在重写版本中的 getter 里修改继承来的属性值，你可以直接通过super.someProperty来返回继承来的值，其中someProperty是你要重写的属性的名字。

class Circle {
    var radius = 12.5
    var area: String {
        return "矩形半径 \(radius) "
    }
}

// 继承超类 Circle
class Rectangle: Circle {
    var print = 7
    override var area: String {
        return super.area + " ，但现在被重写为 \(print)"
    }
}

let rect = Rectangle()
rect.radius = 25.0
rect.print = 3
print("Radius \(rect.area)")

class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}
let car = Car()
car.currentSpeed = 25.0
car.gear = 3
print("Car: \(car.description)")
// Car: traveling at 25.0 miles per hour in gear 3


//重写属性观察器

class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

let automatic = AutomaticCar()
automatic.currentSpeed = 35.0
print("AutomaticCar: \(automatic.description)")
// AutomaticCar: traveling at 35.0 miles per hour in gear 4

// 禁用重写
// 通过final 关键字来声明 类的属性、方法、下标等不可重写。
// 任何想要修改final的重写操作，都会报错。
// 任何继承final 类的子类，都会报错。
final class HorseCar: Car {
    
}
