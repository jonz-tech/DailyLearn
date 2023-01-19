import UIKit

/*
 * Swift提供了一系列操作,来支持swift运行时的错误抛出、捕获、传递和操作恢复。
 */
// 错误类型： swift提供了一个Error的空协议类型，继承了这个协议，则swift会认为它是一个错误类型。

enum HTTP_ERR : Error{
    case HTTP_200
    case HTTP_404
    case HTTP_405
    case HTTP_501
    case HTTP_502
}
// throw: 当要抛出某个错误时，使用throw来抛出。
// 抛出后，表示流程无法继续执行.
// 当错误被抛出后，必须要有一段代码来响应处理，比如修复问题，使用替代方案，或者提示用户失败操作。

let aError = HTTP_ERR.HTTP_404
//throw aError

print("hello ")

// Swift有4种方式来响应处理Error
// 例如在调用函数抛出错误；使用do-catch 代码块包起来；用可选类型来替代错误；断言错误不在出现

// 1. 抛出函数 Throwing Functions： 声明一个函数可能返回一个错误，使用throw定义

// 在函数参数后，返回声明前，使用throws定义。如果无返回类型，则只声明throw.
func canThrowErrors() throws -> String? {
    
    return nil
}

func cannotThrowErrors() -> String{
    
    return ""
}
// 只有抛出函数，可以将错误传递出来。任何非抛出函数，如果有错误类型，只能在函数内部处理掉。

class HttpQuery{
    func queryFail() throws -> HTTP_ERR {
        throw HTTP_ERR.HTTP_404
    }
}

let query = HttpQuery()

// 抛出函数，要么用do-catch,try?,try!来处理错误；
//         要么继续把错误传递下去
//try query.queryFail()

// do-catch 语法
//    do {
//        try expression
//            statements
//    } catch pattern 1 {
//        statements
//    } catch pattern 2 where condition {
//        statements
//    } catch pattern 3, pattern 4 where condition {
//        statements
//    } catch {
//        statements
//    }

struct Item {
    var price: Int
    var count: Int
}
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}
class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    var coinsDeposited = 0

    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }

        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }

        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }

        coinsDeposited -= item.price

        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem

        print("Dispensing \(name)")
    }
}
let favoriteSnacks = [
    "Alice": "Chips",
    "Bob": "Licorice",
    "Eve": "Pretzels",
]
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}
// Prints "Insufficient funds. Please insert an additional 2 coins."

func nourish(with item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch is VendingMachineError {
        print("Couldn't buy that from the vending machine.")
    }
}

do {
    try nourish(with: "Beet-Flavored Chips")
} catch {
    print("Unexpected non-vending-machine-related error: \(error)")
}

// 将抛出的错误，传递给可选值。 当抛出错误时，可选类型的值为nil
// 使用 try? 可选访问抛出函数
func someThrowingFunction() throws -> Int {
    // ...
    return 0
}

let x = try? someThrowingFunction()

let y: Int?
do {
    y = try someThrowingFunction()
} catch {
    y = nil
}

func fetchDataFromDisk() throws -> Data? {
    // ...
    return nil
}

func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() {
        return data
    }
    if let data = try? fetchDataFromDisk() {
        return data
    }
    return nil
}

//当明确抛出函数，不会抛出错误时，可以用 try! 表示
// 此时，如果又抛出了错误。则会运行时错误

//指定清理操作
// 你可以声明一个defer {}的代码块，用于在你的代码执行完即将离开之前，用来做清理操作。
// 即使没有涉及到错误处理的代码，你也可以使用 defer 语句


//func processFile(filename: String) throws {
//    if exists(filename) {
//        let file = open(filename)
//        defer {
//            close(file)
//        }
//        while let line = try file.readline() {
//            // Work with the file.
//        }
//        // close(file) is called here, at the end of the scope.
//    }
//}
