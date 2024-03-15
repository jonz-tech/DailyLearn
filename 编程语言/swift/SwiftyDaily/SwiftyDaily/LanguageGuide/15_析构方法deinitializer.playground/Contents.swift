import UIKit

// 析构方法： 在类实例对象释放前，会调用析构方法。
// 通过deinit 关键字表示析构方法
// 析构方法只在 类 类型才有。
// 用户不允许自己调用析构方法
// 析构方法没有()和入参




// Swift对象的释放也是遵循ARC
// 某些场景需要自己进行资源清理，所以需要在对象释放前进行清理。 因此你需要用到析构函数，
// 比如：类创建的时候，打开了一个文档进行操作，希望在释放时，将文档关闭。

// 析构方法格式：
// 无需 （）和入参
//deinit {
//    // perform the deinitialization
//}


class A {
    deinit {
        print("A class is deinit")
    }
}

class B : A {
    deinit {
        print("B class deinit")
    }
}

// 子类会继承父类的析构，父类的析构会在子类的析构后调用
var b: B? = B()
b = nil

//父类的析构总是会被调用，尽管子类没有定义析构方法
// 类实例对象不会释放，直到它的析构函数调用结束后

class Bank {
    static var coinsInBank = 10_000
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}


class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    deinit {
        Bank.receive(coins: coinsInPurse)
    }
}

var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
// Prints "A new player has joined the game with 100 coins"
print("There are now \(Bank.coinsInBank) coins left in the bank")
// Prints "There are now 9900 coins left in the bank"
