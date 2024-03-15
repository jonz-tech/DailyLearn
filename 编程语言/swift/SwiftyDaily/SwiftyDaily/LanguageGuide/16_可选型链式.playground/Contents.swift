import UIKit

/*
 * 可选型链式：Optional Chaining
 * 可行型链式是一个nil值时，处理查询、访问属性、方法、订阅的方式。
 * 如果可选值非空，则这些调用成功。如果可选值为nil,则这些调用返回nil.
 */
// 链式访问中，使用 ？ 表示可选值可能为空。
// 链式访问中，如果明确可选对象有值，则可以用 ！ 强制访问。 声明后，如果为nil时，则会触发运行时错误
class Person {
    var residence: Residence? //初始化时，可选类型默认值为nil
}

class Residence {
    var numberOfRooms = 1
}

let john = Person()
//let roomCount = john.residence!.numberOfRooms //使用 ！强制解包，会报运行时错误。
john.residence = Residence()
john.residence?.numberOfRooms = 10
if let roomCount = john.residence?.numberOfRooms {  // 使用 ? 表示可能为空的情况。如果有值，则赋值给roomCount
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}


class Residence1 {
     var rooms: [Room] = []
     var numberOfRooms: Int {
         return rooms.count
     }
     subscript(i: Int) -> Room {
         get {
             return rooms[i]
         }
         set {
             rooms[i] = newValue
         }
     }
     func printNumberOfRooms() {
         print("The number of rooms is \(numberOfRooms)")
     }
     var address: Address?
}

class Person1 {
    var residence: Residence1?
}
let john1 = Person1()
if let roomCount1 = john1.residence?.numberOfRooms {
    print("John's residence has \(roomCount1) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// Prints "Unable to retrieve the number of rooms."
func createAddress() -> Address {
    print("Function was called.")

    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"

    return someAddress
}

john1.residence?.address = createAddress()


// 访问方法
if john1.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}
// Prints "It was not possible to print the number of rooms."


//访问属性
if (john1.residence?.address = createAddress()) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.")
}

//访问下标

// getter
if let firstRoomName = john1.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}

// setter
john1.residence?[0] = Room(name: "Bathroom")
let johnsHouse = Residence1()
johnsHouse.rooms.append(Room(name: "Living Room"))
johnsHouse.rooms.append(Room(name: "Kitchen"))
john1.residence = johnsHouse

if let firstRoomName = john1.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}


// 下标访问
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72
// the "Dave" array is now [91, 82, 84] and the "Bev" array is now [80, 94, 81]


//多层调用链
if let johnsStreet = john1.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
// Prints "Unable to retrieve the address."

let johnsAddress = Address()
johnsAddress.buildingName = "The Larches"
johnsAddress.street = "Laurel Street"
john1.residence?.address = johnsAddress

if let johnsStreet = john1.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}


//函数方法中的调用链
if let buildingIdentifier = john1.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier).")
}
// Prints "John's building identifier is The Larches."
if let beginsWithThe =
    john1.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier doesn't begin with \"The\".")
    }
}
// Prints "John's building identifier begins with "The"."
